
## No more in use! using https://github.com/open-cartography/opentelemetry-demo ...

# open-cartography-demo

![](https://github.com/open-cartography/.github/blob/main/footsteps/2023-04-01%20SegmentedWorm.png)
2023-04-01 Screenshot

## quick start
```shell
git clone --recurse-submodules https://github.com/open-cartography/open-cartography-demo.git
```

## to run demo

```shell
make
```




## About

Mainly a follow-up from ideas from following blog posts:
- [Service Topology Map from Prometheus metrics](https://tractatus.one/shahmaran-20a9f1678)
- [Pathways— Metrics to Traces](https://tractatus.one/pathways-metrics-to-traces-55a7d6c8682a)


Boiling down the explorations over the topological capabilities and limitations of the spanmetrics and servicegraph processors
available in the opentelemetry contrib library into visuals.

Decluttering the visualizations from scratch on service level, and possibly and hopefully then on the level of the individual spans.


* [Webstore](http://localhost:8080/)
* [Grafana](http://localhost:8080/grafana/)
* [Feature Flags UI](http://localhost:8080/feature/)
* [Load Generator UI](http://localhost:8080/loadgen/)
* [Jaeger UI](http://localhost:8080/jaeger/ui/)
* [Prometheus](http://localhost:9090/)


[//]: # (TODO: Attach commands to makefile)
[//]: # (insert makefile content into document)

👀 [Makefile](https://github.com/open-cartography/open-cartography-demo/blob/main/Makefile)
```shell
make fast-run
```
```shell
make grafana
```
```shell
make otelcol
```






