class PoiShortSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :lat, :lng
end
