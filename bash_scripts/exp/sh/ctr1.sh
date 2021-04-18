#!/bin/bash

bashdir='/scratch/ltelfer/upper_sfs/bash_scripts/exp/bash/1/'
ls $bashdir

sbatch ${bashdir}/ctr1.bash 'ctrU'
sbatch ${bashdir}/ctr1.bash 'ctrH'