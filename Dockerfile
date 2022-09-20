FROM golang:1.19.1-bullseye

LABEL "maintainer"="Andrew N Golovkov <andrew.golovkov@gmail.com>"
LABEL "repository"="https://github.com/Andor/action-jsonnet"
LABEL "homepage"="https://github.com/Andor/action-jsonnet"

LABEL "com.github.actions.name"="jsonnet"
LABEL "com.github.actions.description"="Run Jsonnet Tools: jsonnetfmt and jsonnet-lint"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="gray-dark"

# master branch on 14 September 2022
# update to stable after https://github.com/google/go-jsonnet/pull/623 will be in the release
ENV JSONNET_REF=cb3a7596213eb45d203d77287ead26dbe452bd92
RUN \
  go install \
  github.com/google/go-jsonnet/cmd/jsonnet-lint@$JSONNET_REF \
  github.com/google/go-jsonnet/cmd/jsonnetfmt@$JSONNET_REF

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
