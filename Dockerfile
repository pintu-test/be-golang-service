FROM golang:1.18.1-alpine as build
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY * ./
RUN go build -o /simple-web

FROM golang:1.18.1-alpine as release
WORKDIR /app
COPY --from=build /simple-web /simple-web
COPY index.html ./
EXPOSE 8080

CMD [ "/simple-web" ]