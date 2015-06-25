module LexicalEntriesHelper
  def lexical_entry_path(lexical_entry)
    "/#{lexical_entry.language.code}/lexical_entries/#{lexical_entry.id}"
  end

  def edit_lexical_entry_path(lexical_entry)
    "#{lexical_entry_path(lexical_entry)}/edit"
  end

  def lexical_entries_path(lexicon)
    lang = lexicon.language.code
    "/#{lang}/lexicons/#{lexicon.id}/lexical_entries"
  end

  def new_lexical_entries_path(lexicon, hsh = nil)
    lexical_entries_path(lexicon) + "/new"
  end

  def quick_new_lexical_entries_path(lexicon, hsh = nil)
    url = lexical_entries_path(lexicon) + "/quick_new"
    hsh ? [url, hsh.to_query].join('?') : url
  end

  def quick_create_lexical_entries_path(lexicon, hsh = nil)
    lexical_entries_path(lexicon) + "/quick_create"
  end

  def import_lexical_entries_path(lexicon)
    lexical_entries_path(lexicon) + "/import"
  end

  def destroy_lexical_entries_path(lexicon)
    "#{lexical_entries_path(lexicon)}/destroy_multiple"
  end

  def edit_lexical_entries_path(lexicon)
    "#{lexical_entries_path(lexicon)}/edit_multiple"
  end

  def update_lexical_entries_path(lexicon)
    "#{lexical_entries_path(lexicon)}/update_multiple"
  end

  def lexical_entry_selection_path(lexicon, hsh = {})
    url = "#{lexical_entries_path(lexicon)}/selection"
    hsh[:format] ? "#{url}.#{hsh[:format]}" : url
  end

  def clear_lexical_entry_selection_path(lexicon)
    "#{lexical_entries_path(lexicon)}/selection/clear"
  end

  def cancel_action_lexical_entry_selection_path(lexicon)
    "#{lexical_entries_path(lexicon)}/selection/cancel_action"
  end

  # Used in forms to switch between create and update routes depending on the
  # persisted status of the record.
  #
  def lexical_entry_form_path(lexical_entry)
    if lexical_entry.new_record?
      lexical_entries_path(lexical_entry.lexicon)
    else
      lexical_entry_path(lexical_entry)
    end
  end
end
