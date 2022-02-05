#!/bin/bash

id=$(buildah from --pull registry.fedoraproject.org/fedora-toolbox:35)

buildah run $id dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

buildah run $id dnf check-update
buildah run $id dnf upgrade -y

buildah run $id dnf install -y terraform awscli vim

buildah run $id dnf autoremove
buildah run $id dnf clean all

buildah commit $id terraform
buildah rm $id

toolbox create -i terraform terraform