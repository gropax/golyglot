module LexiconResourcesHelper
  include LexicalEntriesHelper, SentencesHelper

  def lexicon_resource_path(resource, type)
    case type.to_sym
    when :lexical_entry then lexical_entry_path(resource)
    when :sentence then sentence_path(resource)
    else
      raise TypeError, "Unknown resource type: #{type}"
    end
  end

  def lexicon_resources_path(lexicon, type)
    case type.to_sym
    when :lexical_entries then lexical_entries_path(lexicon)
    when :sentences then lexicon_sentences_path(lexicon)
    else
      raise TypeError, "Unknown resource type: #{type}"
    end
  end
end
