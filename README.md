# ocd-builder-webhook

This is a webhook chart to trigger ocd-builder to create a tagged s2i image from git tags. 

It is implemented using the [we hook engine](https://github.com/adnanh/webhook/blob/master/webhook.go) that pattern matches webhook JSON using Go and then invokes a simple shell script. The shell script updates the ocd-builder configuration to reference the new git tag which triggers a build. 

## Usage

You configure this chart by setting the following values:

 * `webhookRepFullname` @required The git repo name eg "simbo1905/demo1". 
 * `buildNamespace` @required Sets BUILD_NAMESPACE the k8s namespace or openshift project where the build resides
 * `build` @required Sets BUILD the name of openshift BuildConfig to update with the git tag_name
 * `webhookRefRegex` the regex to match on to trigger builds. It defaults to `v.*` that matches anything like `v1.0.1`. You can use a sophisticated regex to match full semver2 format if you so wish. 

For example:

```
helm upgrade --install \
    --set "webhookRepFullname=simbo1905/demorepo,buildNamespace=myproject,build=demobuild" \
    ocd-builder-webhook-my-app \
    ocd-builder-webhook
```
