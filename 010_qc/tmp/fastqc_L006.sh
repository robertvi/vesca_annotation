#$ -S /bin/sh
#$ -N fastqc
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=3G
#$ -l h_rt=02:00:00
#$ -pe smp 8

#java heap size: threads * 250M = 2G
#/home/master_files/prog_master/prog/FastQC/fastqc -threads 8 ../dunwell_data/L006_R2_fixed.fq
