class NewsController < ApplicationController

  def list
    @news = NewsEvent.all
  end

  def event
    @event = NewsEvent.find(params[:id])
  end

end