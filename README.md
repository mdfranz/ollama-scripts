# About 

These are instructions and scripts for using [ollamma](https://github.com/ollama/ollama) and installing various models from the [library](https://ollama.com/library)


# GCE Instructions

## Generic Bookworm (Debian 12)

### Check if Nvidia GPU is running

```
$ nvidia-detect
Detected NVIDIA GPUs:
00:04.0 3D controller [0302]: NVIDIA Corporation TU104GL [Tesla T4] [10de:1eb8] (rev a1)

Checking card:  NVIDIA Corporation TU104GL [Tesla T4] (rev a1)
Your card is supported by all driver versions.
Your card is also supported by the Tesla drivers series.
Your card is also supported by the Tesla 470 drivers series.
It is recommended to install the
    nvidia-driver
package.
```

and 

```
$ lsmod | grep nvidia
nvidia_uvm           4661248  2
nvidia_drm             16384  0
nvidia_modeset       1347584  0
nvidia              54059008  13 nvidia_uvm,nvidia_modeset
```

and `lspci -v` you should see

```
00:04.0 3D controller: NVIDIA Corporation TU104GL [Tesla T4] (rev a1)
        Subsystem: NVIDIA Corporation TU104GL [Tesla T4]
        Physical Slot: 4
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at c0000000 (32-bit, non-prefetchable) [size=16M]
        Memory at 400000000 (64-bit, prefetchable) [size=256M]
        Memory at 410000000 (64-bit, prefetchable) [size=32M]
        Capabilities: [60] MSI-X: Enable+ Count=6 Masked-
        Capabilities: [6c] Power Management version 3
        Capabilities: [74] Vendor Specific Information: Len=08 <?>
        Kernel driver in use: nvidia
        Kernel modules: nvidia
```



# Run a specific model

```
$ ollama run --verbose phi
>>> who are you?
 I am an artificial intelligence assistant designed to provide information, perform tasks, and assist users in various ways. My capabilities include natural
language processing, machine learning algorithms, and access to vast amounts of data. Is there anything specific you would like me to help you with today?


total duration:       853.501197ms
load duration:        425.949µs
prompt eval count:    35 token(s)
prompt eval duration: 133.976ms
prompt eval rate:     261.24 tokens/s
eval count:           56 token(s)
eval duration:        717.777ms
eval rate:            78.02 tokens/s
```

or 

```
ollama run --verbose mistral
pulling manifest
pulling e8a35b5937a5... 100% ▕██████████████████████████████████████████████████████████████████████████████████████████████████████████▏ 4.1 GB
pulling 43070e2d4e53... 100% ▕██████████████████████████████████████████████████████████████████████████████████████████████████████████▏  11 KB
pulling e6836092461f... 100% ▕██████████████████████████████████████████████████████████████████████████████████████████████████████████▏   42 B
pulling ed11eda7790d... 100% ▕██████████████████████████████████████████████████████████████████████████████████████████████████████████▏   30 B
pulling f9b1e3196ecf... 100% ▕██████████████████████████████████████████████████████████████████████████████████████████████████████████▏  483 B
verifying sha256 digest
writing manifest
removing any unused layers
success
>>> who are you?
 I'm an artificial intelligence language model, designed to help answer questions and generate human-like text. I don't have a physical body or personal identity.
I'm here to provide information and assistance in a conversational manner. How can I help you today?

total duration:       1.603971547s
load duration:        520.133µs
prompt eval count:    14 token(s)
prompt eval duration: 268.637ms
prompt eval rate:     52.11 tokens/s
eval count:           56 token(s)
eval duration:        1.333866s
eval rate:            41.98 tokens/s
```
