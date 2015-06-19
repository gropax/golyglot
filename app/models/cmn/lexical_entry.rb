class Cmn::LexicalEntry < ActiveRecord::Base
  TYPES = {
    bound_root: 10,
    word: 20,
    collocation: 30,
    proverb: 40
  }

  PARTS_OF_SPEECH = {
    verb: 10,
    noun: 20,
    adverb: 30,
    adjective: 40
  }

  enum lexical_entry_type: TYPES
  enum part_of_speech: PARTS_OF_SPEECH
  belongs_to :lexicon, class_name: 'Cmn::Lexicon'

  scope :recent, -> { order(updated_at: :desc).limit(20) }

  validates_presence_of :lexicon

  def language
    Language(:cmn)
  end

  def lexical_entry_type=(param)
    super(param.blank? ? nil : param.to_i)
  end

  def part_of_speech=(param)
    super(param.blank? ? nil : param.to_i)
  end
end
