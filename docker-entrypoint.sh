#!/usr/bin/env bash
set -e
CMD=$1
ARGS=("${@}")
ARGS=("${ARGS[@]:1}")

chown -R coinuser:coingroup "${COIN_ROOT_DIR}/"

if [ "$(echo "$CMD" | cut -c1)" = "-" ]; then
  set -- bitcoind "$@"
fi

if [ "$CMD" = "bitcoind" ] || [ "$CMD" = "pacglobal-cli" ]; then
  # Set config file
  ARGS=("-conf=\"$COIN_CONF_FILE\"" "${ARGS[@]}")
fi
if [ "$CMD" = "bitcoind" ]; then
  # Set config file
  ARGS=("-printtoconsole" "${ARGS[@]}")
fi

EXECUTABLE="${CMD} ${ARGS[*]}"

if [ "$CMD" = "bitcoind" ] || [ "$CMD" = "pacglobal-cli" ] || [ "$CMD" = "pacglobal-tx" ]; then
  exec gosu stk "$EXECUTABLE"
else
  exec "$@"
fi
