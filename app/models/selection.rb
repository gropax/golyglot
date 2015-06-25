class Selection < ActiveRecord::Base
  belongs_to :user
  belongs_to :lexicon

  serialize :resource_ids, Array

  class Action < Struct.new(:url, :message); end
  serialize :action, Action

  validates_presence_of :user
  validates_presence_of :lexicon
  validates_uniqueness_of :lexicon, scope: [:user, :type]

  def resources
    remove_deleted_references!

    resources = lexicon.send(plural_resource_name).find(resource_ids)
    Kaminari.paginate_array(resources)
  end

  def count
    remove_deleted_references!
    resource_ids.count
  end

  def set(res)
    self.resource_ids = res.map(&:id)
  end

  def add!(res)
    selected = resource_ids.to_set
    to_add = res.map(&:id).to_set

    self.resource_ids = (selected + to_add).to_a
    self.save!

    # Returns the ids of entries really added
    (to_add - selected).to_a
  end

  def remove!(res)
    selected = resource_ids.to_set
    to_remove = res.map(&:id).to_set

    self.resource_ids = (selected - to_remove).to_a
    self.save!

    # Returns the ids of entries really removed
    (to_remove & selected).to_a
  end

  # If selection has a pending action, just empty the resource collection,
  # otherwise destroy the whole selection record.
  #
  def clear!
    if action?
      self.resource_ids = []
      save!
    else
      self.destroy!
    end
  end

  def action?
    !!self.action.url
  end

  def cancel_action!
    self.action = nil
    self.save!
  end

  def to_csv(options = {})
    res = self.resources
    klass = res.first.class
    klass.to_csv(options, res)
  end



  private

    def remove_deleted_references!
      self.resource_ids.select! { |id| resource_class.exists?(id) }
      self.save!
    end

    def plural_resource_name
      raise NotImplementedError
    end

    def resource_class
      raise NotImplementedError
    end
end
