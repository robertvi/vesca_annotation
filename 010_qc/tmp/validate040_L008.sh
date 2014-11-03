#$ -S /bin/sh
#$ -N validate
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=1G
#$ -l h_rt=5:00:00
#$ -V

# validate two paired fastq files

set -e
set -u

echo $PATH

valid_2fastq.py ../dunwell_data/L008_R1_trimmed.fq ../dunwell_data/L008_R2_trimmed.fq
