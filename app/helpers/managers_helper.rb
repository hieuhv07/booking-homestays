# frozen_string_literal: true

module ManagersHelper
  def select_of_types
    Room.type_rooms.keys.map { |t| [t.titleize, t] }
  end

  def build_location_for_rooms
    Location.sort_by_name.map { |l| [l.name, l.id] }
  end

  def select_room
    Room.all.map {|r| [r.name, r.id]}
  end

  def select_status
    Trend.statuses.keys.map {|s| [s.titleize, s]}
  end

  def set_status object
    if object.active?
      link_to("Active", convert_status_manager_trend_path(object),
        method: :patch, remote: true, class: "btn info custom-btn", id: "btn-set-#{object.id}")
    else
      link_to("Inactive", convert_status_manager_trend_path(object),
        method: :patch, remote: true, class: "btn info custom-btn", id: "btn-set-#{object.id}")
    end
  end
end
