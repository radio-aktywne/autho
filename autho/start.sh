#!/bin/sh

envsub() {
  eval "cat <<EOF
$(cat "$1")
EOF
" 2>/dev/null
}

until [ -f /etc/certs/ca.pem ] &&
  [ -f /etc/certs/cert.pem ] &&
  [ -f /etc/certs/key.pem ]; do
  echo "Waiting for certificates..."
  sleep 1
done

cat /etc/certs/ca.pem >>/etc/ssl/certs/ca-certificates.crt

find ./conf -type f | while IFS= read -r file; do
  # shellcheck disable=SC2005
  echo "$(envsub "$file")" >"$file"
done

oathkeeper serve --sqa-opt-out -c /app/conf/config.yaml
