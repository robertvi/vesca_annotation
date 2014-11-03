#$ -S /bin/sh
#$ -N trinity
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=@{sgemem}
#$ -l h_rt=30:00:00
#$ -pe smp @{cpu}
#$ -V

# assemble RNA seq data using tophat/cufflinks

set -e
set -u

#export PATH=/home/vicker/programs/bowtie2-2.2.3:${PATH}
export PATH=/home/vicker/programs/samtools-1.1:${PATH}
export PATH=/home/vicker/programs/bowtie-1.1.1:${PATH}
export PATH=/home/vicker/programs/trinityrnaseq_r20140717:${PATH}
trinity='/home/vicker/programs/trinityrnaseq_r20140717/Trinity'

${trinity} --seqType fq --JM @{javamem} --CPU @{cpu} \
	--left @{read1} --right @{read2} --output @{outdir}
