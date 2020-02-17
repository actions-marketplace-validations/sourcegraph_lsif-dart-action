FROM google/dart:2.7 as builder

# The commit at which to build lsif-dart
ENV INDEXER_COMMIT=9987ef9325e08fa3f650c88ef28e2074f6fcaadf
ENV CLONE_URL="https://github.com/sourcegraph/lsif-dart.git"

LABEL version="0.1.0"
LABEL repository="http://github.com/sourcegraph/lsif-dart-action"
LABEL homepage="http://github.com/sourcegraph/lsif-dart-action"
LABEL maintainer="Sourcegraph Support <support@sourcegraph.com>"

LABEL "com.github.actions.name"="Sourcegraph Dart LSIF Indexer"
LABEL "com.github.actions.description"="Generate LSIF data from Dart source code"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="purple"

WORKDIR /crossdart
RUN git clone "${CLONE_URL}" . && \
    git checkout -q "${INDEXER_COMMIT}" && \
    pub get

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
