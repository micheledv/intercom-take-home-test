intercom-take-home-test
=======================

### System setup

This project was developed with ruby 2.7.1 and uses bundler to manage its dependencies (essentially rspec).

Once these requisites are met, any of the Makefile tasks will take care of installing the bundle,
hence no futher setup is needed.

### Tests

Tests can be run typing `make test` from a terminal.

### Run

The app will generate its output in `output.txt`. This file is already provided.

To re-generate it, delete the file and type `make output` from a terminal.
