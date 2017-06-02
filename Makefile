GO_VERSION := latest
output_filter := build/{{.OS}}_{{.Arch}}/{{.Dir}}
current_dir := $(shell pwd)
project := $(notdir $(current_dir))
user := $(notdir $(shell dirname $(current_dir)))
container_dir := /go/src/github.com/$(user)/$(project)
container_dir_circle := /go/src/github.com/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}
circleci := ${CIRCLECI}
gitsha := $(shell git rev-parse HEAD)

all:
	gox -osarch darwin/amd64 -osarch linux/amd64 -output="$(output_filter)"

linux:
	gox -osarch linux/amd64 -output="$(output_filter)"

mac:
	gox -osarch darwin/amd64 -output="$(output_filter)"

vend:
ifndef glide
	$(shell curl https://glide.sh/get | sh)
endif
	glide install

clean:
	rm -rf build/
	rm -f go-license
	go clean

fmt:
	goimports -w $$(find . -type f -name '*.go' -not -path "./vendor/*")
