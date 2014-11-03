#$ -S /bin/sh
#$ -N trim-PE
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=@{mem}
#$ -l h_rt=@{rt}
#$ -pe smp @{threads}
#$ -V

java @{javamem} -jar /home/vicker/programs/Trimmomatic-0.32/trimmomatic-0.32.jar\
    PE -threads @{threads} -phred33 -trimlog @{trimlog}\
    @{inp1} @{inp2}\
    @{out1p} @{out1u} @{out2p} @{out2u}\
    ILLUMINACLIP:@{fadapt}:@{mismatch}:@{pclip}:@{sclip}\
    MINLEN:@{minlen}

#    LEADING:3\
#    TRAILING:3\
#    SLIDINGWINDOW:4:20\
