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
        gettext \
        libintl \
        && \
    mv /usr/bin/envsubst /usr/local/sbin/envsubst && \
    pip install --upgrade awscli==1.16.97 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*
VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
