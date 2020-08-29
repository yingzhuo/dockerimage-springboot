# dockerimage-springboot

#### How to pull

* `docker image pull registry.cn-shanghai.aliyuncs.com/yingzhuo/springboot:8`
* `docker image pull registry.cn-shanghai.aliyuncs.com/yingzhuo/springboot:11`

#### Supported Env Configuration

Name                       | Default Value                  | Meaning
---------------------------|--------------------------------|---------------------------------------------------------------------
APP_TIMEZONE,APP_TZ        | Asia/Shanghai                  | java -Duser.timezone="${tz}"
APP_LANG                   | zh                             | java -Duser.language="${lang}"
APP_COUNTRY                | CN                             | java -Duser.country="${country}"
