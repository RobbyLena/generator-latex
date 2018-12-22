workflow "Build, Test, and Publish" {
  on = "push"
  resolves = [
    "Publish",
    "Test",
  ]
}

action "Build" {
  uses = "actions/npm@master"
  args = "install"
}

action "Test" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "test"
}

action "Tag" {
  needs = "Test"
  uses = "actions/bin/filter@master"
  args = "tag"
}

action "Publish" {
  needs = "Tag"
  uses = "actions/npm@master"
  runs = "publish"
  args = "--access public"
  secrets = ["NPM_AUTH_TOKEN"]
}