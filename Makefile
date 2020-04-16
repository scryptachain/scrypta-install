TEST_IMAGE?=ubuntu:18.04
VERSION?=
CHANNEL?=

VOLUME_MOUNTS=-v "$(CURDIR)":/v
ENVSUBST_VARS=LOAD_SCRIPT_COMMIT_SHA

.PHONY: build
build: build/install.sh

build/install.sh: install.sh
	mkdir -p $(@D)
	LOAD_SCRIPT_COMMIT_SHA='$(shell git rev-parse HEAD)' envsubst '$(addprefix $$,$(ENVSUBST_VARS))' < $< > $@

.PHONY: test
test: build/install.sh
	docker run --rm -i \
		$(VOLUME_MOUNTS) \
		-w /v \
		-e VERSION \
		-e CHANNEL \
		$(TEST_IMAGE) \
		sh "$<"

.PHONY: clean
clean:
	$(RM) -r build/