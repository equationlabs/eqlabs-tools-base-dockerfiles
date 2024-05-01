PHP_DIR			:= ${PWD}/php
SKAFFOLD_DIR 	:= ${PWD}/skaffold
DOCKER_REGISTRY	:= rcastellanosm

help:
	@echo "---------------------- Available Targets ---------------------------"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

#------ Working Targets ----------#
build-all: build-php-mysql build-php-pgsql build-skaffold-slim
build-php-mysql:	## [Docker] Build and Push php image with roadrunner and mysql extension
	@$(MAKE) build-and-push type=php variant=roadrunner.mysql dir=${PHP_DIR}
build-php-pgsql:	## [Docker] Build and Push php image with roadrunner and pgsql extension
	@$(MAKE) build-and-push type=php variant=roadrunner.pgsql dir=${PHP_DIR}
build-skaffold-slim:	## [Docker] Build and Push skaffold image with slim variant for CI/CD pipelines
	@$(MAKE) build-and-push type=skaffold variant=slim dir=${SKAFFOLD_DIR}
build-and-push:
	@$(call validate_type)
	@$(call validate_variant)
	@docker build -t ${DOCKER_REGISTRY}/$(type).$(variant):latest -f $(dir)/Dockerfile.$(variant) .
	@echo "🎉 $(type) image built successfully  with tag ${DOCKER_REGISTRY}/$(type).$(variant):latest"
	@docker push ${DOCKER_REGISTRY}/$(type).$(variant):latest
	@echo "🎉 $(type) image pushed successfully with tag ${DOCKER_REGISTRY}/$(type).$(variant):latest"


#------ Helper Targets ----------#
define validate_type
	@if [ -z $(type) ]; then echo "😩 one of php|skaffold value is required on type argument"; exit 1; fi
endef

define validate_variant
	@if [ -z $(variant) ]; then echo "😩 one of roadrunner.mysql|roadrunner.pgsql|skaffold.slim value is required on variant argument"; exit 1; fi
endef