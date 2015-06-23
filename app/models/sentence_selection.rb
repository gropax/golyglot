class SentenceSelection < Selection
  alias_method :sentences, :resources

  def plural_resource_name
    :sentences
  end

  def resource_class
    Cmn::Sentence
  end
end
