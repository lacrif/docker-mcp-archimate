FROM node:22-slim

ARG MCP_ARCHIMATE_VERSION=0.4.2

WORKDIR /app

RUN npm init -y && npm install mcp-archimate@${MCP_ARCHIMATE_VERSION} tsx

COPY config.json ./
COPY data/ ./data/

EXPOSE 8000

CMD ["node_modules/.bin/tsx", "node_modules/mcp-archimate/src/main.ts"]
