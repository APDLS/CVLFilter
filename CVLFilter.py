import sys
from sys import argv

if len(argv)==4:
	File=argv[1]
	with open(File) as infile:
		data=infile.readlines()
	length=argv[2]
	coverage=argv[3]

else:
	File=raw_input("Enter the name of the scaffolds/contig input file: ")
	with open(File) as infile:
		data=infile.readlines()
	length=input("Enter the minimum contig length to retain: ")
	print "retaining contigs of length "+str(length)+" and up"
	coverage=input("Enter the minimum contig coverage to retain: ")
	print "retaining contigs of coverage "+str(coverage)+" and up"

outfile=open(File.replace(".fasta","_filtered.fasta"),"w")
x=0
print "Working..."
while x < len(data):

	if ">" in data[x]:
		stats=data[x].split("_")
		if int(stats[3]) >= int(length) and float(stats[5]) >= float(coverage):
			outfile.write(data[x])
			while ">" not in data[x+1]:
				x=x+1
				outfile.write(data[x])
	x=x+1

print "Done"
print "Filtered scaffolds output to the file: "+str(outfile)
outfile.close()
