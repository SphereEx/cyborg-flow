# cyborg-agent

## Quick start

1. Please head to the [releases page](https://skywalking.apache.org/downloads/) to download a release of Apache SkyWalking Java Agent.

2. Build `cyborg-agent` and replace plugins. The `SW_AGENT_HOME` should be the `skywalking-java` base directory.
    ```shell
    make replace path=$(SW_AGENT_HOME)
    ```

3. Start application with `skywalking-agent`, for more information please read the [official documentation](https://skywalking.apache.org/docs/#JavaAgent).

## Use Example

We use [Apache SkyWalking Cross Process Correlation Context](https://skywalking.apache.org/docs/main/latest/en/protocols/skywalking-cross-process-correlation-headers-protocol-v1/) 
to decide should we need to use the shadow database. The correlation key and value is: `cyborg-flow=true`. 
In Java, you could be using the [Tracing API](https://skywalking.apache.org/docs/skywalking-java/latest/en/setup/service-agent/java-agent/application-toolkit-trace/) to put the context.