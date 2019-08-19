# frozen_string_literal: true

module Manager
  class LocationsController < BaseController
    before_action :load_location, only: %i[edit update destroy]

    def index
      @locations = Location.newest.page(params[:page]).per Settings.location_per
    end

    def new
      @location = Location.new
    end

    def create
      check_params_favorites
      @location = Location.new location_params
      Location.transaction do
        @location.save!
        @favorite_new = @new.map { |n| FavoriteSpace.create! name: n }
        map_value_to_create
        redirect_to manager_locations_path, success: t(".success")
      end
    rescue StandardError => e
      redirect_to new_manager_location_path, danger: e.message
    end

    def edit
      @space = @location.location_favorites.map(&:favorite_space_id)
      @favorites_spaces = []
      @space.map do |fa|
        favorites = FavoriteSpace.find fa
        @favorites_spaces << favorites.name
      end
    end

    def update
      check_params_favorites
      Location.transaction do
        map_object_to_get_value
        check_and_save_location_favorites
        redirect_to manager_locations_path, success: t(".success")
      end
    rescue StandardError => e
      redirect_to edit_manager_location_path, danger: e.message
    end

    def destroy
      if @location.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".danger"
      end
      redirect_to manager_locations_path
    end

    private

    def location_params
      params.require(:location).permit :name
    end

    def load_location
      @location = Location.find params[:id]
    end

    def check_params_favorites
      @new = []
      @available = []
      params[:favorite].each do |fa|
        if FavoriteSpace.find_by(name: fa).present?
          availbale = FavoriteSpace.find_by name: fa
          @available << availbale
        else
          @new << fa
        end
      end
    end

    def map_value_to_create
      @favorite_new.map do |n|
        LocationFavorite.create! location_id: @location.id, favorite_space_id: n.id
      end
      @available.map do |a|
        LocationFavorite.create! location_id: @location.id, favorite_space_id: a.id
      end
    end

    def map_object_to_get_value
      @favorite_new = @new.map { |n| FavoriteSpace.create! name: n }
      @favorite_available_id = @available.map(&:id)
      @favorite_new_id = @favorite_new.map(&:id)
      @favorite_available_id |= @favorite_new_id
      @space_id = @location.location_favorites.map(&:favorite_space_id)
    end

    def check_and_save_location_favorites
      @space_id.map do |f|
        if LocationFavorite.find_by(location_id: @location.id, favorite_space_id: f).present?
          LocationFavorite.find_by(location_id: @location.id, favorite_space_id: f).destroy
        end
      end
      @favorite_available_id.map do |a|
        LocationFavorite.create! location_id: @location.id, favorite_space_id: a
      end
    end
  end
end
