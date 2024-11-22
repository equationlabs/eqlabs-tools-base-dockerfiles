# Base Dockerfiles for Projects 

This repository contains a set of base Dockerfiles for different types of projects. The idea is to have a set of base images that can be used as a starting point for different types of projects.

## Usage
We provide a Makefile with some targets to build and push the images to a Docker registry. The Makefile is located in the root of the repository.

```bash
$ make build-php-roadrunner-mysql
$ make push-php-roadrunner-mysql
$ make build-skaffold-slim
$ make build-php-chromium

$ make buld-all
```

### **Available types:**
- php
- skaffold

### **Available variants:**
> All these images are pushed to https://hub.docker.com/r/rcastellanosm registry on Docker Hub

- **PHP**
  - php.chromium
  - roadrunner.mysql
  - roadrunner.pgsql
- **Skaffold**
  - skaffold.slim
  - skaffold.full

## Available Images
- PHP
  - [PHP 8.2/8.4 + Chromium extension](php/Dockerfile.chromium) - Useful for E2E Testing
  - [PHP 8.2/8.4 + RoadRunner + MySQL extension](php/Dockerfile.roadrunner.mysql)
  - [PHP 8.2/8.4 + RoadRunner + PostgreSQL extension](php/Dockerfile.roadrunner.pgsql)
- Skaffold
  - [Skaffold + Kubectl + Kustomize for CI/CD Pipelines](skaffold/Dockerfile.slim)