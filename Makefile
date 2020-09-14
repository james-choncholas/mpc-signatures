# Use the target `make help` for more information.

##----------------------------------------------------------------------------
## Meta build setup
SHELL := /bin/bash
BASEDIR	:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

VERBOSE	?= 0
ifeq ($(VERBOSE), 0)
	QUIET=@
else
	QUIET=
endif

## ----------------------------------------------------------------------------
## Additional Libs
MPC_DIR         = $(BASEDIR)/blockchain-crypto-mpc
MPC_LIB			= $(MPC_DIR)/libmpc_crypto.so


.PHONY: all help deps

all: help

deps: ## Install blockchain-crypto-mpc dependancies. Requires sudo privileges.
	$(QUIET)echo installing blockchain-crypto-mpc library dependancies
	$(QUIET)#sudo apt install openjdk-8-jdk make make-guile gcc g++ openssl libssl-dev
	$(QUIET)sudo apt install openjdk-8-jdk make gcc g++ openssl libssl-dev
	$(QUIET)$(MAKE) JAVA_HOME=$(JAVA_HOME) -C $(MPC_DIR)
	$(QUIET)echo installing ethereum dependancies
	$(QUIET)sudo add-apt-repository -y ppa:ethereum/ethereum
	$(QUIET)sudo apt update
	$(QUIET)sudo apt install ethereum


help: ## Show this help.
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"


