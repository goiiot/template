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

BINARY = foo
FILE_BINARY_SOURCE = example/main.go

DIR_BUILD = .build
DIR_DIST = .dist
DIR_TEST = .test
DIR_TOOL = .tool

.PHONY: _test_dir _build_dir _dist_dir _tool_dir

_test_dir:
	mkdir -p $(DIR_TEST)

_build_dir:
	mkdir -p $(DIR_BUILD)

_dist_dir:
	mkdir -p $(DIR_DIST)

_tool_dir:
	mkdir -p $(DIR_TOOL)

# build files
FILE_BINARY = $(DIR_BUILD)/$(BINARY)
FILE_RELEASE_BINARY = $(DIR_DIST)/$(BINARY)

# test files
FILE_TEST_BIN = $(DIR_TEST)/$(BINARY).test
FILE_COVERAGE = $(DIR_TEST)/coverage.txt

# benchmark files
FILE_BLOCK_PROFILE = $(DIR_TEST)/blockprofile.out
FILE_CPU_PROFILE = $(DIR_TEST)/cpuprofile.out
FILE_MEM_PROFILE = $(DIR_TEST)/memprofile.out
FILE_MUTEX_PROFILE = $(DIR_TEST)/mutexprofile.out
FILE_TRACE_PROFILE = $(DIR_TEST)/trace.out
