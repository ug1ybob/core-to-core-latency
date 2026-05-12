# nviennot/core-to-core-latency in docker

Original author: [Nicolas Viennot](https://github.com/nviennot)

Reference: [core-to-core-latency: Measuring CPU core-to-core latency](https://github.com/nviennot/core-to-core-latency)

## Usage

```
export mdl="$(awk -F': ' '/model name/{print $2;exit}' /proc/cpuinfo)";
docker run --rm ug1ybob/core-to-core-latency:1.2.0 --csv >${mdl}.csv
docker run --rm --entrypoint ctcl2png ug1ybob/core-to-core-latency:1.2.0 --expression "m[:22,:22]" --title "$mdl" <${mdl}.csv >${mdl}.png
```
```
export mdl="$(awk -F': ' '/model name/{print $2;exit}' /proc/cpuinfo)";
docker run --rm ug1ybob/core-to-core-latency:1.2.0 --expression "m[:22,:22]" --title "$mdl" --png >${mdl}.png
