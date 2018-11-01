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

NATIVE_OS =
NATIVE_ARCH =

ifeq ($(OS),Windows_NT)
    NATIVE_OS = windows
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        NATIVE_ARCH = amd64
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            NATIVE_ARCH = amd64
        else ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            NATIVE_ARCH = 386
        endif
    endif
else
    UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
        NATIVE_OS = linux
	else ifeq ($(UNAME_S),Darwin)
        NATIVE_OS = darwin
    endif

    UNAME_M := $(shell uname -m)
    ifeq ($(UNAME_M),x86_64)
        NATIVE_ARCH = amd64
    else ifneq ($(filter %86,$(UNAME_M)),)
        NATIVE_ARCH = 386
    else ifneq ($(filter aarch64,$(UNAME_M)),)
        NATIVE_ARCH = arm64
    else ifneq ($(filter arm%,$(UNAME_M)),)
        NATIVE_ARCH = arm
    endif
endif
