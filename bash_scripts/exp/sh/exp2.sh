#!/bin/bash

bashdir='/scratch/ltelfer/upper_sfs/bash_scripts/exp/bash/2/'
ls $bashdir

for n in {01..50}
do
sbatch ${bashdir}/R2.bash R.${n}
sbatch ${bashdir}/NN2.bash NN.${n}
sbatch ${bashdir}/MPD2.bash MPD.${n}
done