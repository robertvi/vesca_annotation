#$ -S /bin/sh
#$ -N tophat_cufflinks
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=5G
#$ -l h_rt=30:00:00

# assemble RNA seq data using tophat/cufflinks

set -e
set -u

export PATH=${PATH}:/home/vicker/programs/bowtie2-2.2.3
export PATH=${PATH}:/home/vicker/programs/samtools-1.1

tophat='/home/vicker/programs/tophat-2.0.13.Linux_x86_64/tophat'
cufflinks='/home/vicker/programs/cufflinks-2.2.1.Linux_x86_64/cufflinks'

#mildew
#full path might be needed here
ref='/home/vicker/vesca_annotation/downy_mildew/GCA_000151065.3_ASM15106v3_genomic.fa'
outdir='/home/vicker/vesca_annotation/cufflinks_mildew_L007'
${tophat} --no-coverage-search -o ${outdir} ${ref} ../dunwell_data/L007_R1_trimmed.fq ../dunwell_data/L007_R2_trimmed.fq

#strawberry
#ref='../refseq/fvesca_v1.1_scaffolds.fa'
#outdir='../cufflinks_vesca_L007'
# ${tophat} -o ${outdir} ${ref} ../dunwell_data/L007_R1_trimmed.fq ../dunwell_data/L007_R2_trimmed.fq
# ${cufflinks} -o ${outdir} ${outdir}/accepted_hits.bam

