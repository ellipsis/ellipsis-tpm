# ellipsis-tpm - shell script package manager

all: test

tag:
	@sed -i 's/^TPM_VERSION=.*$$/TPM_VERSION=$(version)/' src/version.bash
	@git add src/version.bash
	@git commit -m v$(version)
	@git tag v$(version)

test: deps/bats deps/ellipsis
	@export TPM_NOTMUX=1;\
		export ELLIPSIS_PATH="$$(pwd)/deps/ellipsis";\
		deps/bats/bin/bats tests $(TEST_OPTS)

deps/ellipsis:
	@export ELLIPSIS_PATH="$$(pwd)/deps/ellipsis";\
		curl -Ls ellipsis.sh | sh


deps/bats:
	@mkdir -p deps
	git clone --depth 1 git://github.com/sstephenson/bats.git deps/bats


.PHONY: all tag test
