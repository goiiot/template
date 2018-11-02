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

-include os.mk git.mk file.mk tools.mk

# test of benchmark -run
RUN ?= .
ARGS ?= 

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
.PHONY: build release run

build: _build_dir
	@echo native build for $(NATIVE_OS)_$(NATIVE_ARCH)
	$(GO) build -ldflags '$(LDFLAGS)' -o $(FILE_BINARY) $(FILE_BINARY_SOURCE)

release:
	$(GO) build -ldflags '$(RELEASE_LDFLAGS)' -o $(FILE_RELEASE_BINARY) $(FILE_BINARY_SOURCE)
	$(UPX) --brute $(FILE_RELEASE_BINARY)

run: build
	./$(FILE_BINARY) $(ARGS)

# 
# Test and coverage
# 
.PHONY: test coverage

test: _test_dir
	$(GO) test $(TEST_FLAGS) -run=$(RUN) $(PKG)

coverage: test
	$(GO) tool cover -html=$(FILE_COVERAGE)

# 
# Benchmark and profiling
# 
.PHONY: benchmark profile_cpu profile_mem profile_block profile_trace \
		profile_all_start profile_all_stop

benchmark: _test_dir
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

#
#
#
# Reserved Area, DO NOT EDIT unless you know what you're doing
#
#
#
