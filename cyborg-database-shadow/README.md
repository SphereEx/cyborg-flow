# cyborg-database-shadow

## Quick Start

#### Download

```shell
git clone https://github.com/apache/shardingsphere
```

#### Make&Install

> %SHARDINGSPHERE_PROXY_HOME% is the shardingsphere proxy extract path. for example: /Users/ss/shardingsphere-proxy-bin/

```shell
./mvnw clean install -Dmaven.javadoc.skip=true -B -Drat.skip=true -Djacoco.skip=true -Dmaven.test.skip=true -T1C -Prelease

cd shardingsphere-distribution/ shardingsphere-proxy-distribution/target

tar zxvf apache-shardingsphere-{version}-SNAPSHOT-shardingsphere-proxy-bin.tar.gz -C  %SHARDINGSPHERE_PROXY_HOME%/
```

#### Configuration

The `conf` directory contains the default template configuration files `config-shadow.yaml` and `server.yaml`. 

If the default template configuration files meet your business needs, replace the corresponding configuration file.

Please refer to [ShardingSphere-Proxy Configuration Manual](https://shardingsphere.apache.org/document/current/en/user-manual/shardingsphere-proxy/configuration/), if you want learn more.

#### Dependencies

If the backend database is PostgreSQL, there's no need for additional dependencies.

If the backend database is MySQL, please download [mysql-connector-java-5.1.47.jar](https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.47/mysql-connector-java-5.1.47.jar) or [mysql-connector-java-8.0.11.jar](https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.11/mysql-connector-java-8.0.11.jar) and put it into `%SHARDINGSPHERE_PROXY_HOME%/lib` directory.

#### Start Server

```shell
sh %SHARDINGSPHERE_PROXY_HOME%/bin/start.sh
```
> Default port is 3307.

Please refer to [ShardingSphere-Proxy Start Server](https://shardingsphere.apache.org/document/current/en/quick-start/shardingsphere-proxy-quick-start/#3-start-server), if you want learn more.

## Use Example

Take the INSERT statement as an example.

```sql
INSERT INTO table (column,…) VALUES (value,…);
```
will be executed to the production DB.

```sql
INSERT INTO table (column,…) VALUES (value,…);
```
will be executed to the shadow DB.

Please refer to  [ShardingSphere-shadow](https://shardingsphere.apache.org/document/current/en/reference/shadow/), if you want learn more.
