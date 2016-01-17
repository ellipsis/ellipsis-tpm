# ellipsis-tpm - shell script package manager

all: test

tag:
	@sed -i 's/^TPM_VERSION=.*$$/TPM_VERSION=$(version)/' src/version.bash
	@git add src/version.bash
	@git commit -m v$(version)
	@git tag v$(version)

test: deps/bats
	@echo "TODO!"

deps/bats:
	@mkdir -p deps
	git clone --depth 1 git://github.com/sstephenson/bats.git deps/bats


.PHONY: all tag test
