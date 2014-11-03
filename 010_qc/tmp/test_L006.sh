#$ -S /bin/sh
#$ -N myjob
#$ -cwd
#$ -V
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -l h_vmem=1.0G
#$ -l h_rt=2:00:00
#$ -pe smp 8

#java heap size: threads * 250M = 2G
echo threads 8 ../dunwell_data/L006_R1_fixed.fq
