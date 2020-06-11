# frozen_string_literal: true

require_relative './data_repository'
require_relative './location'
require_relative './proximity_filter'

filter = ProximityFilter.new(Location::DUBLIN, 100)
DataRepository.migrate('input.txt', 'output.txt') { |customers| filter.process(customers) }
