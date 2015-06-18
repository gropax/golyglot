class Cmn::Lexicon < Lexicon
  has_many :lexical_entries, class_name: 'Cmn::LexicalEntry'

  def language
    Language(:cmn)
  end
end
