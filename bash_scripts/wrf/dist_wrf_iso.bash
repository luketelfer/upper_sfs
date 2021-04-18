#!/bin/bash
#SBATCH --job-name=dist_wrf
#SBATCH --output=outlogs/dist_wrf.o%j.out
#SBATCH --partition=leaf
#SBATCH --time=2-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
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

singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_atmpress
singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_forcings
singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_longwave
singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_precip
singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_shortwave
singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_sphumid
singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_temp
singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_uniform
singularity run --bind /scratch ${CONTAINER} ${basedir}/dist_wrf.tcl wrf_wind
