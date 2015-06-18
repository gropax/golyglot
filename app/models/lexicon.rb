class Lexicon < ActiveRecord::Base
  belongs_to :lexical_resource

  validates_presence_of :lexical_resource
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :lexical_resource


  def self.new(params)
    language = params.delete(:language)
    if language
      l = Language(language)
      class_name = "#{l.code.capitalize}::Lexicon"
      class_name.constantize.new params
    else
      super
    end
  end

  def language
  end
end
