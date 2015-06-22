module SensesHelper
  def lexical_entry_senses_path(lexical_entry)
    "#{lexical_entry_path(lexical_entry)}/senses"
  end

  def sense_path(sense)
    "/#{sense.language.code}/senses/#{sense.id}"
  end

  def edit_sense_path(sense)
    sense_path(sense) + "/edit"
  end
end
