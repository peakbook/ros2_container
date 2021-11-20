ENGINE:=podman
IMGNAME:=myros:foxy-desktop-display
CNTNAME:=myros-foxy-desktop-display
PROXY:=
PORT:=8888
PASSWD:=password

ifeq ($(OS),Windows_NT)
	WORKDIR:=$(CURDIR)
else
	WORKDIR:=$(shell pwd)
	ifeq ($(ENGINE),docker)
		USEROPT:=-u $(shell id -u):$(shell id -g)
	endif
endif

ARG = 

all: help

build: ./Dockerfile ## build image
	$(ENGINE) image build \
		--build-arg http_proxy=$(PROXY) \
		--build-arg https_proxy=$(PROXY) \
		-f $< \
		-t $(IMGNAME) .

run-vnc: ## run container as daemon (VNC)
	$(ENGINE) run -it -d --rm \
		--name $(CNTNAME) \
		-e http_proxy=$(PROXY) \
		-e https_proxy=$(PROXY) \
		-v $(WORKDIR):/work \
		-w /work \
		-p $(PORT):5901 \
		-e VNC_PASSWD=$(PASSWD) \
		$(USEROPT) \
		$(IMGNAME)

run-novnc: ## run container as daemon (NOVNC)
	$(ENGINE) run -it -d --rm \
		--name $(CNTNAME) \
		-e http_proxy=$(PROXY) \
		-e https_proxy=$(PROXY) \
		-v $(WORKDIR):/work \
		-w /work \
		-p $(PORT):6901 \
		-e VNC_PASSWD=$(PASSWD) \
		$(USEROPT) \
		$(IMGNAME)

run-rdp: ## run container as daemon (RDP)
	$(ENGINE) run -it -d --rm \
		--name $(CNTNAME) \
		-e http_proxy=$(PROXY) \
		-e https_proxy=$(PROXY) \
		-v $(WORKDIR):/work \
		-w /work \
		-p $(PORT):3389 \
		-e VNC_PASSWD=$(PASSWD) \
		$(USEROPT) \
		$(IMGNAME)

shell: ## start a shell in the container
	$(ENGINE) exec -it $(CNTNAME) /bin/bash

stop: ## stop the container
	$(ENGINE) container stop $(CNTNAME)

remove: ## remove image
	$(ENGINE) rmi $(IMGNAME)

help: ## this help
	-@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: build run-vnc run-novnc run-rdp stop shell remove help
