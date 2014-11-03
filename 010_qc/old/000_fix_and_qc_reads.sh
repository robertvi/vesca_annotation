#!/bin/sh

#@HWI-ST759:176:C1D9KACXX:6:2312:7768:57503 2:N:0:GTGAAA
#id of first corrupted read

#stop script if an error happens or if an unassigned variable is encountered
set -e
set -u

####rescue usable read pairs from the corrupted input files
#./fix_data.py

####create list of input files
#ls -1 ../dunwell_data/L006_R?_fixed.fq ../dunwell_data/L006_R?_unpaired.fq > rawfastq
#ls -1 ../dunwell_data/L008_R?_fixed.fq > rawfastq

####run fastqc
#qlauncher.py fastqc.sh rawfastq

####create trimmomatic file names
#head -n 1 rawfastq | sed 's/_R[12]_fixed\.fq//g' > rawfastqbase
#echo '../dunwell_data/L007' > rawfastqbase
echo '../dunwell_data/L008' > rawfastqbase

####run trimmomatic
qlauncher.py trimmomatic-PE1.sh rawfastqbase

####run fastqc again
#ls -1 ../dunwell_data/L006_paired_R?.fq > trimfastq
#ls -1 ../dunwell_data/L007_paired_R?.fq > trimfastq

####run fastqc
#qlauncher.py fastqc_trim.sh trimfastq

