module Cmn::LexicalEntriesHelper
  def cmn_lemma(lexical_entry)
    [
      lexical_entry.simplified,
      brackets(lexical_entry.traditional),
      lexical_entry.pinyin
    ].compact.join(" ")
  end

  def brackets(text)
    text.blank? ? nil : "【#{text}】"
  end
end
