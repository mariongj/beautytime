class PagesController < ApplicationController

  def home
    @categories = Service.select(:category).distinct.map { |service| service.category }
  end
end
