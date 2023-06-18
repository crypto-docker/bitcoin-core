FROM cryptodockerhub/coin-base:latest
LABEL maintainer="Mahsum UREBE <info@mahsumurebe.com>"
LABEL description="Bitcoin Core Docker Image"

ENV COIN_VERSION="25.0"
ENV TARBALL_NAME="bitcoin-${COIN_VERSION}"
ENV BINARY_URL="https://bitcoincore.org/bin/bitcoin-core-${COIN_VERSION}/${TARBALL_NAME}-x86_64-linux-gnu.tar.gz"
ENV COIN_TMP="/var/tmp/"
ENV COIN_CONF_FILE="${COIN_ROOT_DIR}/config.conf"

RUN curl -L "${BINARY_URL}" -o "${COIN_TMP}/${TARBALL_NAME}-x86_64-linux-gnu.tar.gz" \
    && tar -C "${COIN_TMP}" -xzvf "${COIN_TMP}/${TARBALL_NAME}-x86_64-linux-gnu.tar.gz"

RUN mv ${COIN_TMP}/${TARBALL_NAME}/bin/* /usr/bin/ \
    && mv ${COIN_TMP}/${TARBALL_NAME}/include/* /usr/include/ \
    && mv ${COIN_TMP}/${TARBALL_NAME}/lib/* /usr/lib/ \
    && mv ${COIN_TMP}/${TARBALL_NAME}/share/* /usr/share/ \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY "docker-entrypoint.sh" /entrypoint.sh
COPY "config.conf" "${COIN_CONF_FILE}"
COPY "scripts/" "${COIN_SCRIPTS}/"

RUN chown -R coinuser:coingroup "${COIN_ROOT_DIR}/"

EXPOSE 8332 18332 18443 8333 18333 18444

VOLUME ["${COIN_ROOT_DIR}"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bitcoind"]
