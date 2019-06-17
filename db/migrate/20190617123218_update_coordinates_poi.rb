# frozen_string_literal: true

class UpdateCoordinatesPoi < ActiveRecord::Migration[5.2]
  def change
    add_column :pois, :lat, :float, index: true
    add_column :pois, :lng, :float, index: true

    Poi.find_each do |poi|
      poi.update_attributes(
        lat: poi.coordinates.split(' ')[0].to_f,
        lng: poi.coordinates.split(' ')[1].to_f
      )
    end

    remove_column :pois, :coordinates
  end
end
