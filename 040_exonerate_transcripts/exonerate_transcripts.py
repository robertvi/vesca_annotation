#$ -S /usr/bin/python
#$ -N @{jobname}
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=0.5G
#$ -l h_rt=100:00:00

import os

exon='/home/vicker/programs/exonerate-2.2.0-x86_64/bin/exonerate'
ops='--score 500 --showvulgar no --showalignment no --showtargetgff yes --showcigar yes --ryo "ryo:\t%S\t%pi\t%ps\t%ql\t%tl\t%g\t%V\nAveragePercentIdentity: %pi\n"'

os.system('mkdir -p @{outdir}')

os.system(exon+' --model est2genome '+ops+' @{query} @{subject} > @{outfile}')
