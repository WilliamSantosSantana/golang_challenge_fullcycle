FROM golang:1.21-alpine AS builder

LABEL maintainer="William"
LABEL environment="development"

WORKDIR /app

COPY . .

RUN apk add --no-cache upx && \
  CGO_ENABLED=0 go build -ldflags="-s -w" -o server main.go && \
  upx --best --lzma server

FROM scratch

COPY --from=builder /app/server /server

CMD ["./server"]