#!/bin/bash

bashdir='/scratch/ltelfer/upper_sfs/bash_scripts/exp/bash/3/'
ls $bashdir

sbatch ${bashdir}/ctr3.bash 'ctrU'
sbatch ${bashdir}/ctr3.bash 'ctrH'