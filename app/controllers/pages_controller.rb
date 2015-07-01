class PagesController < ApplicationController

  def home
    @cities = Institute.select(:city).distinct.map { |institute| institute.city }
  end

end
