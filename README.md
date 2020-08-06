# dockerimage-springboot

#### 拉取地址

* registry.cn-shanghai.aliyuncs.com/yingzhuo/springboot:8
* registry.cn-shanghai.aliyuncs.com/yingzhuo/springboot:11

#### 用法

##### Dockerfile:

```dockerfile
# ----------------------------------------------------------------------------------
# 预构建阶段
# ----------------------------------------------------------------------------------
FROM registry.cn-shanghai.aliyuncs.com/yingzhuo/springboot:8 as builder
WORKDIR /tmp
COPY ./*.jar app.jar

# 解压缩并删除无用依赖和无用文件
RUN java -Djarmode=layertools -jar /tmp/app.jar extract && \
    rm -rf /tmp/dependencies/BOOT-INF/lib/spring-boot-jarmode-layertools-*.jar && \
    rm -rf /tmp/application/BOOT-INF/classpath.idx && \
    rm -rf /tmp/application/BOOT-INF/layers.idx

# ----------------------------------------------------------------------------------
# 实际构建阶段
# ----------------------------------------------------------------------------------
FROM registry.cn-shanghai.aliyuncs.com/yingzhuo/springboot:8

# 分层拷贝
COPY --from=builder /tmp/dependencies/ ./
COPY --from=builder /tmp/spring-boot-loader/ ./
COPY --from=builder /tmp/snapshot-dependencies/ ./
COPY --from=builder /tmp/application/ ./

# 预设环境变量
ENV APP_PROFILES=k8s

# 暴露端口 (Optional)
EXPOSE 8080
```

##### layers.xml:

```xml
<?xml version="1.0" encoding="utf-8"?>
<layers xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns="http://www.springframework.org/schema/boot/layers"
        xsi:schemaLocation="http://www.springframework.org/schema/boot/layers
                     https://www.springframework.org/schema/boot/layers/layers-2.3.xsd">

    <application>
        <into layer="spring-boot-loader">
            <include>org/springframework/boot/loader/**</include>
        </into>
        <into layer="application"/>
    </application>

    <dependencies>
        <into layer="snapshot-dependencies">
            <include>*:*:*SNAPSHOT</include>
        </into>
        <into layer="internal-dependencies">
            <include>com.github.yingzhuo:kse-common:*</include>
        </into>
        <into layer="dependencies"/>
    </dependencies>

    <layerOrder>
        <layer>dependencies</layer>
        <layer>spring-boot-loader</layer>
        <layer>internal-dependencies</layer>
        <layer>snapshot-dependencies</layer>
        <layer>application</layer>
    </layerOrder>

</layers>
```

##### spring boot maven plugin

```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <version>${springboot.version}</version>
    <executions>
        <execution>
            <goals>
                <goal>repackage</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <layers>
            <enabled>true</enabled>
            <configuration>${project.basedir}/src/layers.xml</configuration>
        </layers>
    </configuration>
</plugin>
```

#### 注意

* 本镜像基于OpenJDK
