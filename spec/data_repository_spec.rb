# frozen_string_literal: true

require './app/data_repository'
require 'tempfile'

RSpec.describe DataRepository, '.load' do
  around do |example|
    @file = Tempfile.new
    @file.write <<~TEXT
      { "foo": "bar" }
      { "baz": 123 }
    TEXT
    @file.close

    example.run

    @file.unlink
  end

  it 'properly parses the records in the file' do
    data = described_class.load(@file.path)
    expect(data).to eq [
      { foo: 'bar' },
      { baz: 123 }
    ]
  end
end

RSpec.describe DataRepository, '.dump' do
  around do |example|
    @file = Tempfile.new
    @file.close

    example.run

    @file.unlink
  end

  let(:content) do
    [ { some: 'thing' }, { something: 'else' } ]
  end

  it 'properly stores the records in the file' do
    described_class.dump(@file.path, content)
    data = described_class.load(@file.path)
    expect(data).to eq(content)
  end
end
