module ApplicationHelper
  require 'company'

  ##
  # Returns the full value for the HTML <title> element, with the optional page title attribute preceding.

  def html_title( page_title='' )
    base_title = Company.strings[:company_name]
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

end
