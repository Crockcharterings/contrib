#!/bin/bash
# Copyright 2016 The Kubernetes Authors.
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

. $(dirname ${BASH_SOURCE})/../util.sh

IP=$(kubectl --namespace=demos get svc hostnames-svc \
        -o go-template='{{.spec.clusterIP}}')

run "gcloud compute ssh --zone=us-central1-b $SSH_NODE --command '\\
    while true; do \\
        curl --connect-timeout 1 -s $IP && echo; \\
        sleep 0.5; \\
    done \\
    '"
