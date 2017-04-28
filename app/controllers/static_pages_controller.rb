class StaticPagesController < ApplicationController

  def homepage
    return redirect_to current_user if logged_in?
  end

end