# BF2 Sandbox docker builder

This is a simple docker container adds the [sandbox mod](http://sandboxmod.com) to image built with [senclan/bf2-server-docker](https://github.com/senclan/bf2-server-docker).

## Prerequisites

This extends the [bf2 server docker](https://github.com/senclan/bf2-server-docker) image.
You will need to first build a `bf2/server:latest` image before you can build this one.

You will also need to download the sandbox mod server files. You can do so from
their website http://sandboxmod.com/?p=download-server

## Usage

After you've downloaded the server files from sandbox mod's website.
You'll run the following command:

```shell
docker build -t bf2/mod/sandbox:latest .
```

Reference [bf2 server docker](https://github.com/senclan/bf2-server-docker) for examples of running the docker container.
