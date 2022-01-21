#!/bin/bash

id=$(buildah from --pull registry.fedoraproject.org/fedora-toolbox:35)

buildah run $id rpm --import https://packages.microsoft.com/keys/microsoft.asc
buildah run $id sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
buildah run $id dnf check-update
buildah run $id dnf upgrade -y

buildah run $id dnf install -y java-17-openjdk-devel code maven vim

buildah run $id dnf autoremove
buildah run $id dnf clean all

buildah commit $id java-dev17
buildah rm $id

toolbox create -i java-dev17 java-dev17
