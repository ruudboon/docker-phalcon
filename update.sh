#!/usr/bin/env bash

generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#
	EOH
}

PHALCON_VERSION=3.4.5

# Dockerfile on PHP 5 is customized
VERSIONS="
7.0
7.1
7.2
7.3
"

for version in ${VERSIONS}; do
    major_version=$(echo ${version} | cut -f1 -d.)

    mkdir -p ${version}

    generated_warning > ${version}/Dockerfile

    cat Dockerfile.template | \
        sed -e 's!%%PHP_VERSION%%!'"${version}"'!' | \
        sed -e 's!%%PHALCON_VERSION%%!'"${PHALCON_VERSION}"'!' \
        >> ${version}/Dockerfile
done
