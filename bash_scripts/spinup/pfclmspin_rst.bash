#!/bin/bash
#SBATCH --job-name=pfclmspin_rst
#SBATCH --output=outlogs/pfclmspin_rst.o%j.out
#SBATCH --partition=leaf
#SBATCH --time=0-04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mail-user=luketelfer@u.boisestate.edu
#SBATCH --mail-type=FAIL,END

ulimit -v unlimited
ulimit -u 1000
ulimit -s unlimited

rundir=$1
runname=$2
rstname=$3
rsttime=$4
basedir="/scratch/ltelfer/upper_sfs"
CONTAINER="/scratch/ltelfer/upper_sfs/parflow_latest.sif"
outdir="${basedir}/output_files/${rundir}/${runname}"

module load "openmpi/gcc/64/1.10.7"
module load "singularity/3.5.2"

cd $basedir

singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl $rundir $runname $rstname $rsttime