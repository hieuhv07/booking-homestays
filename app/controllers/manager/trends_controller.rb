# frozen_string_literal: true

module Manager
  class TrendsController < BaseController
    before_action :load_trend, only: %i[edit update]

    def index
      @trends = Trend.newest.page(params[:pager]).per Settings.trend_per
    end

    def new
      @trend = Trend.new
    end

    def create
      @trend = Trend.new trend_params
      if @trend.save
        redirect_to manager_trends_path, success: t(".success")
      else
        flash.now[:danger] = t ".danger"
        render :new
      end
    end

    def edit; end

    def update
      if @trend.update trend_params
        redirect_to manager_trends_path, success: t(".success")
      else
        flash.now[:danger] = t ".danger"
        render :edit
      end
    end

    private

    def trend_params
      params.require(:trend).permit :name, :description
    end

    def load_trend
      @trend = Trend.find params[:id]
    end
  end
end
