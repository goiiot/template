# Templates for `Go` projects

All templates in this directory are designed for go1.11+

## Preparation

modify `file.mk`

```makefile
BINARY = foo
FILE_BINARY_SOURCE = example/main.go
```

## Build

build app

```bash
make build
```

## Release

build app with `-ldflags '-w -s'`

```bash
make release
```

## Run

run app

```bash
make run
```

run app with args

```bash
make run ARGS="-foo notbar"
```

## Test

run coverage inside current package

```bash
make test
```

run coverage inside a specific package

```bash
make test PKG=./example
```

run tests with regex matched name

```bash
make test RUN=TestFo.*
```

## Coverage

run coverage inside current package

```bash
make coverage
```

run coverage inside a specific package

```bash
make coverage PKG=./example
```

## Benchmark

run benchmarks inside a package

```bash
make benchmark PKG=./example
```

run benchmarks with regex matched name

```bash
make benchmark RUN="BenchmarkF.*" PKG=./example
```

## Profile

```bash
make profile PKG=./example
```
