# frozen_string_literal: true

module Location
  MEAN_EARTH_RADIUS_KM = 6371
  DUBLIN = { latitude: 53.339428, longitude: -6.257664 }.freeze

  class << self
    def distance_between(point1, point2)
      MEAN_EARTH_RADIUS_KM * central_angle_for(point1, point2)
    end

    private

    def central_angle_for(point1, point2)
      lambda1, phi1 = *coordinates_deg_to_rad(point1)
      lambda2, phi2 = *coordinates_deg_to_rad(point2)
      delta_lambda = (lambda1 - lambda2).abs
      Math.acos(Math.sin(phi1) * Math.sin(phi2) + Math.cos(phi1) * Math.cos(phi2) * Math.cos(delta_lambda))
    end

    def coordinates_deg_to_rad(point)
      %i[longitude latitude].map do |coordinate|
        point[coordinate].to_f * Math::PI / 180
      end
    end
  end
end
