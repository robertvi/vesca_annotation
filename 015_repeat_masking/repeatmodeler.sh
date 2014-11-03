#$ -S /bin/sh
#$ -N repeatmodeler
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=7.9G
#$ -l h_rt=360:00:00

#60 hrs was too little

set -e
set -u

RMOD='/home/armita/prog/RepeatModeler'
SEQ='/home/vicker/vesca_annotation/refseq/fvesca_v1.1_scaffolds.fa'
DB='fragaria_vesca'
OUTDIR='/home/vicker/vesca_annotation/repeat_modeler'

mkdir -p ${OUTDIR}
cd ${OUTDIR}

${RMOD}/BuildDatabase -name ${DB} ${SEQ}
${RMOD}/RepeatModeler -database ${DB}
