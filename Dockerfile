# Build Stage

FROM node:25-alpine@sha256:636c5bc8fa6a7a542bc99f25367777b0b3dd0db7d1ca3959d14137a1ac80bde2 AS builder

WORKDIR /likec4-action

COPY package.json yarn.lock .yarnrc.yml /likec4-action/
COPY .yarn/releases/ .yarn/releases

RUN yarn install --immutable

ENV NODE_ENV=production

COPY src src
COPY tsconfig.json .

RUN yarn build

# Run Stage

FROM mcr.microsoft.com/playwright:v1.58.2-jammy@sha256:4698a73749c5848d3f5fcd42a2174d172fcad2b2283e087843b115424303a565 AS runner

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y graphviz \
    && apt-get remove -y --allow-remove-essential \
       ffmpeg \
       gstreamer1.0-plugins-bad \
       libgstreamer-plugins-bad1.0-0 \
       libavcodec58 \
       libavdevice58 \
       libavfilter7 \
       libavformat58 \
       libavutil56 \
       libpostproc55 \
       libswresample3 \
       libswscale5 \
       libsoup-3.0-0 \
       libsoup-3.0-common \
       libsoup2.4-1 \
       libsoup2.4-common \
       libzvbi-common \
       libzvbi0 \
       libde265-0 \
       libdav1d5 \
       libopenh264-6 \
       libvo-amrwbenc0 \
       libx264-163 \
       libzbar0 \
       libsndfile1 \
       libwavpack1 \
       libsdl2-2.0-0 \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production

ARG LIKEC4_VER=1.52.0

RUN npm install -g likec4@${LIKEC4_VER}

COPY --from=builder /likec4-action/dist /likec4-action

ENTRYPOINT ["node", "/likec4-action/index.js"]
