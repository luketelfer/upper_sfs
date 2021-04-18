#!/bin/bash
#SBATCH --job-name=MPD3
#SBATCH --output=outlogs/MPD3.o%j.out
#SBATCH --partition=shortq
#SBATCH --time=0-04:00:00
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

basedir=/scratch/ltelfer/upper_sfs
container=/scratch/ltelfer/upper_sfs/parflow_latest.sif

cd $basedir

rundir='MPD'
runname=$1
outdir=${basedir}/output_files/${rundir}/${runname}

find ${outdir} ! -name '*.08760.pfb' ! -name 'clm.rst.*' -type f -delete
mv ${outdir}/${runname}.out.press.08760.pfb ${outdir}/press.init.pfb
singularity run --bind /scratch ${container} ${basedir}/uniform3.tcl ${rundir} ${runname}