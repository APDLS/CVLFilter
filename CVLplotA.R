# -------------------------------------------------------------------------------
# R function to perform analyses as reported in the manuscript: 
# "Coverage-versus-Length plots, a simple quality control step for de novo yeast genome sequence assemblies"
# Copyright Raúl A. Ortiz-Merino 2018
# rul.ohm<at>gmail.com
# -------------------------------------------------------------------------------

# Function definition
fasta2df <- function(filename, cov_cutoff, len_cutoff){
 # Read fasta file
 fasta_file <- readLines(filename)
 # Define data frame
 tmp.df <- data.frame(ID="",NODE="",len="",cov="",
                      #sequence="",
                      row.names=NULL,stringsAsFactors=F)
 # Fill in data frame
 j = 1
 for(i in 1:length(fasta_file)){
  if (grepl(">",fasta_file[i]) == T){
   tmp.df[j,"ID"]<-fasta_file[i]
   ID_fields <- strsplit(tmp.df[j,"ID"], "_")
   tmp.df[j,"NODE"] <-ID_fields[[1]][2]
   tmp.df[j,"len"]<-ID_fields[[1]][4]
   tmp.df[j,"cov"]<-ID_fields[[1]][6]
   #tmp.df[j,"sequence"]<-fasta_file[i]
   j=j+1
  }
 # else{tmp.df[j,"sequence"]<-paste(tmp.df[j,"sequence"],fasta_file[i],sep="")}
 }
 # Set column vector types
 seq.df <- data.frame(ID=tmp.df$ID,
                      NODE=tmp.df$NODE,
                      len=as.numeric(tmp.df$len),
                      # transform len to kb
                      kblen=as.numeric(tmp.df$len)/1000,
                      cov=as.numeric(tmp.df$cov),
                      # transform cov
                      logcov=log10(as.numeric(tmp.df$cov)),
                      #sequence=tmp.df$sequence,
                      row.names=NULL,stringsAsFactors=F)
 # Remove ">"
 seq.df$ID<-gsub(">", "", seq.df$ID, perl=TRUE)
 rm(tmp.df)
 
 # Plot the values
 filename_fields <- strsplit(filename, "_")
 plot_title <- paste(filename_fields[[1]][1],".jpeg",sep="")
 
 png(file=plot_title, width=400, height=200, units="mm", quality=80, res=600);
 plot(seq.df$kblen,seq.df$logcov,pch=".",xlab="Length (kb)",
      ylab=expression('log'[10]*' coverage (X)'),
      yaxt="n",
      main = paste(filename_fields[[1]][1],
                   "coverage cutoff =",cov_cutoff,";",
                   "length cutoff =",len_cutoff,
                   sep=" ")
     )
 axis(side=2, las=1)
 # Print length cutoff line
 abline(v=len_cutoff,col="green")
 # Print cov cutoff line
 abline(h=log10(cov_cutoff),col="green")
 dev.off()
 
 tmp.df <- subset(seq.df, seq.df$len>len_cutoff & seq.df$cov>cov_cutoff, select=ID)
 out_filename = paste(filename_fields[[1]][1],"_passIDs.txt",sep="")
 write.table(tmp.df,file=out_filename,col.names=F,row.names=F,quote=F,sep="\t")

 rm(tmp.df)
 return(seq.df)
}

# Execute function;  replace values as needed
outseq.df <- fasta2df(filename="scaffolds.fasta", len_cutoff = 0.5, cov_cutoff = 20)


