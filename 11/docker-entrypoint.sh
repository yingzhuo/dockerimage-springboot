#!/usr/bin/env bash

set -e

# ----------------------------------------------------------------------------------
# check timezone, if not set. default to Asia/Shanghai
# ----------------------------------------------------------------------------------
tz="${APP_TIMEZONE}"

if [[ "$tz" == "" ]]; then
  tz="${APP_TZ}"
fi

if [[ "${tz}" == "" ]]; then
  tz="Asia/Shanghai"
fi

# ----------------------------------------------------------------------------------
# check language. default to chinese
# ----------------------------------------------------------------------------------
lang="${APP_LANG}"
if [[ "$lang" == "" ]]; then
  lang="zh"
fi

# ----------------------------------------------------------------------------------
# check country. default to CHINA
# ----------------------------------------------------------------------------------
country="${APP_COUNTRY}"
if [[ "$country" == "" ]]; then
  country="CN"
fi

# ----------------------------------------------------------------------------------
# startup
# ----------------------------------------------------------------------------------
exec java \
  -Djava.security.egd=file:/dev/./urandom \
  -Duser.timezone="${tz}" \
  -Duser.language="${lang}" \
  -Duser.country="${country}" \
  -Djava.io.tmpdir=/tmp \
  org.springframework.boot.loader.JarLauncher \
  "$@"
