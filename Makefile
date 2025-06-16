.PHONY: console

ROOT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

# Heroku stack to use for the console. This can be override by setting STACK
# (e.g. STACK=heroku-22 make console).
STACK ?= "heroku-24"

# Change stack to image with tag (e.g. heroku/heroku:24-build)
IMAGE := "heroku/$(shell echo ${STACK} | sed 's/-/:/')-build"

console:
	@docker pull --quiet $(IMAGE)
	@echo

	@echo "Console Help"
	@echo
	@echo "Specify a version to install:"
	@echo "    echo 3.1.5 > /env/MIMALLOC_VERSION"
	@echo
	@echo "To vendor mimalloc:"
	@echo "    bin/compile /tmp/build/{app,cache,env}"
	@echo

	@docker run --rm -ti \
		-v $(ROOT_DIR):/buildpack \
		-e "STACK=$(STACK)" \
		-e "CNB_LAYERS_DIR=/tmp/layers/mimalloc" \
		-w /buildpack $(IMAGE) \
		bash -c 'mkdir -p /tmp/build/{app,cache,env,layers/mimalloc}; exec bash'
