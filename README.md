# ocd-builder-webhook

This is a webhook chart to trigger an openshift build to perform a release build. If you use ocd-build you can have it automatically tag the built container image with the git tag. 

# Architecture

![alt text][ocd-build-components]

[ocd-build-components]: https://github.com/ocd-scm/ocd-meta/blob/master/imgs/ocd-webhook.png?raw=true "OCD Builder Components"

It is implemented using the awesome [webhook engine](https://github.com/adnanh/webhook/blob/master/webhook.go) which is a small but beautful Go app that is configured to match and extract webhook json to invoke shell script. The shell script then logs into openshift and patches the git tag into the build config. 

## Usage

The [ocd-meta wiki](https://github.com/ocd-scm/ocd-meta/wiki) has a full tutorial on each of 

## See Also


[ocd-builder](https://github.com/ocd-scm/ocd-builder)
