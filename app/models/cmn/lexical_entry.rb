class Cmn::LexicalEntry < ActiveRecord::Base
  belongs_to :lexicon, class_name: 'Cmn::Lexicon'

  scope :recent, -> { order(updated_at: :desc).limit(20) }

  validates_presence_of :lexicon

  def language
    Language(:cmn)
  end
end
