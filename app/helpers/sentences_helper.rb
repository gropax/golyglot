module SentencesHelper
  include LexiconsHelper

  def sentence_path(sentence)
    "/#{sentence.language.code}/sentences/#{sentence.id}"
  end

  def edit_sentence_path(sentence)
    "#{sentence_path(sentence)}/edit"
  end

  def lexicon_sentences_path(lexicon)
    lexicon_path(lexicon) + "/sentences"
  end

  def sentences_path(sentence)
    "/" + sentence.language.code + super
  end

  def new_lexicon_sentences_path(lexicon, hsh = nil)
    lexicon_sentences_path(lexicon) + "/new"
  end

  def quick_new_lexicon_sentences_path(lexicon, hsh = nil)
    url = lexicon_sentences_path(lexicon) + "/quick_new"
    hsh ? [url, hsh.to_query].join('?') : url
  end

  def quick_create_lexicon_sentences_path(lexicon, hsh = nil)
    lexicon_sentences_path(lexicon) + "/quick_create"
  end

  def import_lexicon_sentences_path(lexicon)
    lexicon_sentences_path(lexicon) + "/import"
  end

  def destroy_lexicon_sentences_path(lexicon)
    "#{lexicon_sentences_path(lexicon)}/destroy_multiple"
  end

  def edit_lexicon_sentences_path(lexicon)
    "#{lexicon_sentences_path(lexicon)}/edit_multiple"
  end

  def update_lexicon_sentences_path(lexicon)
    "#{lexicon_sentences_path(lexicon)}/update_multiple"
  end

  def lexicon_sentence_selection_path(lexicon, hsh = {})
    url = "#{lexicon_sentences_path(lexicon)}/selection"
    hsh[:format] ? "#{url}.#{hsh[:format]}" : url
  end

  def clear_lexicon_sentence_selection_path(lexicon)
    "#{lexicon_sentences_path(lexicon)}/selection/clear"
  end
end
