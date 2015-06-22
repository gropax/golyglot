module LexicalEntriesHelper
  def lexical_entry_path(lexical_entry)
    "/#{lexical_entry.language.code}/lexical_entries/#{lexical_entry.id}"
  end

  def edit_lexical_entry_path(lexical_entry)
    "#{lexical_entry_path(lexical_entry)}/edit"
  end

  def lexical_entries_path(lexical_entry)
    "/" + lexical_entry.language.code + super
  end

  def new_lexicon_lexical_entries_path(lexicon, hsh = nil)
    lexicon_lexical_entries_path(lexicon) + "/new"
  end

  def quick_new_lexicon_lexical_entries_path(lexicon, hsh = nil)
    url = lexicon_lexical_entries_path(lexicon) + "/quick_new"
    hsh ? [url, hsh.to_query].join('?') : url
  end

  def quick_create_lexicon_lexical_entries_path(lexicon, hsh = nil)
    lexicon_lexical_entries_path(lexicon) + "/quick_create"
  end

  def import_lexicon_lexical_entries_path(lexicon)
    lexicon_lexical_entries_path(lexicon) + "/import"
  end

  def destroy_lexicon_lexical_entries_path(lexicon)
    "#{lexicon_lexical_entries_path(lexicon)}/destroy_multiple"
  end

  def edit_lexicon_lexical_entries_path(lexicon)
    "#{lexicon_lexical_entries_path(lexicon)}/edit_multiple"
  end

  def update_lexicon_lexical_entries_path(lexicon)
    "#{lexicon_lexical_entries_path(lexicon)}/update_multiple"
  end

  def collection_action_lexicon_lexical_entries_path(lexicon)
    "#{lexicon_lexical_entries_path(lexicon)}/collection_action"
  end

  def lexicon_lexical_entry_selection_path(lexicon)
    "#{lexicon_lexical_entries_path(lexicon)}/selection"
  end

  def clear_lexicon_lexical_entry_selection_path(lexicon)
    "#{lexicon_lexical_entries_path(lexicon)}/clear_selection"
  end
end
