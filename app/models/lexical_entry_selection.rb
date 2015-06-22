class LexicalEntrySelection < ActiveRecord::Base
  belongs_to :user
  belongs_to :lexicon

  serialize :lexical_entry_ids, Array

  validates_presence_of :user
  validates_presence_of :lexicon
  validates_uniqueness_of :lexicon, scope: :user

  def lexical_entries
    remove_deleted_references!

    lexical_entries = lexicon.lexical_entries.find(lexical_entry_ids)
    Kaminari.paginate_array(lexical_entries)
  end

  def count
    remove_deleted_references!
    lexical_entry_ids.count
  end

  def add!(entries)
    selected = lexical_entry_ids.to_set
    to_add = entries.map(&:id).to_set

    self.lexical_entry_ids = (selected + to_add).to_a
    self.save!

    # Returns the ids of entries really added
    (to_add - selected).to_a
  end

  def remove!(entries)
    selected = lexical_entry_ids.to_set
    to_remove = entries.map(&:id).to_set

    self.lexical_entry_ids = (selected - to_remove).to_a
    self.save!

    # Returns the ids of entries really removed
    (to_remove & selected).to_a
  end

  private

    def remove_deleted_references!
      self.lexical_entry_ids.select! { |id| Cmn::LexicalEntry.exists?(id) }
      self.save!
    end
end
