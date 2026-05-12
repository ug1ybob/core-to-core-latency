# nviennot/core-to-core-latency in docker

Original author: [Nicolas Viennot](https://github.com/nviennot)

Reference: [core-to-core-latency: Measuring CPU core-to-core latency](https://github.com/nviennot/core-to-core-latency)

## Usage

```
core-to-core-latency

USAGE:
    core-to-core-latency [OPTIONS] [ARGS]

ARGS:
    <NUM_ITERATIONS>    The number of iterations per sample [default: 1000]
    <NUM_SAMPLES>       The number of samples [default: 300]

OPTIONS:
    -b, --bench <BENCH>    Select which benchmark to run, in a comma delimited list, e.g., '1,3'
                            1: CAS latency on a single shared cache line.
                            2: Single-writer single-reader latency on two shared cache lines.
                            3: One writer and one reader on many cache line, using the clock.
                            [default: 1]
    -c, --cores <CORES>    Specify the cores by id that should be used, comma delimited. By default
                           all cores are used
        --csv              Outputs the mean latencies in CSV format on stdout
    -h, --help             Print help information
        --png              Outputs the mean latencies in PNG format on stdout
        --expression EXPRESSION
                              Python expression used to pass or transform a NumPy
                              array 'm' (default: m)
        --title TITLE         diagram title (default: Unknown CPU)
        --subtitle SUBTITLE   diagram subtitle (default: None)
        --yticks              boolean controlling y-axis labels existence (default:
                              True)
        --figsize FIGSIZE     Python expression of tuple, describing diagram
                              dimensions (default: None)
```

## Examples

```
export mdl="$(awk -F': ' '/model name/{print $2;exit}' /proc/cpuinfo)";
docker run --rm ug1ybob/core-to-core-latency:1.2.0 --csv >"${mdl}.csv"
docker run --rm --entrypoint ctcl2png ug1ybob/core-to-core-latency:1.2.0 --expression "m[:22,:22]" --title "$mdl" <"${mdl}.csv" >"${mdl}.png"
```
```
export mdl="$(awk -F': ' '/model name/{print $2;exit}' /proc/cpuinfo)";
docker run --rm ug1ybob/core-to-core-latency:1.2.0 --expression "m[:22,:22]" --title "$mdl" --png >"${mdl}.png"
```
