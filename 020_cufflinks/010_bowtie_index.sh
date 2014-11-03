#$ -S /bin/sh
#$ -N bowtie
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=2G

# build bowtie2 index for both reference sequences

set -e
set -u

export PATH=${PATH}:/home/vicker/programs/bowtie2-2.2.3

ref='/home/vicker/vesca_annotation/downy_mildew/GCA_000151065.3_ASM15106v3_genomic.fa'
bowtie2-build ${ref} ${ref}

ref='/home/vicker/vesca_annotation/refseq/fvesca_v1.1_scaffolds.fa'
bowtie2-build ${ref} ${ref}
