#$ -S /bin/sh
#$ -N cufflinks
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=@{mem}
#$ -l h_rt=@{rt}

# assemble RNA seq data using tophat/cufflinks

set -e
set -u

export PATH=${PATH}:/home/vicker/programs/bowtie2-2.2.3
export PATH=${PATH}:/home/vicker/programs/samtools-1.1

tophat='/home/vicker/programs/tophat-2.0.13.Linux_x86_64/tophat'
cufflinks='/home/vicker/programs/cufflinks-2.2.1.Linux_x86_64/cufflinks'

#assemble reads against vesca genome
ref='/home/vicker/vesca_annotation/refseq/fvesca_v1.1_scaffolds.fa'
${tophat} --no-coverage-search -o @{outdir} ${ref} @{read1} @{read2}
${cufflinks} -o @{outdir} @{outdir}/accepted_hits.bam
