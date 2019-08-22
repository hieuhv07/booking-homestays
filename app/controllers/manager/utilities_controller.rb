# frozen_string_literal: true

module Manager
  class UtilitiesController < BaseController
    def new
      @utility = Utility.new
    end

    def create
      @utility = Utility.new utility_params
      if @utility.save
        redirect_to manager_utilities_path, success: t(".success")
      else
        flash.now[:danger] = t ".danger"
        render :new
      end
    end

    private

    def utility_params
      params.require(:utility).permit :name
    end
  end
end
