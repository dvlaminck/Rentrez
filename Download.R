ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") #Creating a character string to apply headings to the Bburg sequences we are going to pull
library(rentrez)  #Loading package
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") #Downloading data from NCBI database 'nuccore' in FASTA format with ncbi_ids as headings

#Looking at the object, contains 3 sequences of 16S gene of Borrelia burgdorferi 
head(Bburg)

Sequences <- strsplit(Bburg, split = "\n\n") #Splitting into 3 sequences rather than long list
print(Sequences)
Sequences<-unlist(Sequences) #Making it into a dataframe

#Using regular rcpression to seperate sequences from headers
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
header<-gsub(">", "", header)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

#Keeping ID only
Sequences$Name <- gsub("(\\w+)\\s.*", "\\1", Sequences$Name)
print(Sequences$Name)
#I already got rid of the newline characters when doing the strsplit() function

write.csv(Sequences, "Sequences.csv", row.names=FALSE)
