class HomeController < ApplicationController

  def index
    expires_in 30.days, public: true
  end

end
