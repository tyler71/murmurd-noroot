FROM busybox:latest AS builder
LABEL FORKED_FROM_AUTHOR="Matt Kemp"
LABEL MAINTAINER="TylerY"
LABEL MAINTAINER_EMAIL="issues@tylery.org"

ENV version=1.3.2

# Download statically compiled murmur and install it to /opt/murmurd
WORKDIR /opt
RUN wget "https://github.com/mumble-voip/mumble/releases/download/${version}/murmur-static_x86-${version}.tar.bz2" \
        -O murmurd.bz2                                                                                             \
 && tar --bzip2 --extract                                                                                          \
        --file murmurd.bz2                                                                                         \ 
        murmur-static_x86-${version}/murmur.x86                                                                    \
        && mv murmur-static_x86-${version}/murmur.x86 /opt/murmurd


FROM busybox:latest

# Grab murmurd from builder stage
COPY --from=builder /opt/murmurd /opt/murmurd

# Copy in our slightly tweaked INI which points to our volume 
# and drops privileges to murmur user
COPY data/murmur.ini /etc/murmur.ini

# Announce appropriate ports
EXPOSE 64738/tcp 64738/udp

# Add murmur user with no password, set to UID 1000, and set home dir
# Create DIR and chown it. Prevents some permission issues
RUN adduser -D -u 1000 -h /var/murmur murmur \
    && mkdir /data                           \
    && chown murmur:murmur -R /data

# Read murmur.ini and murmur.sqlite from /data/
VOLUME ["/data"]

# Run murmurd
ENTRYPOINT ["/opt/murmurd", "-fg", "-v"]
CMD ["-ini", "/etc/murmur.ini"]
