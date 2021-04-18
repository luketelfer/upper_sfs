#!/bin/bash

bashdir='/scratch/ltelfer/upper_sfs/bash_scripts/exp/bash/2/'
ls $bashdir

sbatch ${bashdir}/ctr2.bash 'ctrU'
sbatch ${bashdir}/ctr2.bash 'ctrH'