# CVLFilter

This is a python script that allows the user to filter SPAdes output fasta files by coverage or length.

To run:
-On Windows machines, this script can be run by a double click. Otherwise, run the script using the command "python CVLFilter.py". Follow the prompts.
-This can also be done directly using the following command:
"python CVLFilter.py <scaffolds or contigs fasta to be filtered> <length cutoff> <coverage cutoff>"

# CVLplot

This is an R script that automatically generates coverage-versus-length plots for a scaffolds fasta file and outputs a list of the names of the scaffolds that pass the threshold and are to be kept. The current version of the script has been updated to take input.

To run:

-Open a command line window.
-Type "Rscript CVLplotA.R <Path to scaffolds FASTA file> <Length cutoff (in kb)> <Coverage cutoff>" and hit enter.
