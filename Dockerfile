FROM busybox:latest AS builder
LABEL FORKED_FROM="Matt Kemp"
LABEL MAINTAINER="TylerY"
LABEL MAINTAINER_EMAIL="issues@tylery.org"

ENV version=1.3.2

# Download statically compiled murmur and install it to /opt/murmur
ADD https://github.com/mumble-voip/mumble/releases/download/${version}/murmur-static_x86-${version}.tar.bz2 /opt/
RUN bzcat /opt/murmur-static_x86-${version}.tar.bz2 | tar -x -C /opt -f -


FROM busybox:latest AS server

# Copy in our static binary
COPY --from=builder /opt/murmur-static_x86-${version}/murmur.x86 /opt/murmurd

# Copy in our slightly tweaked INI which points to our volume
COPY murmur.ini /etc/murmur.ini

# Forward apporpriate ports
EXPOSE 64738/tcp 64738/udp

# add murmur user, set to UID 1000, and set home dir
# create DIR and chown it. Prevents some permission issues
RUN adduser -D -u 1000 -h /var/murmur murmur \
    && mkdir /data \
    && chown murmur:murmur -R /data

# Read murmur.ini and murmur.sqlite from /data/
VOLUME ["/data"]

# Run murmur
ENTRYPOINT ["/opt/murmurd", "-fg", "-v"]
CMD ["-ini", "/etc/murmur.ini"]
