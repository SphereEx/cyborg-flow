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

CYBORG_AGENT="$(cd "$(dirname $0)"; pwd)"
REPO=$1
REPO_HEAD=$2
DIST_FILE_PATH=$3

cd $CYBORG_AGENT

# build upstream
git clone $REPO skywalking-java-agent
cd skywalking-java-agent && git reset --hard $REPO_HEAD
git submodule init && git submodule update
SKIP_TEST=true make build

# replace
AGENT_HOME=$(cd skywalking-agent; pwd)
cd $CYBORG_AGENT && make replace path=$AGENT_HOME

# build tar
cd $(dirname $AGENT_HOME)
mv $(basename $AGENT_HOME) cyborg-agent
tar vczf $DIST_FILE_PATH cyborg-agent

# cleanup upstream
rm -rf $CYBORG_AGENT/skywalking-java-agent