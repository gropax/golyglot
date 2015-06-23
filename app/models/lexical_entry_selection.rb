class LexicalEntrySelection < Selection
  alias_method :lexical_entries, :resources

  def plural_resource_name
    :lexical_entries
  end

  def resource_class
    Cmn::LexicalEntry
  end
end
