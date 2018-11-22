# ocd-builder-webhook

This is a webhook chart to trigger ocd-builder to create a tagged s2i image from git tags. 

It is implemented using the [we hook engine](https://github.com/adnanh/webhook/blob/master/webhook.go) that pattern matches webhook JSON using Go and then invokes a simple shell script. The shell script updates the ocd-builder configuration to reference the new git tag which triggers a build. 

## Usage

You install this with helm using one mandatory chart value and one optional value:

 * `webhookRepFullname` the git repo name eg "simbo1905/demo1". This is a mane value. 
 * `webhookRefRegex` the regex to match on to trigger builds. It defaults to `v.*` that matches anything like `v1.0.1`. You can use a sophisticated regex to match full semver2 format if you so wish. 


