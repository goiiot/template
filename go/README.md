# Templates for `Go` projects

All templates in this directory are designed for go1.11+

- [Preparation](#preparation)
- [Build](#build)
- [Release build](#release-build)
- [Run](#run)
- [Test](#test)
- [Coverage](#coverage)
- [Benchmark](#benchmark)
- [Profiling](#profiling)

## Preparation

modify `file.mk` if you're building an app, it's not needed if you're building a library

```makefile
BINARY = foo                            # change to your target binary name
FILE_BINARY_SOURCE = example/main.go    # change to the path of your main file
```

## Build

build app

```bash
make build
```

## Release build

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
make test RUN="TestFo.*" PKG=./example
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

run benchmarks inside current package

```bash
make benchmark
```

run benchmarks inside a package

```bash
make benchmark PKG=./example
```

run benchmarks with regex matched name

```bash
make benchmark RUN="BenchmarkF.*" PKG=./example
```

## Profiling

Profile after benchmark

```bash
# run cpu profiling for last benchmark
make profile_cpu

# run memory profiling for last benchmark
make profile_mem

# run block profiling for last benchmark
make profile_block

# run trace for last benchmark
make profile_trace

# run all profiling for last benchmark
make profile_all_start
# don't forget to stop them after profiling finished
make profile_all_stop
```
