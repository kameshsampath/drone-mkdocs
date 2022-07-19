# Example build

Start a local registry

```shell
docker run -d -p 5001:5000 --name registry registry:2
```

Build the site

```shell
drone exec --trusted
```

Run the site,

```shell
docker run --rm -p8080:80 localhost:5001/example/mkdocs-site
```

You can then open the example site in your browser at <http://localhost:8080>
