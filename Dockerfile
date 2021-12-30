# syntax=docker/dockerfile:1

FROM ubuntu:21.04
ENV MDSPRSV=0.1.3
ENV EZBEQV=0.11.1
WORKDIR /tmp

RUN apt-get update \
  && apt-get install --no-install-recommends -y libusb-1.0 python3 python3-pip libyaml-dev \
  && rm -rf /var/lib/apt/lists/*

ADD https://github.com/mrene/minidsp-rs/releases/download/v${MDSPRSV}/minidsp_${MDSPRSV}_amd64.deb /tmp/

RUN apt install /tmp/minidsp_${MDSPRSV}_amd64.deb && rm /tmp/minidsp_${MDSPRSV}_amd64.deb

RUN pip install ezbeq==${EZBEQV}

CMD ["systemctl enable minidsp.service"]
CMD ["systemctl start minidsp.service"]
