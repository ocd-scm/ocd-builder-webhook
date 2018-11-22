# This image provides tools for OCD. 
# The following packages are installed as latest available on centos7:
#  - git https://jwiegley.github.io/git-from-the-bottom-up/
#  - cowsay https://en.wikipedia.org/wiki/Cowsay
#  - jq  https://stedolan.github.io/jq/
#  - yq https://github.com/kislyuk/yq
# The following packages are downloaded and installed using an explict version number:
#  - hub 2.4.0 https://hub.github.com 
#  - oc 3.9.0 https://docs.openshift.org/latest/cli_reference/index.html
#  - git-secret 0.2.4 http://git-secret.io
#  - gpg 2.2.9 https://www.gnupg.org)
#  - helm 2.9.0 
#  - webhook 2.6.9

FROM simonmassey/ocd-tools

MAINTAINER Simon Massey <simbo1905@60hertz.com>

COPY ./bin/* /usr/local/bin/

COPY hooks.json /opt/app-root/src

USER 1001

EXPOSE 9000

CMD  ["/usr/local/bin/webhook", "-verbose", "-hotreload", "-template"]