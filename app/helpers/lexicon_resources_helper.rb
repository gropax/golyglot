module LexiconResourcesHelper
  include LexicalEntriesHelper, SentencesHelper

  def resource_path(resource, type)
    case type.to_sym
    when :lexical_entry then lexical_entry_path(resource)
    when :sentence then sentence_path(resource)
    else
      raise TypeError, "Unknown resource type: #{type}"
    end
  end

  def resources_path(lexicon, type)
    case type.to_sym
    when :lexical_entries then lexical_entries_path(lexicon)
    when :sentences then sentences_path(lexicon)
    else
      raise TypeError, "Unknown resource type: #{type}"
    end
  end

  def new_resources_path(lexicon, type)
    send("new_#{type}_path", lexicon)
  end

  def quick_new_resources_path(lexicon, type)
    send("quick_new_#{type}_path", lexicon)
  end

  def resource_selection_path(lexicon, type)
    send("#{type.to_s.singularize}_selection_path", lexicon)
  end
end
