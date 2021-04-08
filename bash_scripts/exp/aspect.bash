#!/bin/bash
#SBATCH --job-name=aspect
#SBATCH --output=outlogs/aspect.o%j.out
#SBATCH --partition=defq
#SBATCH --time=1-00:00:00
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

for num in 1 2 3
do
rundir="aspect"
runname="aspect.${num}"
outdir=${basedir}/output_files/${rundir}/${runname}
singularity run --bind /scratch ${container} ${basedir}/exp01.tcl ${rundir} ${runname}
find ${outdir} ! -name '*.08760.pfb' ! -name 'clm.rst.*' -type f -delete
mv ${outdir}/${runname}.out.press.08760.pfb ${outdir}/press.init.pfb
singularity run --bind /scratch ${container} ${basedir}/exp02.tcl ${rundir} ${runname}
find ${outdir} ! -name '*.08760.pfb' ! -name 'clm.rst.*' -type f -delete
mv ${outdir}/${runname}.out.press.08760.pfb ${outdir}/press.init.pfb
singularity run --bind /scratch ${container} ${basedir}/exp03.tcl ${rundir} ${runname}
done