if [ ! -f /data/config.yaml ]; then
  cat /dynomite/config.yaml | envsubst > /data/config.yaml
fi

"$@"
