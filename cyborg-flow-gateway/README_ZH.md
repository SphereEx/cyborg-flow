# cyborg-flow-gateway

## 快速开始（基于 CentOS 7）

#### 安装 OpenResty 和 Apache APISIX 的 RPM 仓库

```shell
sudo yum install -y https://repos.apiseven.com/packages/centos/apache-apisix-repo-1.0-1.noarch.rpm
```

#### 通过 RPM 包安装 Apache APISIX 及所有依赖

```shell
sudo yum install -y https://repos.apiseven.com/packages/centos/7/x86_64/apisix-2.10.1-0.el7.x86_64.rpm
```

#### 配置

`conf` 目录包含 Apache APISIX 的配置文件 `config.yaml` 和 Stand-alone 模式的路由规则 `apisix.yaml`。

##### 自定义配置

- 用本项目文件 `cyborg-flow-gateway/conf/config.yaml` 文件覆盖 `/usr/local/apisix/conf/config.yaml`；
- 用本项目文件 `cyborg-flow-gateway/conf/apisix.yaml` 复制到 `/usr/local/apisix/conf/` 路径下；

##### 自定义配置说明

1. `cyborg-flow-gateway/conf/config.yaml` 中的 `config_center: yaml` 表示 Apache APISIX 启用 Stand-alone 模式，从 `apisix.yaml` 读取路由规则。如果需要了解更多的信息，请参阅 [Stand-alone 模式](https://github.com/apache/apisix/blob/master/docs/zh/latest/stand-alone.md) 。

   ```yaml
   plugins:
     - proxy-rewrite
     - skywalking
   plugin_attr:
     skywalking:
       service_name: APISIX
       service_instance_name: "APISIX Instance Name"
       endpoint_addr: http://${skywalking_endpoint}:12800 # 请替换为您的 SkyWalking Endpoint 的地址
   ```
  
   `plugins` 选项用于配置启用的插件列表。`plugin_attr` 选项用于配置插件的属性。如果需要了解更多 SkyWalking 插件的属性，请参阅 [skywalking](https://github.com/apache/apisix/blob/master/docs/zh/latest/plugins/skywalking.md) 。


2. `cyborg-flow-gateway/conf/apisix.yaml` 中

   ```yaml
    plugins:
      proxy-rewrite:
        headers:
          sw8-correlation: Y3lib3JnLWZsb3c=:dHJ1ZQ==
      skywalking:
        sample_ratio: 1
   ```
   表示在 Apache APISIX 中添加 `proxy-rewrite` 插件，利用该插件向请求的 headers 中注入 `sw8-correlation: Y3lib3JnLWZsb3c=:dHJ1ZQ==`。`Y3lib3JnLWZsb3c=` 是 `cyborg-flow` 的 Base 64 编码格式，`dHJ1ZQ==` 是 `true` 的 Base 64 编码。
   如果需要了解更多的信息，请参阅 [proxy-rewrite](https://github.com/apache/apisix/blob/master/docs/zh/latest/plugins/proxy-rewrite.md) 。

   `skywalking` 表示在该 route 上开启 SkyWalking 插件，`sample_ratio` 表示 SkyWalking 插件的采样率。
 
#### 启动服务

```shell
apisix start
```

> 默认启动端口为： `9080`

## 测试

1. 发送请求到 Apache APISIX，触发路由规则，测试是否正常：

   ```shell
   $ curl 127.0.0.1:9080/get
   {
     "args": {},
     "headers": {
       "Accept": "*/*",
       "Host": "127.0.0.1",
       "Sw8-Correlation": "Y3lib3JnLWZsb3c=:dHJ1ZQ==",
       "User-Agent": "curl/7.29.0",
       "X-Amzn-Trace-Id": "Root=1-61822115-4c57f6ee321faa2d49cc5a61",
       "X-Forwarded-Host": "127.0.0.1"
     },
     "origin": "127.0.0.1, 180.118.190.54",
     "url": "http://127.0.0.1/get"
   }
   ```

   从 `httpbin.org` 返回的响应可以看到，Apache APISIX 成功向请求的 headers 中注入了 `"Sw8-Correlation": "Y3lib3JnLWZsb3c=:dHJ1ZQ=="`。


2. 在 SkyWalking 中用命令行工具 `swctl` 查看 Apache APISIX 在 SkyWalking 注册状态：

   ```shell
   $ ./bin/swctl service ls
   [{"id":"QVBJU0lY.1","name":"APISIX","group":""}]
   ```

   可以看到 Apache APISIX 在 SkyWalking 注册成功。
