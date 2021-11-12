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
  echo "Please specify the root directory of SkyWalking APM"
  exit 1
fi

CYBORG_DASHBOARD="$(cd "$(dirname $0)"; pwd)"
APM_DIR="$(cd "$1"; pwd)"

if [ ! -d "$APM_DIR/config/ui-initialized-templates" ] || [ ! -d "$APM_DIR/config/oal" ]; then
  echo "Please make sure the SkyWalking APM directory is correct: $APM_DIR"
  return 1
fi

cp $CYBORG_DASHBOARD/ui-template.yml $APM_DIR/config/ui-initialized-templates/cyborg-flow.yml
echo "Copy UI template"

if [ -f "$APM_DIR/config/oal/core.oal" ]; then
  echo "Detect official core.oal, make it to core.oal_backup"
  mv "$APM_DIR/config/oal/core.oal" "$APM_DIR/config/oal/core.oal_backup"
fi

cp $CYBORG_DASHBOARD/core.oal $APM_DIR/config/oal/core.oal
echo "Copy OAL"

