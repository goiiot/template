# Copyright Go-IIoT (https://github.com/goiiot)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# app binary output name
BINARY = foo
# app main source file
FILE_BINARY_SOURCE = example/main.go
# args for go test -run or go test -bench
RUN ?= .
# app arguments
ARGS ?= 

DIR_BUILD = .build
DIR_DIST = .dist
DIR_TEST = .test

$(DIR_TEST):
	mkdir -p $(DIR_TEST)

$(DIR_BUILD):
	mkdir -p $(DIR_BUILD)

$(DIR_DIST):
	mkdir -p $(DIR_DIST)

GO = $(shell which go)
GIT = $(shell which git)
UPX = $(shell which upx)

ifneq ($(filter not found,$(GO)),)
    GO = :
else ifeq ($(GO),)
    GO = :
endif

ifneq ($(filter not found,$(GIT)),)
    GIT = :
else ifeq ($(GIT),)
    GIT = :
endif

ifneq ($(filter not found,$(UPX)),)
    UPX = :
else ifeq ($(UPX),)
    UPX = :
endif

GOVERSION = $(shell $(GO) version | cut -d\  -f3)
COMMIT = $(shell $(GIT) rev-parse HEAD 2>/dev/null | tail -c 16)
BRANCH = $(shell $(GIT) rev-parse --abbrev-ref HEAD 2>/dev/null)
VERSION = $(shell $(GIT) describe --tags 2>/dev/null)

ifeq ($(COMMIT),HEAD)
	COMMIT = none
endif
ifeq ($(BRANCH),HEAD)
	BRANCH = none
endif
ifeq ($(VERSION),)
	VERSION = none
endif

LDFLAGS := \
	-X main.branch=$(BRANCH) \
	-X main.commit=$(COMMIT) \
	-X main.version=$(VERSION) \
	-X main.goVersion=$(GOVERSION)

RELEASE_LDFLAGS := \
	-w -s $(LDFLAGS)

TEST_FLAGS := \
	-v -race -failfast \
	-covermode=atomic \
	-coverprofile=$(FILE_COVERAGE)

BENCH_FLAGS := \
	-v -race -benchmem \
	-trace=$(FILE_TRACE_PROFILE) \
	-blockprofile=$(FILE_BLOCK_PROFILE) \
	-cpuprofile=$(FILE_CPU_PROFILE) \
	-memprofile=$(FILE_MEM_PROFILE) \
	-mutexprofile=$(FILE_MUTEX_PROFILE) \
	-o=$(FILE_TEST_BIN)

#
# Build and run
#

FILE_BINARY = $(DIR_BUILD)/$(BINARY)
FILE_RELEASE_BINARY = $(DIR_DIST)/$(BINARY)

.PHONY: build release run

build: $(DIR_BUILD)
	@echo native build for $(NATIVE_OS)_$(NATIVE_ARCH)
	$(GO) build -ldflags '$(LDFLAGS)' -o $(FILE_BINARY) $(FILE_BINARY_SOURCE)

run: build
	./$(FILE_BINARY) $(ARGS)

release: $(DIR_DIST)
	$(GO) build -ldflags '$(RELEASE_LDFLAGS)' -o $(FILE_RELEASE_BINARY) $(FILE_BINARY_SOURCE)
	$(UPX) --brute $(FILE_RELEASE_BINARY)

#
# Test and coverage
#

FILE_TEST_BIN = $(DIR_TEST)/$(BINARY).test
FILE_COVERAGE = $(DIR_TEST)/coverage.txt

.PHONY: test coverage

test: $(DIR_TEST)
	$(GO) test $(TEST_FLAGS) -run=$(RUN) $(PKG)

coverage: test
	$(GO) tool cover -html=$(FILE_COVERAGE)

#
# Benchmark and profiling
#

