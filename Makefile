SHELL 			:= /bin/bash
PHP_DIR			:= ${PWD}/php
SKAFFOLD_DIR 	:= ${PWD}/skaffold
DOCKER_REGISTRY	:= rcastellanosm
TAGS			:= 8.2 8.4

help:
	@echo "---------------------- Available Targets ---------------------------"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

#------ Working Targets ----------#
build-all: build-php-mysql build-php-pgsql build-skaffold-slim build-php-chromium build-php-tester
build-php-tester:	## [Docker] Build and Push php image with ext for testing
	@$(MAKE) build-and-push-php variant=tester dir=${PHP_DIR}
build-php-chromium:	## [Docker] Build and Push php image with ext and chromium extension for testing
	@$(MAKE) build-and-push-php variant=chromium dir=${PHP_DIR}
build-php-mysql:	## [Docker] Build and Push php image with roadrunner and mysql extension
	@$(MAKE) build-and-push-php variant=roadrunner.mysql dir=${PHP_DIR}
build-php-pgsql:	## [Docker] Build and Push php image with roadrunner and pgsql extension
	@$(MAKE) build-and-push-php variant=roadrunner.pgsql dir=${PHP_DIR}
build-skaffold-slim:	## [Docker] Build and Push skaffold image with slim variant for CI/CD pipelines
	@$(MAKE) build-and-push type=skaffold variant=slim dir=${SKAFFOLD_DIR}
build-and-push-php:
	@$(call validate_variant)
	@for tag in $(TAGS); do \
		docker build --platform=linux/amd64,linux/arm64 --build-arg PHP_VERSION=$$tag -t ${DOCKER_REGISTRY}/php.$(variant):$$tag -f $(dir)/Dockerfile.$(variant) .; \
		echo "🎉 PHP image built successfully with tag ${DOCKER_REGISTRY}/php.$(variant):$$tag"; \
	done
	@docker push --all-tags ${DOCKER_REGISTRY}/php.$(variant)
	@echo "🎉 PHP images pushed successfully!"
build-and-push:
	@$(call validate_type)
	@$(call validate_variant)
	@docker build -t ${DOCKER_REGISTRY}/$(type).$(variant):latest -f $(dir)/Dockerfile.$(variant) .
	@echo "🎉 $(type) image built successfully with tag ${DOCKER_REGISTRY}/$(type).$(variant):latest"
	@docker push ${DOCKER_REGISTRY}/$(type).$(variant):latest
	@echo "🎉 $(type) image pushed successfully with tag ${DOCKER_REGISTRY}/$(type).$(variant):latest"

#------ Helper Targets ----------#
define validate_type
	@if [ -z $(type) ]; then echo "😩 one of php|skaffold value is required on type argument"; exit 1; fi
endef

define validate_variant
	@if [ -z $(variant) ]; then echo "😩 one of roadrunner.mysql|roadrunner.pgsql|skaffold.slim value is required on variant argument"; exit 1; fi
endef