##
# Provide data about the company.

module Company
  @@strings = { company_name: "Kinspire" }

  ##
  # Returns the requested string.

  def Company.string( key )
    return @@strings[key]
  end
end