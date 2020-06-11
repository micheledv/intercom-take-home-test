# frozen_string_literal: true

require 'json'

module DataRepository
  class << self
    def load(path)
      IO.readlines(path).map do |line|
        JSON.parse(line, symbolize_names: true)
      end
    end

    def dump(path, records)
      data = records.map do |record|
        JSON.dump(record)
      end.join("\n")

      IO.write(path, data)
    end

    def migrate(source_path, destination_path)
      data = self.load(source_path)
      dump(destination_path, yield(data))
    end
  end
end
