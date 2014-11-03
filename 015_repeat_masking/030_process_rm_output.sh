#!/bin/sh

#convert repeatmasker 'out' files into gff3 files
#concatenate the files together

RMOUT='/ibers/ernie/home/rov/programs/RepeatMasker/rmOutToGFF3.pl'
INP='../../zipper_003/scr/ref2/020_nocontam/atlan20131014_020_nocontam-???.fa.out'
OUT='../../zipper_003/scr/ref2/020_nocontam/atlan20131014_030_nolow_masked.gff3'


echo '##gff-version 3' > ${OUT}
for i in ${INP}
do
    ${RMOUT} ${i} | grep -v '^#' >> ${OUT}
done

 
#may also want to merge the masked scaffolds back into a single file
#head -n 1 atlan20131014_020_nocontam-199.fa.masked > atlan20131014_030_masked.fa
#cat *.masked | grep -v '^#' >> atlan20131014_030_masked.fa
