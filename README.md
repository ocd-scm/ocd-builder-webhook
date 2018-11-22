# ocd-builder-webhook

This is a webhook chart to trigger an openshift build to perform a release build. If you use ocd-build you can have it automatically tag the built container image with the git tag. 

![alt text][ocd-build-components]

[ocd-build-components]: https://raw.githubusercontent.com/ocd-scm/ocd-meta/master/imgs/ocd-build-components.png "OCD Builder Components"

It is implemented using the awesome [webhook engine](https://github.com/adnanh/webhook/blob/master/webhook.go) which is a small but beautful Go app that is configured to match and extract webhook json to invoke shell script. The shell script then logs into openshift and patches the git tag into the build config. 

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

## Security

You can setup a seperate build project on openshift that only has build permissions:

```oc create role buildpatch --verb=patch --resource=buildconfigs.build.openshift.io  -n buildproject
oc adm policy add-role-to-user buildpatch $USER --role-namespace=buildproject -n buildproject

oc create role buildinstantiate --verb=create --resource=buildconfigs.build.openshift.io/instantiate  -n buildproject
oc adm policy add-role-to-user buildinstantiate $USER --role-namespace=buildproject -n buildproject
```
