#$ -S /bin/sh
#$ -N trim-PE
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=2G
#$ -l h_rt=02:00:00
#$ -pe smp 8

fbase='@{fastqbase}'
fext='fq'

fadapt='/home/vicker/programs/Trimmomatic-0.32/adapters/TruSeq3-PE-2.fa'
mismatch=2
pclip=30
sclip=10

java -Xmx1g -jar /home/vicker/programs/Trimmomatic-0.32/trimmomatic-0.32.jar\
    PE -threads 8 -phred33\
    -trimlog ../logs/trimmomatic-PE.log\
    ${fbase}_R1_fixed.${fext}\
    ${fbase}_R2_fixed.${fext}\
    ${fbase}_paired_R1.${fext}\
    ${fbase}_unpaired_R1.${fext}\
    ${fbase}_paired_R2.${fext}\
    ${fbase}_unpaired_R2.${fext}\
    ILLUMINACLIP:${fadapt}:${mismatch}:${pclip}:${sclip}\
    MINLEN:21

#    LEADING:3\
#    TRAILING:3\
#    SLIDINGWINDOW:4:20\
