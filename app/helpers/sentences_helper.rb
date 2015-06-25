module SentencesHelper
  include LexiconsHelper

  def sentence_path(sentence)
    "/#{sentence.language.code}/sentences/#{sentence.id}"
  end

  def edit_sentence_path(sentence)
    "#{sentence_path(sentence)}/edit"
  end

  def sentences_path(lexicon)
    lang = lexicon.language.code
    "/#{lang}/lexicons/#{lexicon.id}/sentences"
  end

  def new_sentences_path(lexicon, hsh = nil)
    sentences_path(lexicon) + "/new"
  end

  def quick_new_sentences_path(lexicon, hsh = nil)
    url = sentences_path(lexicon) + "/quick_new"
    hsh ? [url, hsh.to_query].join('?') : url
  end

  def quick_create_sentences_path(lexicon, hsh = nil)
    sentences_path(lexicon) + "/quick_create"
  end

  def import_sentences_path(lexicon)
    sentences_path(lexicon) + "/import"
  end

  def destroy_sentences_path(lexicon)
    "#{sentences_path(lexicon)}/destroy_multiple"
  end

  def edit_sentences_path(lexicon)
    "#{sentences_path(lexicon)}/edit_multiple"
  end

  def update_sentences_path(lexicon)
    "#{sentences_path(lexicon)}/update_multiple"
  end

  def sentence_selection_path(lexicon, hsh = {})
    url = "#{sentences_path(lexicon)}/selection"
    hsh[:format] ? "#{url}.#{hsh[:format]}" : url
  end

  def clear_sentence_selection_path(lexicon)
    "#{sentences_path(lexicon)}/selection/clear"
  end

  # Used in forms to switch between create and update routes depending on the
  # persisted status of the record.
  #
  def sentence_form_path(sentence)
    if sentence.new_record?
      sentences_path(sentence.lexicon)
    else
      sentence_path(sentence)
    end
  end
end
