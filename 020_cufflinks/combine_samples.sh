#$ -S /bin/sh
#$ -N combine
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=2G
#$ -l h_rt=5:00:00

# combine multiple filtered samples into one

set -e
set -u

mkdir -p @{outdir}
cat @{list1} > @{read1}
cat @{list2} > @{read2}
