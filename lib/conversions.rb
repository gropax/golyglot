module Kernel
  def Language(arg)
    case arg
    when Language
      arg
    when Symbol, String
      if lang = LANGUAGES[arg.to_sym] then lang else
        raise TypeError, "Invalid language code: #{arg}"
      end
    else
      raise TypeError, "Can't convert #{arg.class} to Language"
    end
  end
end
