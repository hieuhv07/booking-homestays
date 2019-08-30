# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @trends = Trend.newest
  end
end
