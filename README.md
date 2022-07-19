# Drone MkDocs Site Plugin

A [Drone](https://drone.io) plugin to build site using  [MkDocs](https://www.mkdocs.org/).

The plugin installs the following extension modules

* [mkdocs-material](https://squidfunk.github.io/mkdocs-material/).
* mike

## Usage

The following settings changes this plugin's behavior.

* python_modules (optional) An array of Python modules install.

Create a `.drone.yml` as shown below and then run the command `drone exec --trusted`

```yaml
kind: pipeline
type: docker
name: default

steps:

- name: build site
  image: docker.io/kameshsampath/drone-mkdocs-site
  pull: if-not-exists
  volumes:
    - name: site-dir
      path: /build

volumes:
  - name: site-dir
    temp: {}
```

Please check the examples folder for `.drone.yml` with other settings.

The site will be built in a directory `/build/site`, which could be mounted to other volumes/directories or built pushed as site image.

## Building

Run the following command to build and push the image manually

```text
make release
```