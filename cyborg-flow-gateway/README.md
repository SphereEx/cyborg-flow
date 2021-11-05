# cyborg-database-gateway

## Quick Start (base on CentOS 7)

#### Install the RPM repositories for OpenResty and Apache APISIX

```shell
sudo yum install -y https://repos.apiseven.com/packages/centos/apache-apisix-repo-1.0-1.noarch.rpm
```

#### Install Apache APISIX and all dependencies via RPM package

```shell
sudo yum install -y https://repos.apiseven.com/packages/centos/7/x86_64/apisix-2.10.1-0.el7.x86_64.rpm
```

#### Configuration

The `conf` directory contains the Apache APISIX configuration file `config.yaml` and the routing rules for Stand-alone mode `apisix.yaml`.

##### Custom Configuration

- overwrite the `/usr/local/apisix/conf/config.yaml` file with this project file `cyborg-flow-gateway/conf/config.yaml`.
- copy the project file `cyborg-flow-gateway/conf/apisix.yaml` to the `/usr/local/apisix/conf/`.

##### Custom Configuration Description

1. `config_center: yaml` in `cyborg-flow-gateway/conf/config.yaml` means that Apache APISIX is in Stand-alone mode and reads routing rules from `apisix.yaml`. For more information, see [Stand-alone mode](https://github.com/apache/apisix/blob/master/docs/en/latest/stand-alone.md).

   ```yaml
   plugins:
     - proxy-rewrite
     - skywalking
   plugin_attr:
     skywalking:
       service_name: APISIX
       service_instance_name: "APISIX Instance Name"
       endpoint_addr: http://${skywalking_endpoint}:12800 # please replace with the address of your SkyWalking Endpoint
   ```

   `plugins` option is uesd to configure the list of enabled plugins. `plugin_attr` option is used to configure the properties of the plugin. For more information about the SkyWalking plugin, see [skywalking](https://github.com/apache/apisix/blob/master/docs/en/latest/plugins/skywalking.md).


2. in `cyborg-flow-gateway/conf/apisix.yaml`

   ```yaml
    plugins:
      proxy-rewrite:
        headers:
          sw8-correlation: Y3lib3JnLWZsb3c=:dHJ1ZQ==
   ```
   means that use `proxy-rewrite` plugin in Apache APISIX to inject `sw8-correlation: Y3lib3JnLWZsb3c=:dHJ1ZQ==` into the headers of the request. `Y3lib3JnLWZsb3c=` is the Base 64 encoding format for `cyborg-flow`, and `dHJ1ZQ==` is the Base 64 encoding for `true`.
   For more information, see [proxy-rewrite](https://github.com/apache/apisix/blob/master/docs/en/latest/plugins/proxy-rewrite.md).

   `skywalking` means that the SkyWalking plugin is enabled on this route, `sample_ratio` is the sample rate of the SkyWalking plugin.

#### Start Server

```shell
apisix start
```

> Default port is 9080.

## Test

1. Send a request to Apache APISIX to trigger the route rule and test if it works:

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

   From the response of `httpbin.org` shows that APISIX successfully injected `"Sw8-Correlation": "Y3lib3JnLWZsb3c=:dHJ1ZQ=="` into the headers of the request.

2. Use the command line tool `swctl` in SkyWalking to check the registration status of Apache APISIX with SkyWalking:

   ```shell
   $ ./bin/swctl service ls
   [{"id":"QVBJU0lY.1","name":"APISIX","group":""}]
   ```

   Apache APISIX is successfully registered on SkyWalking.
