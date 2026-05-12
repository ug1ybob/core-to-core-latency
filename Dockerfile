FROM ubuntu:26.04 AS builder
ARG ctcl_version=1.2.0
RUN \
    apt update -q --fix-missing \
 && DEBIAN_FRONTEND=nontineractive apt install -qy --no-install-recommends \
      ca-certificates cargo \
 && cargo install \
      --version $ctcl_version \
      --root /usr/local \
      core-to-core-latency

FROM python:3.14.4-slim-trixie
RUN \
     pip3 install \
       --no-cache-dir \
       --break-system-packages \
       --disable-pip-version-check \
         matplotlib \
         pandas
ADD ctcl2png /usr/local/bin/
ADD entrypoint.sh /
COPY --from=builder /usr/local/bin/core-to-core-latency /usr/local/bin/
ENTRYPOINT ["/entrypoint.sh"]
