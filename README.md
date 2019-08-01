# BF2 Sandbox docker builder

This is a simple script to build a docker container image of the
[sandbox mod](http://sandboxmod.com) and run a server.

## Prerequisites

This extends the [bf2 server docker](https://github.com/senclan/bf2-server-docker)
image. You will need to first build a `bf2/server:latest` image before you can
build this one.

You will also need to download the sandbox mod server files. You can do so from
their website http://sandboxmod.com/?p=download-server

## Usage

```
$ ./build.sh -h
USAGE: ./build.sh [OPTION]...

Options:
  -h        Prints this message
  -s PATH   Path to source file
  -t tag    Tag for docker image
  -k        Keep extracted files directory
              Warning: all files from directory will be included in image
```

## Example

After you've downloaded the server files from sandbox mod's website. You'll
run the following command

```
./build.sh -s sandbox_server_1.0.1.zip -t bf2/mod/sandbox:latest
```

Reference [bf2 server docker](https://github.com/senclan/bf2-server-docker) for
examples of running the docker container.

