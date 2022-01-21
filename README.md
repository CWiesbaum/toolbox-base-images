# toolbox-base-images
[buildah](https://buildah.io/) scripts to create new OCI images which can be used as [Fedora Toolbox](https://docs.fedoraproject.org/en-US/fedora-silverblue/toolbox/) base images.

## Fedora Toolbox
Toolbox is container management utility mainly used on OSTree OSs such as [Fedora Silverblue](https://docs.fedoraproject.org/en-US/fedora-silverblue/). It enables to manage mutable development environments on an immutable OS. Excerpt from the Toolbox documentation:

> As an immutable host, Silverblue is an excellent platform for container-based development and, for working with containers, buildah and podman are recommended.
>
>Silverblue also comes with the toolbox utility, which uses containers to provide an environment where development tools and libraries can be installed and used.

A development container can be created and then provisioned by hand using commands such as dnf. However, this is not reproducible and requires manual work on each update.

The buildah scripts within this repository are my personal development toolboxes. These scripts create a new OCI image based on the fedora-toolbox base image used by toolbox. The OCI image created can be used to create a new toolbox:

```
toolbox create -i image-name container-name
```

## Toolbox specific environment
Toolbox uses an init procedure which links relevant host functions into the OCI container instance. This process enables a seamless integration between host and guest container. In some toolboxes it is required to set toolbox specific environment variables (e.g. JAVA_HOME).

In order to set toolbox specific environments ***env*** scripts can be provided. These scripts can be sourced in your ***.bashrc*** file, which will be executed when entering a toolbox. For this to work this bash code can be used:

```
if [ -f /run/.toolboxenv ]; then
    . /run/.containerenv

    if [ "$name" == "containerName" ]; then
        . ~/path/to/env/file/someToolboxEnv
    fi
fi
```

Within a toolbox container instance the file **/run/.toolboxenv** is present. Furthermore, the container specific file **/run/.containerenv** should be present. Within this file variable ***name*** is set, which can be used to distinguish containers.

## License

All contents of this repository are published under GNU GENERAL PUBLIC LICENSE Version 2.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.