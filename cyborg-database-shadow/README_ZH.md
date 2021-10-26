# cyborg-database-shadow

## 快速开始

#### 下载

```shell
git clone https://github.com/apache/shardingsphere
```

#### 编译&安装

> %SHARDINGSPHERE_PROXY_HOME% 为 Proxy 解压后的路径，例：/Users/ss/shardingsphere-proxy-bin/

```shell
./mvnw clean install -Dmaven.javadoc.skip=true -B -Drat.skip=true -Djacoco.skip=true -Dmaven.test.skip=true -T1C -Prelease

cd shardingsphere-distribution/ shardingsphere-proxy-distribution/target

tar zxvf apache-shardingsphere-{version}-SNAPSHOT-shardingsphere-proxy-bin.tar.gz -C  %SHARDINGSPHERE_PROXY_HOME%/
```

#### 配置

`conf` 目录包含默认模板配置文件 `config-shadow.yaml` 和 `server.yaml`。

如果默认模板配置文件满足您的业务需求，请更换相应的配置文件。

如果需要了解更多的信息，请参阅 [ShardingSphere-Proxy Configuration Manual](https://shardingsphere.apache.org/document/current/cn/user-manual/shardingsphere-proxy/configuration/)

#### 依赖

If the backend database is PostgreSQL, there's no need for additional dependencies.

If the backend database is MySQL, please download [mysql-connector-java-5.1.47.jar](https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.47/mysql-connector-java-5.1.47.jar) or [mysql-connector-java-8.0.11.jar](https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.11/mysql-connector-java-8.0.11.jar) and put it into `%SHARDINGSPHERE_PROXY_HOME%/lib` directory.

#### 启动服务

```shell
sh %SHARDINGSPHERE_PROXY_HOME%/bin/start.sh
```
> 默认启动端口为： `3307`

如果需要了解更多的信息，请参阅 [ShardingSphere-Proxy Start Server](https://shardingsphere.apache.org/document/current/cn/quick-start/shardingsphere-proxy-quick-start/#3-start-server)

## 使用样例

以 `INSERT` 语句为例，

```sql
INSERT INTO table (column,…) VALUES (value,…);
```
会在生产库执行.

```sql
INSERT INTO table (column,…) VALUES (value,…);
```
会在影子库执行.

如果需要了解更多的信息，请参阅 [ShardingSphere-shadow](https://shardingsphere.apache.org/document/current/cn/reference/shadow/)
