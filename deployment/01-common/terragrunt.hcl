# Copyright 2021 The Tranquility Base Authors
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

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

locals {
  common_vars = jsondecode(file("${get_parent_terragrunt_dir()}/common_vars.json"))
  skip        = lookup(local.common_vars, "skip_common_layer", false)
}

terraform {
  #need to peg to version
  source = "github.com/tranquilitybase-io/tb-gcp-bootstrap"
}

inputs = {
  project_id = get_env("project_id")
  folder_id  = get_env("folder_id")
  region     = get_env("region")
  billing_id = get_env("billing_id")
  random_id  = get_env("random_id")
}

skip = local.skip