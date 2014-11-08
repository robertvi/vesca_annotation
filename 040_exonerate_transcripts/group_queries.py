#$ -S /usr/bin/python
#$ -N @{jobname}
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=2G
#$ -l h_rt=10:00:00
#$ -V

'''
group blast hits by subject id
output a series of subject / query file pairs
ie the queries are grouped with the subject sequence(s)
they have hits to
with a maximum of 'maxhits' queries per job
'''

from rjv.blast6 import *
from rjv.fasta import *
import os

query = '@{query}'
subject = '@{subject}'
hitfile = '@{hitfile}'

#max hits per job
maxhits = 50

subj = {}

#store list of query hits for each subject sequence
for hit in next_hit(hitfile):
    if not hit['subject'] in subj: subj[hit['subject']] = {}
    subj[hit['subject']][hit['query']] = True
    
ct = 0
os.system('rm @{outdir}@{sample}.*.query')
os.system('rm @{outdir}@{sample}.*.subject')
outquery = '@{outdir}@{sample}.%06d.query'
outsubject = '@{outdir}@{sample}.%06d.subject'
outsubjectid = '@{outdir}@{sample}.%06d.subjectid'

for j,sid in enumerate(subj.iterkeys()):
    #write subject sequence to file
    subfile = outsubject%j
    f = open(subfile,'wb')
    fa = get_fasta(subject,sid)
    write_fasta(fa,f)
    f.close()
    
    for i,qid in enumerate(subj[sid].iterkeys()):
        offset = i % maxhits

        #write subjectid to file if not already done so
        subidfile = outsubjectid%(ct+offset)
        if not os.path.isfile(subidfile):
            f = open(subidfile,'wb')
            f.write('%d\n'%j)
            f.close()
        
        #append query
        queryfile = outquery%(ct+offset)
        f = open(queryfile,'a')
        fa = get_fasta(query,qid)
        write_fasta(fa,f)
        f.close()
        
    ct += offset + 1
