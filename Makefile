all: test output
.PHONY: all

install:
	bundle install
	bundle binstub rspec-core
.PHONY: install

bin: install

test: bin
	bin/rspec --format doc
.PHONY: test

output: output.txt
.PHONY: output

output.txt:
	ruby app/app.rb
