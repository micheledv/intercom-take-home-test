require './app/proximity_filter'

def sorted_asc?(items)
  items.each_cons(2).all? do |a, b|
    (a <=> b) <= 0
  end
end

RSpec.describe ProximityFilter, '#process' do
  let(:center) { Location::DUBLIN }

  let(:range_km) { 100 }

  let(:customers) do
    [
      { user_id: 7, latitude: 52.50083, longitude: -6.55778 }, # Enniscorthy, 96km
      { user_id: 9, latitude: 54.32814, longitude: -5.71529 }, # Downpatrick, 115km
      { user_id: 5, latitude: 53.27389, longitude: -7.48889 }  # Tullamore, 82km
    ]
  end

  subject { described_class.new(center, range_km) }

  it 'only includes customers within the given range' do
    expect(subject.process(customers)).to contain_exactly(customers[0], customers[2])
  end

  it 'returns filtered customers sorted by user id (asc)' do
    ids_from_results = subject.process(customers).map { |customer| customer[:user_id] }
    expect(sorted_asc?(ids_from_results)).to be true
  end
end
