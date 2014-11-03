#$ -S /usr/bin/python
#$ -N fixdata
#$ -o ../logs/$JOB_NAME.$JOB_ID.out
#$ -e ../logs/$JOB_NAME.$JOB_ID.err
#$ -cwd
#$ -l h_vmem=1G
#$ -l h_rt=10:00:00
#$ -V

'''
sge job template with @{} placeholders

rescue usable read pairs from the Jim Dunwell dataset
output R1 to a separate file for read pairs where R2 is missing

the first corrupted R2 read is
@HWI-ST759:176:C1D9KACXX:6:2312:7768:57503 2:N:0:GTGAAA

R2 data is apparently overwritten by null bytes (0's) for about 5% of the file

L007 and L008 have been checked and don't have the same problem
so the original files can be used
'''

#note template placeholders
f1 = open('@{inp1}')
f2 = open('@{inp2}')

fout1 = open('@{out1}','wb')
fout2 = open('@{out2}','wb')
fout3 = open('@{out3}','wb')

while True:
	#read four line from R1 file
	fq1 = [f1.readline() for i in xrange(4)]
	if fq1[0] == '': break #end of file
	fq1 = [x.strip() for x in fq1]
	
	#assumes R2 is always same number of bases as R1
	#which happens to be true for the present case
	#but will not hold generally
	fq2 = f2.read(f1.tell() - f2.tell())
	
	if '\0' in fq2:
		#treat R2 as corrupted if it contains null bytes, output only R1 to fout3
		fout3.write('\n'.join(fq1) + '\n')
		continue

	#treat R2 as uncorrupted
	fq2 = [x.strip() for x in fq2.strip().split('\n')]
	
	assert fq1[0].split()[0] == fq2[0].split()[0] #verify correct pairing
	
	fout1.write('\n'.join(fq1) + '\n')
	fout2.write('\n'.join(fq2) + '\n')
	
f1.close()
f2.close()

fout1.close()
fout2.close()
fout3.close()
