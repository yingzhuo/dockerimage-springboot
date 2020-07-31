#!/usr/bin/env bash

set -e

# ----------------------------------------------------------------------------------
# check debug mode
# ----------------------------------------------------------------------------------
if [[ "${APP_DEBUG}" == "true" ]]; then
  debug_mode="--debug"
else
  debug_mode=""
fi

# ----------------------------------------------------------------------------------
# check spring-boot active profiles
# ----------------------------------------------------------------------------------
profiles="${APP_PROFILES}"

if [[ "${profiles}" == "" ]]; then
  profiles="${SPRING_PROFILES_ACTIVE}"
fi

if [[ "${profiles}" == "" ]]; then
  export APP_PROFILES='default'
  export SPRING_PROFILES_ACTIVE='default'
else
  export APP_PROFILES="${profiles}"
  export SPRING_PROFILES_ACTIVE="${profiles}"
fi

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
  "${debug_mode}" \
  "$@"
