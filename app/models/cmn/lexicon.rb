class Cmn::Lexicon < Lexicon
  has_many :lexical_entries, class_name: 'Cmn::LexicalEntry', inverse_of: :lexicon
  has_many :sentences, class_name: 'Cmn::Sentence', inverse_of: :lexicon

  def language
    Language(:cmn)
  end
end
