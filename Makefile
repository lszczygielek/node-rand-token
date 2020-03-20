MOCHA_OPTS= --check-leaks
REPORTER = tap
VERSION = $(shell node -e 'console.log(require("./package.json").version)')
PACKAGE_NAME = $(shell node -e 'console.log(require("./package.json").name)')

all: build test

check: test

build:
	npm install

test: jshint test-unit test-typings

test-unit:
	@NODE_ENV=test ./node_modules/.bin/mocha \
	  --reporter $(REPORTER) \
	  $(MOCHA_OPTS)

test-typings:
	@./node_modules/.bin/tsd

jshint:
	@./node_modules/.bin/jshint index.js

package: clean test
	npm pack

clean:
	rm -f $(PACKAGE_NAME)*.tgz

.PHONY: test clean
