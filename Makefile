DOCKER_TAG ?= ansbile-ubuntu:0.0.0
TARGET_USER ?= ${USER}
TARGET_DIR ?= /home/${TARGET_USER}/ansible

play:
	ansible-playbook --ask-become-pass bootstrap.yml

play-debug:
	ansible-playbook --ask-become-pass -vvv --diff bootstrap.yml

prepare:
	@echo "Prepare for ansible"
	./prepare.sh

build-run:
	make build
	make run
 
build:
	docker build --tag ${DOCKER_TAG} .

run:
	docker run --env TARGET_USER=${TARGET_USER} --env TARGET_DIR=${TARGET_DIR} --volume ${PWD}:${TARGET_DIR} --rm -it ${DOCKER_TAG}
