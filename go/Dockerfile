FROM golang:alpine AS BUILD

RUN apk update; apk add make upx;

COPY . /build
WORKDIR /build
RUN make release

# build actual image
FROM scratch
COPY --from=BUILD /build/.dist/foo /app

CMD [ "/app" ]
