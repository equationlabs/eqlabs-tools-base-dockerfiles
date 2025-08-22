# Base Dockerfiles for Projects

This repository contains a set of base Dockerfiles for different types of projects. The idea is to have a set of base
images that can be used as a starting point for different types of projects.

## Usage

We provide a Makefile with some targets to build and push the images to a Docker registry. The Makefile is located in
the root of the repository.

```bash
$ make build-php-static-cli
$ make build-php-roadrunner-mysql
$ make push-php-roadrunner-mysql
$ make build-skaffold-slim
$ make build-php-chromium

$ make buld-all
```

### **Available variants:**

> All these images are pushed to `ghcr.io/equationlabs` registry on GitHub

> Tags follow the `PHP` version as image `TAG`

- **PHP**
  - `ghcr.io/equationlabs/php.static.cli`
    - Basically we
      use [static-php-cli](https://github.com/crazywhalecc/static-php-cli) + [Google Distroless](https://github.com/GoogleContainerTools/distroless)
      images.
  - `ghcr.io/equationlabs/php.chromium`
  - `ghcr.io/equationlabs/php.roadrunner.mysql`
  - `ghcr.io/equationlabs/php.roadrunner.pgsql`
- **Skaffold**
  - `ghcr.io/equationlabs/skaffold.slim`
  - `ghcr.io/equationlabs/skaffold.full`

## Available Images

- PHP
  - [PHP Static CLI Binary](php/Dockerfile.static.php.alpine) - Useful to use on distroless distributions
  - [PHP + Chromium extension](php/Dockerfile.chromium) - Useful for E2E Testing
  - [PHP + RoadRunner + MySQL extension](php/Dockerfile.roadrunner.mysql)
  - [PHP + RoadRunner + PostgreSQL extension](php/Dockerfile.roadrunner.pgsql)
- Skaffold
  - [Skaffold + Kubectl + Kustomize for CI/CD Pipelines](skaffold/Dockerfile.slim)