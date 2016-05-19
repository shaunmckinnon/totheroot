class PagesController < ApplicationController
  def letsencrypt
    # use your code here, not mine
    render text: Rails.application.secrets.letsencrypt
  end
end