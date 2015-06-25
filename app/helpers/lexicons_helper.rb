module LexiconsHelper
  def lexicon_path(lexicon)
    "/#{lexicon.language.code}/lexicons/#{lexicon.id}"
  end

  def lexical_entries_path(lexicon)
    lexicon_path(lexicon) + "/lexical_entries"
  end

  def lexicon_settings_path(lexicon)
    lexicon_path(lexicon) + "/settings"
  end

  #def search_lexical_entries_path(lexicon)
  #  lexical_entries_path(lexicon) + "/search"
  #end
end
