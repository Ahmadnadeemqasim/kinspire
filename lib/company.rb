module Company
  @@strings = { company_name: "Kinspire" }

  ##
  # Returns the hash of company strings.

  def Company.strings
    return @@strings
  end
end