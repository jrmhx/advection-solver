# Advection Solver with OpenMP and CUDA

This repository provides an implementation of an Advection Solver optimized for shared memory parallel programming models using OpenMP and CUDA. The goal is to facilitate understanding and experimenting with parallelization strategies on SMP (Symmetric Multiprocessing) and GPU architectures.

## Objectives

The project includes two primary directories:
- `openmp`: Contains an OpenMP implementation for CPU-based shared memory parallelization.
- `cuda`: Includes a CUDA-based implementation optimized for GPU acceleration.

Both directories contain:
- Test harness (testAdvect) to measure performance.
- Serial reference implementations for comparison.
- Template files to implement parallel algorithms.

## Setup

### Requirements

- GCC compiler with OpenMP support.
- CUDA Toolkit for GPU implementation.

### Compilation

Navigate to either `openmp` or `cuda` directory and run:
```bash
make
```

### Usage

#### OpenMP

```bash
OMP_NUM_THREADS=p ./testAdvect [-P P] [-x] M N [r]
```

- `-P P`: Optimize parallel execution over multiple timesteps using a P×Q block distribution (where p = PQ).
- `-x`: Enable additional optimizations.
- `M, N, r`: Simulation dimensions and optional repeat count.

#### CUDA

```bash
./testAdvect [-h] [-s] [-g Gx[,Gy]] [-b Bx[,By]] [-o] [-w w] [-d d] M N [r]
```

- `-h`: Run solver on CPU host.
- `-s`: Force serial execution on GPU.
- `-g Gx,Gy`: Set grid dimensions for GPU kernels.
- `-b Bx,By`: Set block dimensions for GPU kernels.
- `-o`: Activate optimized GPU implementation.
- `-d`: Select GPU device ID (useful for multi-GPU setups).

with default values of `Gx=Gy=Bx=By=r=1` and `v=w=d=0`. `Gx,Gy` specifies the grid dimensions of the GPU kernels; `Bx,By` specifies the block dimensions.

The option `-h` runs the solver on the host; this may be useful for debuggung and comparing the 'error' of the GPU runs. The option `-s` forces a serial implementation (run on a single GPU thread) and all other options are ignored. If neither of `-h,-s,-o` are given, `Gx,Gy` thread blocks of size `Bx,By` are used in a 2D GPU parallelization of the solver. 

The option `-d` can be used to specify the id of the GPU to be used. (For example you has 4 GPUs with id {0, 1, 2, 3}, so you can use `d` equal to either `0`, `1`, `2`, or `3`). This may be useful if a you are running on a cloud GPU server and particular GPU (e.g. GPU 0) is currently loaded.

## Key Features

### OpenMP Implementation

- Supports 1D and 2D domain decomposition.
- Parallel region optimizations.
- Performance modeling for shared memory.
- Optional extended parallel region for efficiency.

### CUDA Implementation

- Flexible grid and block size tuning.
- Baseline and optimized kernel implementations.
- Performance exploration with different GPU configurations.

## Performance Optimization

Performance tuning includes:

- Cache efficiency via loop ordering.
- Minimizing synchronization overhead.
- Reducing cache misses (coherent reads/writes).
- Kernel launch overhead management.



