# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# If the first argument is "run"...

SHELL := /bin/bash -o pipefail

CYBORG_DASHBOARD_ROOT := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
CYBORG_DASHBOARD_TAR := cyborg-dashboard.tar.gz
CYBORG_UPSTREAM_REPO ?= https://github.com/apache/skywalking.git
CYBORG_UPSTREAM_HEAD ?= 4284a57501eae6df49cb2703f31cc6f30d43367e
REMOVE_UPSTREAM_TEMPLATE ?= true

.PHONY: replace
replace:
	bash ./replace-oap.sh $(path) $(REMOVE_UPSTREAM_TEMPLATE)

.PHONY: release
release:
	bash ./release.sh $(CYBORG_UPSTREAM_REPO) $(CYBORG_UPSTREAM_HEAD) $(CYBORG_DASHBOARD_ROOT)/$(CYBORG_DASHBOARD_TAR)






