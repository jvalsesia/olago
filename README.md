# commands go container


## 1- Setup development environment
We don't need to install golang in our dekstop, lets use docker container and add our current dir as volume:

```bash
docker run --rm -it -v $(pwd)/:/app golang:1.19-alpine sh
```

## 2- Init go project
In the previous command we ran sh in our golang container and entered in the created volume /app and using go from golang container we have initialized our go application:
```sh
cd /app
go mod init codeeducation/ola
```
This will generate go.mod in the current folder.

## 3- Create ola.go
Let's create small go application to print a message to the console:
```go
package main

import "fmt"

func main() {
    fmt.Println("Code.education Rocks!")
}
```


## 4- create Dockerfile with multi-stage builds
In order to get small image we have created a multi-stage build, first using golang:1.19-alpine image to build the application and generate the executable **ola** and second using scratch image to run the application **ola**:

```dockerfile
FROM golang:1.19-alpine AS builder
WORKDIR /build
COPY go.mod .
COPY ola.go .
RUN go build -o ola ola.go

FROM scratch
WORKDIR /app
COPY --from=builder /build/ola /app/ola

ENTRYPOINT ["./ola"]

```


## 5- build container
```bash
docker build -t <your_user>/codeeducation:latest .
```

## 6- run container
```bash
docker run <your_user>/codeeducation
```

## 6- login to DockerHub
```bash
docker login
```


## push to registry
```bash
docker push <your_user>/codeeducation:latest
```