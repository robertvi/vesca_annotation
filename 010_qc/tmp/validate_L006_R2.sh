#$ -S /bin/sh
#$ -N validate
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=1G
#$ -l h_rt=5:00:00

# validate fastqs

set -e
set -u

fqval='/home/vicker/programs/fastQValidator_0.1.1a/fastQValidator/bin/fastQValidator'

${fqval} --file ../dunwell_data/L006_paired_R2.fq --baseSpace
