#require_relative 'cmn/lexicon'

class Lexicon < ActiveRecord::Base
  belongs_to :lexical_resource

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
