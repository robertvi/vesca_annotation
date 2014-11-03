#$ -S /usr/bin/python
#$ -N exonerate
#$ -o ../scr/logs4/$JOB_NAME.$JOB_ID.$TASK_ID.out
#$ -e ../scr/logs4/$JOB_NAME.$JOB_ID.$TASK_ID.err
#$ -cwd
#$ -l h_vmem=1G
###$ -q amd.q
#$ -l h=node005|node006|node007|node001
#$ -t 1-1000
####$ -hold_jid_ad 130622

'''
taking the results of the tblastn search
extract just those scaffolds with hits
then repeat the search using exonerate

task 1
used < 300M
8 mins
'''

import sys
sys.path.append('/ibers/ernie/home/rov/python_lib') 
from rjv.fileio import *
from rjv.cheetah import *
from rjv.fasta import *

taskid=task_offset()

ref='../../zipper_003/scr/ref2/atlan20131014_020_nocontam.fa'
query='../scr/phytozome_9.0_2013-12-03/split/phytozome_transcripts-%04d.fa'%taskid
hits='../scr/transcripts_blast_hits/phytozome-%04d.tsv'%taskid
subj='../scr/tmp/scaffs-transcripts-%04d.fa'%taskid
output='../scr/transcripts_exonerate_hits/transcripts-%04d.out'%taskid

exon='/ibers/ernie/home/rov/programs/exonerate-2.2.0-x86_64/bin/exonerate'
ops='--score 500 --showvulgar no --showalignment no --showtargetgff yes --showcigar yes'
ops += r' --ryo "ryo:\t%S\t%pi\t%ps\t%ql\t%tl\t%g\t%V\nAveragePercentIdentity: %pi\n"'

#print "%s %s %s %s"%(ops,query,subj,output)
#exit()

#find which scaffolds are present in the blast hits file
scafids = {}
f = open(hits)
for line in f:
    tok = line.split('\t')
    scafids[tok[1]] = True
f.close()

#output only those into the 'subj' file
fout = open(subj,'wb')
for scafid in scafids.iterkeys():
    fa = get_fasta(ref,scafid)
    write_fasta(fa,fout)
fout.close()

cheetah('@{exon} --model est2genome @{ops} @{query} @{subj} > @{output}')
