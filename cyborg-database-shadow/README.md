# cyborg-database-shadow

## Quick Start

#### Download&Install

Please head to the [releases page](https://www.apache.org/dyn/closer.cgi/shardingsphere/5.0.0/apache-shardingsphere-5.0.0-shardingsphere-proxy-bin.tar.gz) to download 5.0.0 release of Apache ShardingSphere.

#### Configuration

The `conf` directory contains the template configuration files by default `config-shadow.yaml` and `server.yaml`. 

If the template configuration files by default meet your business needs, replace the corresponding configuration file.

Please refer to [ShardingSphere-Proxy Configuration Manual](https://shardingsphere.apache.org/document/5.0.0/en/user-manual/shardingsphere-proxy/configuration/), if you want to learn more.

#### Dependencies

If the backend database is PostgreSQL, there's no need for additional dependencies.

If the backend database is MySQL, please download [mysql-connector-java-5.1.47.jar](https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.47/mysql-connector-java-5.1.47.jar) or [mysql-connector-java-8.0.11.jar](https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.11/mysql-connector-java-8.0.11.jar) and put it into `%SHARDINGSPHERE_PROXY_HOME%/lib` directory.

#### Start Server

```shell
sh %SHARDINGSPHERE_PROXY_HOME%/bin/start.sh
```
> Default port is 3307.

Please refer to [ShardingSphere-Proxy Start Server](https://shardingsphere.apache.org/document/5.0.0/en/quick-start/shardingsphere-proxy-quick-start/#3-start-server), if you want learn more.

## Use Example

Take the INSERT statement as an example.

```sql
INSERT INTO table (column,…) VALUES (value,…);
```
will be executed to the production DB.

```sql
INSERT INTO table (column,…) VALUES (value,…)/*cyborg-flow:true*/;
```
will be executed to the shadow DB.

Please refer to  [ShardingSphere-shadow](https://shardingsphere.apache.org/document/5.0.0/en/reference/shadow/), if you want to learn more.

## Use Norms

SQL support，please refer to [ShardingSphere-shadow use-norms](https://shardingsphere.apache.org/document/5.0.0/en/features/shadow/use-norms/)
