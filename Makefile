all: build test

build:
	go install -v
	go build

test:
	go test -v -race ./...
