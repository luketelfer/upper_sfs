#!/bin/bash
#SBATCH --job-name=pfclmspin_rst
#SBATCH --output=outlogs/pfclmspin_rst.o%j.out
#SBATCH --partition=leaf
#SBATCH --time=3-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mail-user=luketelfer@u.boisestate.edu
#SBATCH --mail-type=FAIL,END

ulimit -v unlimited
ulimit -u 1000
ulimit -s unlimited

basedir="/scratch/ltelfer/upper_sfs"
CONTAINER="/scratch/ltelfer/upper_sfs/parflow_latest.sif"
outdir="${basedir}/output_files/${rundir}/${runname}"

module load "openmpi/gcc/64/1.10.7"
module load "singularity/3.5.2"

cd $basedir

singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc02 pfc01 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc03 pfc02 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc04 pfc03 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc05 pfc04 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc06 pfc05 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc07 pfc06 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc08 pfc07 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc09 pfc08 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc10 pfc09 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc11 pfc10 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc12 pfc11 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc13 pfc12 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc14 pfc13 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc15 pfc14 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc16 pfc15 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc17 pfc16 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc18 pfc17 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc19 pfc18 08760
singularity run --bind /scratch ${CONTAINER} ${basedir}/pfclmspin_rst.tcl spinup pfc20 pfc19 08760