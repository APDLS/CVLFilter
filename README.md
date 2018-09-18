# CVLFilter

This is a python script that allows the user to filter SPAdes output fasta files by coverage or length.

To run:
-On Windows machines, this script can be run by a double click. Otherwise, run the script using the command "python CVLFilter.py". Follow the prompts.
-This can also be done directly using the following command:
"python CVLFilter.py <scaffolds or contigs fasta to be filtered> <length cutoff> <coverage cutoff>"

# CVLplot

This is an R script that automatically generates coverage-versus-length plots for a scaffolds fasta file and outputs a list of the names of the scaffolds that pass the threshold and are to be kept. In the current version of this script, to select the scaffolds file you want to operate on, the length cutoff, and the coverage cutoff, you need to open the script in a text editor and edit the last line. Put the filename inside the quotation marks after "filename=", the length cutoff after "len_cutoff = ", and the coverage cutoff after "cov_cutoff = ".

To run:

-Open a command line window.
-Type "Rscript /home/alex/Downloads/CVLplotA.R" and hit enter.
