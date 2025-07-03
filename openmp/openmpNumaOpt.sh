#!/bin/bash
# OpenMP Optimization Flag Performance Test
# Compares performance with and without -x optimization flag
# Uses NUMA control for thread counts ≤24 (single socket)
# Tests two scenarios:
#   1. Standard OpenMP parallelization (no -x flag)
#   2. Optimized OpenMP parallelization (with -x flag)
#PBS -q express
#PBS -j oe
#PBS -l walltime=00:01:00,mem=32GB
#PBS -l wd
#PBS -l ncpus=48
#

e= #echo

r=100
M=1000 # may need to be bigger
N=$M

numactl1="numactl --cpunodebind=0 --membind=0"


ps="1 3 6 8 12 24 48"

for p in $ps; do
    opts=""
    echo ""
    if [ $p -le 24 ] ; then
	numactl="numactl --cpunodebind=0 --membind=0"
    else
	numactl=
    fi
    echo OMP_NUM_THREADS=$p $numactl ./testAdvect $opts $M $N $r
    OMP_NUM_THREADS=$p $e $numactl ./testAdvect $opts $M $N $r
    echo ""
done

for p in $ps; do
    opts="-x"
    echo ""
    if [ $p -le 24 ] ; then
	numactl="numactl --cpunodebind=0 --membind=0"
    else
	numactl=
    fi
    echo OMP_NUM_THREADS=$p $numactl ./testAdvect $opts $M $N $r
    OMP_NUM_THREADS=$p $e $numactl ./testAdvect $opts $M $N $r
    echo ""
done
exit

# OMP_NUM_THREADS=9 ./testAdvect -P 3 -x 1000 1000 100
