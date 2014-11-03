#$ -S /bin/sh
#$ -N blastn
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=2G
#$ -l h_rt=60:00:00
###$ -pe smp ${threads}

# map other species transcripts to the vesca assembly
# use LOW stringency to minimise false negatives

set -e
set -u

blastn='/home/vicker/programs/ncbi-blast-2.2.29+/bin/blastn'
ops='-evalue 1e-4 -outfmt 6'

mkdir -p @{outdir}

${blastn} -db @{db} -query @{query} -out @{outfile} ${ops}
