#$ -S /bin/sh
#$ -N @{jobname}
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=3G
#$ -l h_rt=10:00:00
#$ -V

set -e
set -u

mkdir -p @{outdir}
cd @{outdir}
splitfasta2.py @{query} @{split}
