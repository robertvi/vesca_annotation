#!/usr/bin/python

'''
add ID and Name fields to repeat masker gff3
'''


inp='../../zipper_003/scr/ref2/020_nocontam/atlan20131014_030_masked.gff3'
out='../../zipper_003/scr/ref2/020_nocontam/atlan20131014_030_masked_fixed.gff3'

f = open(inp)
fout = open(out,'wb')

ct = 0
for line in f:
    if line.startswith('#'):
        fout.write(line)
        continue
      
    ct += 1
    line = line.strip()
    tok = line.split('\t')[8]
    name = tok.split('=')[1]
    line += ';ID=rep%d;Name=%s\n'%(ct,name)
    fout.write(line)

fout.close()
f.close()
