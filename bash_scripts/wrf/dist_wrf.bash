#!/bin/bash
#SBATCH --partition=leaf
#SBATCH --time=0-12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mail-user=luketelfer@u.boisestate.edu
#SBATCH --mail-type=FAIL,END

ulimit -v unlimited
ulimit -u 1000
ulimit -s unlimited

module load "openmpi/gcc/64/1.10.7"
module load "singularity/3.5.2"

cd $basedir

basedir=/scratch/ltelfer/upper_sfs
CONTAINER=/scratch/ltelfer/upper_sfs/parflow_latest.sif

singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl
