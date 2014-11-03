#$ -S /bin/sh
#$ -N get_unmapped
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=4G
#$ -l h_rt=10:00:00

# get the unmapped read pairs out of unmapped.bam from tophat

set -e
set -u

export PATH=/home/vicker/programs/bedtools2/bin:${PATH}
export PATH=/home/vicker/programs/samtools-1.1:${PATH}

samtools='/home/vicker/programs/samtools-1.1/samtools'
bedtools='/home/vicker/programs/bedtools2/bin/bedtools'

#sort fastq by query (readname), required by bedtools
#with 3.5G of RAM
#should automatically merge the subfiles as required
${samtools} sort -n -m 3500000000 @{bam} @{sortedbam}

#get only pairs where both are unmapped
#ie require unmapped and mate unmapped
#FAILED: mate unmapped flag is not set correctly
#would have been: ${samtools} view -b -f '0xC' @{sortedbam}.bam > @{filteredbam}

#convert bam into pair of fastqs
#seems to skip unpaired reads with a warning message
${bedtools} bamtofastq -i @{sortedbam}.bam -fq @{read1} -fq2 @{read2}

#check read pairing is intact
valid_2fastq.py @{read1} @{read2} '/'
