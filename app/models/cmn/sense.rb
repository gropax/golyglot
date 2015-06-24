class Cmn::Sense < Sense
  belongs_to :lexical_entry, class_name: 'Cmn::LexicalEntry', inverse_of: :senses
  has_many :examples, class_name: 'Cmn::Example', inverse_of: :sense
  has_many :sentences, class_name: 'Cmn::Sentence', inverse_of: :senses, through: :examples

  def language
    Language(:cmn)
  end
end
