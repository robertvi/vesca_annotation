#$ -S /bin/sh
#$ -N blastn
#$ -o ../scr/logs4/$JOB_NAME.$JOB_ID.$TASK_ID.out
#$ -e ../scr/logs4/$JOB_NAME.$JOB_ID.$TASK_ID.err
#$ -cwd
#$ -l h_vmem=1.5G
###$ -q amd.q
#$ -l h=node005|node006|node007|node001
#$ -t 1-1000

#
# map model grass genome transcripts to our diploid assembly
# < 1G per job
# use LOW stringency to minimise false negatives
#

taskid=`printf "%04d" $((SGE_TASK_ID-1))`

query="../scr/phytozome_9.0_2013-12-03/split/phytozome_transcripts-${taskid}.fa"
db='../../zipper_003/scr/ref2/atlan20131014_020_nocontam.fa'
output="../scr/transcripts_blast_hits/phytozome-${taskid}.tsv"

blastn='/cm/shared/apps/BLAST/ncbi-blast-2.2.28+/bin/blastn'
outfmt='6'
ops='-evalue 1e-4'

${blastn} -db ${db} -query ${query} -out ${output} ${ops} -outfmt ${outfmt}
