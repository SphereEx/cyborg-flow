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

CYBORG_DASHBOARD="$(cd "$(dirname $0)"; pwd)"
REPO=$1
REPO_HEAD=$2
DIST_FILE_PATH=$3

cd $CYBORG_DASHBOARD

# build upstream
git clone $REPO skywalking-apm
cd skywalking-apm && git reset --hard $REPO_HEAD
make init && SKIP_TEST=true make build.all
cd dist && tar -zxvf apache-skywalking-apm-bin.tar.gz

# replace
OAP_HOME=$(cd apache-skywalking-apm-bin; pwd)
make -C $CYBORG_DASHBOARD replace path=$OAP_HOME

# build tar
cd $(dirname $OAP_HOME)
mv $(basename $OAP_HOME) cyborg-dashboard
tar vczf $DIST_FILE_PATH cyborg-dashboard

# cleanup upstream
rm -rf $CYBORG_DASHBOARD/skywalking-apm