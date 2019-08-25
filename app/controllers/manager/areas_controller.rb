# frozen_string_literal: true

module Manager
  class AreasController < BaseController
    before_action :load_area, only: %i[edit update destroy]

    def create
      @area = Area.new area_params
      if @area.save
        render json: { message: t(".success"), type: "success" }
      else
        render json: { message: t(".error"), type: "error" }
      end
    end

    def edit
      @address = @area.addresses.order("created_at DESC")
    end

    def update
      if @area.update area_params
        flash[:success] = t ".success"
        redirect_to edit_manager_location_path(@area.location_id)
      else
        flash[:danger] = t ".danger"
        render :edit
      end
    end

    def destroy
      if @area.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".danger"
      end
      redirect_to edit_manager_location_path(@area.location_id)
    end

    private

    def area_params
      params.require(:area).permit :name, :location_id
    end

    def load_area
      @area = Area.find params[:id]
    end
  end
end
