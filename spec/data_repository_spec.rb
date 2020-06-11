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

RSpec.describe DataRepository, '.migrate' do
  let(:dummy_processor) do
    proc do |records|
      records.select { |record| record[:key] == 'one' }
    end
  end

  around do |example|
    @source = Tempfile.new
    @destination = Tempfile.new

    @source.write <<~TEXT
      { "key": "one" }
      { "key": "two" }
    TEXT
    @source.close
    @destination.close

    example.run

    @source.unlink
    @destination.unlink
  end

  it 'modifies the content loaded from source into destination as yielded by block' do
    described_class.migrate(@source.path, @destination.path, &dummy_processor)
    data = described_class.load(@destination.path)
    expect(data).to eq([{ key: 'one' }])
  end
end
