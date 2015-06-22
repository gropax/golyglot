class Cmn::Sense < Sense
  belongs_to :lexical_entry, class_name: 'Cmn::LexicalEntry', inverse_of: :senses

  def language
    Language(:cmn)
  end
end
