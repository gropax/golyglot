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

  def destroy_lexicon_lexical_entries_path(lexicon)
    "#{lexicon_lexical_entries_path(lexicon)}/destroy_multiple"
  end

  def collection_action_lexicon_lexical_entries_path(lexicon)
    "#{lexicon_lexical_entries_path(lexicon)}/collection_action"
  end
end
