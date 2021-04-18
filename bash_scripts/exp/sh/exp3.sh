#!/bin/bash

bashdir='/scratch/ltelfer/upper_sfs/bash_scripts/exp/bash/3/'
ls $bashdir

for n in {01..50}
do
sbatch ${bashdir}/R3.bash R.${n}
sbatch ${bashdir}/NN3.bash NN.${n}
sbatch ${bashdir}/MPD3.bash MPD.${n}
done