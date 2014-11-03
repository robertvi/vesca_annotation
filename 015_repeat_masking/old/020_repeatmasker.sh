#!/bin/sh

#$ -S /bin/sh
#$ -N repeatmasker
#$ -o ../scr/logs/$JOB_NAME.$JOB_ID.$TASK_ID.out
#$ -e ../scr/logs/$JOB_NAME.$JOB_ID.$TASK_ID.err
#$ -cwd
#$ -l h_vmem=4.5G
#$ -q intel.q|large.q
###$ -l h=node009|node010|node011|node
#$ -t 1-200

# using the library of repeats created by repeatmodeler
# and MIPS poaceae repeats
# repeat mask the assembly
# parallelise by splitting into 200 chunks 
# I used my splitfasta2.py to split the assembly first
# then to recombined the 200 chunks I did:
# cat atlan20130829_010_min200-???.fa.masked > atlan20130829_020_repeatmasker.fa
# the repeat masked file is larger due to repeat masker putting
# fewer bases per line
# scaffolds are also in a different order due to the splitting process
# i previously tried to do the masking as a single job, but it kept failing
# i did not find out the reason, but splitting into 200 chunks allowed
# it to complete

# -gff option produces gff2 output only
# can use rmOut2GFF3.pl to convert .out to .gff3
# see next script 030

#starting , stopping, then restarting this script seemed to cause errors
#make sure previous temp output directories are removed before running


RM='/ibers/ernie/home/rov/programs/RepeatMasker/RepeatMasker'
#LIB='/ibers/ernie/home/rov/scratch/abyss_atlantica_assembly_2013-08-08/repeat_databases/mips-redat/mipsREdat_9.3p_Poaceae_TEs.fa'
#LIB='/ibers/ernie/home/rov/scratch/abyss_atlantica_assembly_2013-08-08/040_repeat_mask/RM_30519.WedSep41003262013/consensi.fa.classified'
#LIB='/ibers/ernie/home/rov/scratch/abyss_atlantica_assembly_2013-08-08/040_repeat_mask/repeat_library/combined.fa'
LIB='/ibers/ernie/scratch/rov/abyss_atlantica_assembly_2013-08-08/repeat_mask/repeat_library/combined.fa'
CORES='1'
#BASE='/ibers/ernie/scratch/rov/zipper_003/ref/atlan20130829_010_min200-%03d.fa'
#BASE='/ibers/ernie/scratch/rov/zipper_003/ref2/020_nocontam/atlan20131014_020_nocontam-%03d.fa'
BASE='/ibers/ernie/scratch/rov/zipper_003/ref2/020_nocontam/atlan20131014_020_nocontam-%03d.fa'
RMTMPDIR='../scr/repeat_masker_tmp'

set -e 
set -u

cd ${RMTMPDIR}

SEQ=`printf $BASE $((SGE_TASK_ID-1))`

##hard masked
##${RM} -gff -pa ${CORES} -lib ${LIB} ${SEQ}

###soft masked
##${RM} -gff -xsmall -pa ${CORES} -lib ${LIB} ${SEQ}

##nolow
${RM} -gff -nolow -pa ${CORES} -lib ${LIB} ${SEQ}
