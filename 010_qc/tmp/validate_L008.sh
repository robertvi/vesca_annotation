#$ -S /bin/sh
#$ -N validate
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=1G
#$ -l h_rt=10:00:00
#$ -V

# validate fastqs

set -e
set -u

valid_fastq.py ../dunwell_data/L008_R1_fixed.fq ../dunwell_data/L008_R2_fixed.fq
valid_2fastq.py ../dunwell_data/L008_R1_fixed.fq ../dunwell_data/L008_R2_fixed.fq
