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

  def resources_path(type, lexicon)
    case type.to_sym
    when :lexical_entries then lexical_entries_path(lexicon)
    when :sentences then sentences_path(lexicon)
    else
      raise TypeError, "Unknown resource type: #{type}"
    end
  end

  def new_resources_path(type, lexicon)
    send("new_#{type}_path", lexicon)
  end

  def quick_new_resources_path(type, lexicon, opts = {})
    send("quick_new_#{type}_path", lexicon, opts)
  end

  def import_resources_path(type, lexicon)
    send("import_#{type}_path", lexicon)
  end

  def quick_create_resources_path(type, lexicon)
    send("quick_create_#{type}_path", lexicon)
  end

  def resource_selection_path(type, lexicon, opts = {})
    send("#{type.to_s.singularize}_selection_path", lexicon, opts)
  end

  def clear_resource_selection_path(type, lexicon)
    send("clear_#{type.to_s.singularize}_selection_path", lexicon)
  end
end
