FROM alpine:3.6
RUN apk -v --update add \
        gawk\
        openssh-keygen \
        ca-certificates \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        curl \
        && \
    pip install --upgrade awscli==1.16.97 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

RUN set -x && \
    apk add --update "libintl" && \
    apk add --virtual build_deps "gettext" &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps
    
RUN curl -O https://github.com/kubernetes/kops/releases/download/1.14.0-alpha.3/kops-linux-amd64 && \
    mv ./kops-linux-amd64 /usr/local/bin/kops && \
    chmod +x /usr/local/bin/kops

VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
