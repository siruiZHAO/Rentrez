#loads the rentrez package
install.packages("rentrez")
library(rentrez) 

#add lines 
ncbi_ids <- c("HQ433692.1", "HQ433694.1", "HQ433691.1")
Bburg <- entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#create new object called Sequence by using strsplit() function
Sequences <- strsplit(Bburg, split = "\n\n", fixed = T) 

print(Sequences)

#convert to the dataframe
Sequences <- unlist(Sequences)

#separate the sequences from the headers by using regular expressions
header <- gsub("(^>.*sequence)\\n[ATCG].*", "\\1", Sequences)
seq <- gsub("^>.*sequence\\n([ATCG].*)", "\\1", Sequences)
Sequences <- data.frame(Name = header, Sequence=seq)

#remove the newline characters by using regular expressions
Sequences$Sequence <- gsub("\n", "", Sequences$Sequence)

#Output this data frame to a file called Sequences.csv.
write.csv(Sequences, "Sequences.csv")
