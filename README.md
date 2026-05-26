# mcp-archimate — Docker

[![Docker Pulls](https://img.shields.io/docker/pulls/lacrif/mcp-archimate?link=https%3A%2F%2Fhub.docker.com%2Fr%2Flacrif%2Fmcp-archimate)](https://hub.docker.com/r/lacrif/mcp-archimate)

Docker setup for [mcp-archimate](https://github.com/lacrif/mcp-archimate) — a REST API and MCP server for querying and modifying ArchiMate models stored in native Archi Tool files.

## Configuration (`config.json`)

```json
{
  "path": "data/archisurance.archimate",
  "name": "ArchiSurance"
}
```

| Field | Description |
| ----- | ----------- |
| `path` | Path to the `.archimate` file, relative to `/app` inside the container |
| `name` | Human-readable model name |

## Running

### Docker Hub image

```bash
# Run with bundled data
docker run -p 8000:8000 lacrif/mcp-archimate:latest

# Mount your own config and data
docker run -p 8000:8000 \
    -v /path/to/config.json:/app/config.json:ro \
    -v /path/to/data:/app/data:ro \
    lacrif/mcp-archimate:latest
```

### Local build

```bash
docker build -t mcp-archimate:local .

docker run -p 8000:8000 \
    -v ./config.json:/app/config.json:ro \
    -v ./data:/app/data:ro \
    mcp-archimate:local
```

To pin a specific version of [mcp-archimate](https://github.com/lacrif/mcp-archimate), pass `MCP_ARCHIMATE_VERSION`:

```bash
docker build --build-arg MCP_ARCHIMATE_VERSION=0.4.1 -t mcp-archimate:0.4.1 .
```

Omitting the argument defaults to `latest`.

### Docker Compose

```bash
docker compose up --build
```

Mounts `config.json` and `data/` as read-only volumes automatically.

## Using your own models

1. Place your `.archimate` file in `data/`
2. Edit `config.json` to point to it
3. Restart the container

## API

Once running, the server is available at `http://localhost:8000`:

| Path | Description |
| ---- | ----------- |
| `/docs` | Swagger UI |
| `/openapi.json` | OpenAPI 3.0 spec |
| `/mcp` | MCP endpoint (streamable-http) |

## MCP client configuration

### Claude Code

```bash
claude mcp add mcp-archimate http://localhost:8000/mcp --transport http
```

Or add to `.mcp.json`:

```json
{
    "mcpServers": {
        "mcp-archimate": {
            "type": "http",
            "url": "http://localhost:8000/mcp"
        }
    }
}
```

### Claude Desktop

Edit the config file:
- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`
- **Linux**: `~/.config/Claude/claude_desktop_config.json`

```json
{
    "mcpServers": {
        "mcp-archimate": {
            "type": "http",
            "url": "http://localhost:8000/mcp"
        }
    }
}
```

### VS Code / GitHub Copilot

```json
{
    "servers": {
        "mcp-archimate": {
            "url": "http://localhost:8000/mcp",
            "type": "http"
        }
    }
}
```

Enable MCP in VS Code settings: `"github.copilot.chat.mcp.enabled": true`

### OpenAI Codex CLI

```toml
[mcp_servers.mcp-archimate]
type = "http"
url = "http://localhost:8000/mcp"
```
