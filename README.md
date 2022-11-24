# Dockerized Bitcoin Core

## What is Bitcoin Core?

Bitcoin Core is a reference client that implements the Bitcoin protocol for remote procedure call (RPC) use. It is also
the second Bitcoin client in the network's history. Learn more about Bitcoin Core on
the [Bitcoin Developer Reference docs](https://bitcoin.org/en/developer-reference).

## Usage

### How to use this image

This image contains the main binaries from the Bitcoin Core project - bitcoind, bitcoin-cli and bitcoin-tx. It behaves
like a binary, so you can pass any arguments to the image and they will be forwarded to the bitcoind binary:

```sh
❯ docker run --rm -it cryptodockerhub/bitcoin-core:latest
```

### Mounting root directory

You can also mount a directory in a volume under `/data` in case you want to access it on the host:

```sh
> docker run -v /btc-data:/data -it -rm cryptodockerhub/bitcoin-core:latest
```

### File Structure

For information on file structure, visit the [crypto-docker/coin-base](https://github.com/crypto-docker/coin-base)
repository.

### Compose File

```yaml
version: "3"
services:
  bitcoind:
    hostname: bitcoin-core
    container_name: "bitcoin-core"
    image: cryptodockerhub/bitcoin-core:latest
    volumes:
      - bitcoincore:/data
volumes:
  bitcoincore:
```

### How to change the config file
To make changes, you must link the root directory to any folder. You can edit the config.conf file under the root directory.
