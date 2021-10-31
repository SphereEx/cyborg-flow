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

if [ "$1" == "" ]; then
  echo "Please specify the root directory of skywalking-agent"
  exit 1
fi

CYBORG_AGENT_DIR="$(cd "$(dirname $0)"; pwd)"
AGENT_DIR="$(cd "$1"; pwd)"
AGENT_BACKUP_DIR="$AGENT_DIR/plugins-backup"

function replace() {
  need_replace=$1
  new_plugins=$2

  # move old plugins to backup
  PLUGIN_BASE="$AGENT_DIR/$(dirname $need_replace)"
  find $PLUGIN_BASE -name "$(basename $need_replace)*" -print0 |
    while IFS= read -r -d '' file; do
      mv $file $AGENT_BACKUP_DIR
      echo "Move agent $(basename $file) to backup"
    done

  # copy new agents
  find $CYBORG_AGENT_DIR/$(dirname $new_plugins) -name "$(basename $new_plugins)*" -print0 |
    while IFS= read -r -d '' file; do
      cp $file $PLUGIN_BASE
      echo "Add new agent $(basename $file)"
    done
}

echo "ready for replace agent path: $AGENT_DIR"
echo "backup agent path: $AGENT_BACKUP_DIR"
mkdir -p $AGENT_BACKUP_DIR

replace plugins/apm-mysql- cyborg-agent/plugins/cyborg-flow-mysql-
