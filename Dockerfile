FROM golang:1.13

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        curl \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd rust --user-group --create-home --shell /bin/bash

USER rust
ENV PATH="/home/rust/.cargo/bin:${PATH}" \
    CARGO_HOME="/home/rust/.cargo" \
    RUSTUP_HOME="/home/rust/.rustup"
RUN mkdir -p ${CARGO_HOME} \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && chown -R rust: /home/rust

USER root
WORKDIR /go/src/github.com/pacedotdev/
RUN echo "d"
RUN git clone https://github.com/thavlik/oto.git
WORKDIR /go/src/github.com/pacedotdev/oto
RUN go get -u ./...
RUN go install
ENV templates=$GOPATH/src/github.com/pacedotdev/oto/otohttp/templates

USER rust
WORKDIR /home/rust
RUN echo "edition = \"2018\"" >> .rustfmt.toml
CMD ["oto"]
