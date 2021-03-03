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

locals {
  source_repo_name = "tb-management-plane"
}

###
# Create source repository
###

resource "google_sourcerepo_repository" "tb-management-plane-repo" {
  name    = local.source_repo_name
  project = module.project-bootstrap.project_id

  depends_on = [module.project-services-bootstrap]
}

###
# Create Cloud Build trigger
###

resource "google_cloudbuild_trigger" "bootstrap-cb" {

  trigger_template {
    tag_name   = "0.1.0"
    repo_name  = google_sourcerepo_repository.tb-management-plane-repo.name
    project_id = module.project-bootstrap.project_id
  }

  substitutions = {
    _PROJECT_ID = module.project-bootstrap.project_id
    _REGION     = var.region
  }

  project  = module.project-bootstrap.project_id
  filename = "cloudbuild.yaml"

  depends_on = [module.project-services-bootstrap]
}