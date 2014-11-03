#!/bin/sh

#$ -S /bin/sh
#$ -N repeatmasker
#$ -o ../logs/$JOB_NAME.out.$JOB_ID
#$ -e ../logs/$JOB_NAME.err.$JOB_ID
#$ -cwd
#$ -l h_vmem=96G
####$ -pe openmpi 2
#$ -q amd.q
###$ -t 1-22

RM='/ibers/ernie/home/rov/programs/RepeatMasker/RepeatMasker'
#LIB='/ibers/ernie/home/rov/scratch/abyss_atlantica_assembly_2013-08-08/repeat_databases/mips-redat/mipsREdat_9.3p_Poaceae_TEs.fa'
LIB='/ibers/ernie/home/rov/scratch/abyss_atlantica_assembly_2013-08-08/040_repeat_mask/RM_30519.WedSep41003262013/consensi.fa.classified'
CORES='10'
#SEQ='/ibers/ernie/scratch/rov/zipper_003/ref/atlan20130829_010_min200.fa'
SEQ='/ibers/ernie/scratch/rov/zipper_003/ref/atlantica_80k_lib.fa'

${RM} -pa ${CORES} -lib ${LIB} ${SEQ}
##${RM}  -pa ${CORES} -species pooideae ${SEQ}
