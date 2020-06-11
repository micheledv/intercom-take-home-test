# frozen_string_literal: true

require_relative './location'

ProximityFilter = Struct.new(:center, :max_km) do
  def process(customers)
    close_enough = proc do |customer|
      Location.distance_between(center, customer) <= max_km
    end

    customers.select(&close_enough).sort_by { |customer| customer[:user_id] }
  end
end
