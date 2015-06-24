class Cmn::Sentence < ActiveRecord::Base
  belongs_to :lexicon, class_name: 'Cmn::Lexicon', inverse_of: :sentences
  has_many :examples, class_name: 'Cmn::Example', inverse_of: :sentences
  has_many :senses, class_name: 'Cmn::Sense', inverse_of: :sentences, through: :examples

  scope :recent, -> { order(updated_at: :desc).limit(20) }
  scope :in, ->(lexicon) { where(lexicon: lexicon) }

  validates_presence_of :lexicon

  searchable do
    text :simplified, :traditional, :pinyin
    integer :lexicon_id
  end


  def self.to_csv(options = {}, sentences = self.all)
    CSV.generate(options) do |csv|
      csv << column_names
      sentences.each do |sentence|
        csv << sentence.attributes.values_at(*column_names)
      end
    end
  end


  def language
    Language(:cmn)
  end
end