FILE_BLOCK_PROFILE = $(DIR_TEST)/blockprofile.out
FILE_CPU_PROFILE = $(DIR_TEST)/cpuprofile.out
FILE_MEM_PROFILE = $(DIR_TEST)/memprofile.out
FILE_MUTEX_PROFILE = $(DIR_TEST)/mutexprofile.out
FILE_TRACE_PROFILE = $(DIR_TEST)/trace.out

.PHONY: benchmark profile_cpu profile_mem profile_block profile_trace \
		profile_all_start profile_all_stop

benchmark: $(DIR_TEST)
	$(GO) test $(BENCH_FLAGS) -run=Benchmark.* -bench=$(RUN) $(PKG)

profile_cpu:
	$(GO) tool pprof -http localhost:50080 $(FILE_TEST_BIN) $(FILE_CPU_PROFILE)

profile_mem:
	$(GO) tool pprof -http localhost:50081 $(FILE_TEST_BIN) $(FILE_MEM_PROFILE)

profile_block:
	$(GO) tool pprof -http localhost:50082 $(FILE_TEST_BIN) $(FILE_BLOCK_PROFILE)

profile_mutex:
	$(GO) tool pprof -http localhost:50083 $(FILE_TEST_BIN) $(FILE_MUTEX_PROFILE)

profile_trace:
	$(GO) tool trace -http localhost:50084 $(FILE_TEST_BIN) $(FILE_TRACE_PROFILE)

FILE_CPU_PROFILE_PID = $(DIR_TEST)/cpuprofile.pid
FILE_MEM_PROFILE_PID = $(DIR_TEST)/memprofile.pid
FILE_BLOCK_PROFILE_PID = $(DIR_TEST)/blockprofile.pid
FILE_MUTEX_PROFILE_PID = $(DIR_TEST)/mutexprofile.pid
FILE_TRACE_PROFILE_PID = $(DIR_TEST)/trace.pid

profile_all_start:
	$(GO) tool pprof -http localhost:50080 $(FILE_TEST_BIN) $(FILE_CPU_PROFILE) \
		& echo $$! > $(FILE_CPU_PROFILE_PID)
	$(GO) tool pprof -http localhost:50081 $(FILE_TEST_BIN) $(FILE_MEM_PROFILE) \
		& echo $$! > $(FILE_MEM_PROFILE_PID)
	$(GO) tool pprof -http localhost:50082 $(FILE_TEST_BIN) $(FILE_BLOCK_PROFILE) \
		& echo $$! > $(FILE_BLOCK_PROFILE_PID)
	$(GO) tool pprof -http localhost:50083 $(FILE_TEST_BIN) $(FILE_MUTEX_PROFILE) \
		& echo $$! > $(FILE_MUTEX_PROFILE_PID)
	$(GO) tool trace -http localhost:50084 $(FILE_TEST_BIN) $(FILE_TRACE_PROFILE) \
		& echo $$! > $(FILE_TRACE_PROFILE_PID)

profile_all_stop: \
	$(FILE_BLOCK_PROFILE_PID) $(FILE_CPU_PROFILE_PID) \
	$(FILE_MEM_PROFILE_PID) $(FILE_MUTEX_PROFILE_PID) \
	$(FILE_TRACE_PROFILE_PID)

	kill -KILL `cat $(FILE_BLOCK_PROFILE_PID)`
	kill -KILL `cat $(FILE_CPU_PROFILE_PID)`
	kill -KILL `cat $(FILE_MEM_PROFILE_PID)`
	kill -KILL `cat $(FILE_MUTEX_PROFILE_PID)`
	kill -KILL `cat $(FILE_TRACE_PROFILE_PID)`

	rm -f $(FILE_BLOCK_PROFILE_PID)
	rm -f $(FILE_CPU_PROFILE_PID)
	rm -f $(FILE_MEM_PROFILE_PID)
	rm -f $(FILE_MUTEX_PROFILE_PID)
	rm -f $(FILE_TRACE_PROFILE_PID)

#
# Cleanup
# 
.PHONY: clean

clean:
	rm -rf $(DIR_DIST)
	rm -rf $(DIR_BUILD)
	rm -rf $(DIR_TEST)
