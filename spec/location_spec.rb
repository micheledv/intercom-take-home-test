# frozen_string_literal: true

require './app/location'

RSpec.describe Location, '.distance_between' do
  let(:london) do
    { latitude: 51.509865, longitude: -0.118092 }
  end

  let(:san_francisco) do
    { latitude: 37.773972, longitude: -122.431297 }
  end

  let(:bangkok) do
    { latitude: 13.736717, longitude: 100.523186 }
  end

  let(:dublin_london) { 464 }

  let(:dublin_san_francisco) { 8179 }

  let(:dublin_bangkok) { 9861 }

  it 'returns the distance in km given two pairs of coordinates' do
    [
      [london, dublin_london],
      [san_francisco, dublin_san_francisco],
      [bangkok, dublin_bangkok]
    ].each do |(place, distance)|
      expect(described_class.distance_between(Location::DUBLIN, place)).to be_within(1).of(distance)
    end
  end
end
