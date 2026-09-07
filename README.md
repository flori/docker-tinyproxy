# Docker image for tinyproxy

Minimal `tinyproxy` HTTP proxy on Alpine. Multi-arch (amd64/arm64).

## Quick start

```bash
docker compose up -d
```

Then configure your browser/app to use `localhost:8080` as an
HTTP proxy.

## Configuration

The image ships with a sensible default config. To override it,
bind-mount your own config over the default path:

```yaml
volumes:
  - ./config/tinyproxy.conf:/etc/tinyproxy/tinyproxy.conf
```

This repo includes a working example at `config/tinyproxy.conf`
(with `BasicAuth`). Copy it, tweak, and point the compose volume
at it.

For the full list of supported directives, see the
[tinyproxy documentation](http://tinyproxy.sesse.net/).

## Building

```bash
make build       # multi-arch push to flori303/tinyproxy
make build-local # load locally (amd64+arm64)
```

## License

See [LICENSE](LICENSE).
