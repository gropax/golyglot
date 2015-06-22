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
    belongs_to :lexicon, class_name: 'Cmn::Lexicon', inverse_of: :lexical_entries

  scope :recent, -> { order(updated_at: :desc).limit(20) }
  scope :in, ->(lexicon) { where(lexicon: lexicon) }

  validates_presence_of :lexicon

  searchable do
    text :simplified, :traditional, :pinyin

    integer :lexicon_id, :lexical_entry_type, :part_of_speech
  end


  def self.to_csv(options = {}, lexical_entries = self.all)
    CSV.generate(options) do |csv|
      csv << column_names
      lexical_entries.each do |lexical_entry|
        csv << lexical_entry.attributes.values_at(*column_names)
      end
    end
  end


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
