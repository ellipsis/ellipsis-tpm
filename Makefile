# ellipsis-tpm - shell script package manager

all: test

tag:
	@sed -i 's/^TPM_VERSION=.*$$/TPM_VERSION=$(version)/' src/version.bash
	@git add src/version.bash
	@git commit -m v$(version)
	@git tag v$(version)

test:
	@echo "TODO!"

.PHONY: all tag test
