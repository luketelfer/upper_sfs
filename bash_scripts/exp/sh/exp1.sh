#!/bin/bash

bashdir='/scratch/ltelfer/upper_sfs/bash_scripts/exp/bash/1/'
ls $bashdir

for n in {01..50}
do
sbatch ${bashdir}/R1.bash R.${n}
sbatch ${bashdir}/NN1.bash NN.${n}
sbatch ${bashdir}/MPD1.bash MPD.${n}
done