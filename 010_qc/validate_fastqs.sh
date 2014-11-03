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

valid_2fastq.py @{read1} @{read2}
