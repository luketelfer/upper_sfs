#!/bin/bash

vname=$1

for num in 1 2 3 4 5
do
python uni_postproc.py -n ${vname}.${num}
done