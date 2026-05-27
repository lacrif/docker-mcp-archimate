# mcp-archimate — Docker

[![Docker Pulls](https://img.shields.io/docker/pulls/lacrif/mcp-archimate?link=https%3A%2F%2Fhub.docker.com%2Fr%2Flacrif%2Fmcp-archimate)](https://hub.docker.com/r/lacrif/mcp-archimate)

Docker setup for [mcp-archimate](https://github.com/lacrif/mcp-archimate) — a REST API and MCP server for querying and modifying ArchiMate models stored in native Archi Tool files.

## Configuration (`config.json`)

```json
{
  "path": "data/archisurance.xml",
  "name": "ArchiSurance"
}
```

## Running

### Docker Hub image

```bash
# Mount your own config and data
docker run -p 8000:8000 \
    -v /path/to/config.json:/app/config.json:ro \
    -v /path/to/data/archisurance.xml:/app/data/archisurance.xml:ro \
    lacrif/mcp-archimate:latest
```

### Docker Compose

```bash
docker compose up
```

## How to use

Refere to [mcp-archimate](https://github.com/lacrif/mcp-archimate)