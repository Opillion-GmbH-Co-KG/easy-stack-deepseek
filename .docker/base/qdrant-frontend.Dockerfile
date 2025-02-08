FROM node:18

RUN apt-get update && apt-get install -y --no-install-recommends \
    git unzip curl && \
    rm -rf /var/lib/apt/lists/*

RUN npm config set registry https://registry.npmmirror.com

WORKDIR /app/frontend
RUN git clone --depth 1 https://github.com/qdrant/qdrant-web-ui.git .

RUN echo "export default { build: { chunkSizeWarningLimit: 2000 } };" > vite.config.ts

RUN npm ci --legacy-peer-deps --retry=5 && \
    npm run build && \
    npm install -g serve && \
    npm cache clean --force

EXPOSE 6335
CMD ["serve", "-s", "dist", "-l", "6335"]
