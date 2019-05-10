library(tidyverse)
library(RSQLite)
library(dbplyr)

# Open the database connection
connection <- dbConnect(SQLite(), 'sql_assignment.db') 

# List the fields in the alignedannot table
dbListFields(connection,'alignedannot')

#dplyr method test
results <- tbl(connection, sql("SELECT * FROM alignedannot
                    WHERE annotation LIKE '%hypothetical%'"))

# Quick test using RSQL method (dbplyr not effective) 
print(dbGetQuery(connection, "SELECT * FROM alignedannot
                    WHERE annotation LIKE '%hypothetical%'"))

# Test of function
testSearchAnnotations <- function(arg1) {
  query <- paste0("SELECT * 
                  FROM alignedannot 
                  WHERE annotation LIKE '%", arg1 ,"%';")
  return(dbGetQuery(connection, query))
}
print(testSearchAnnotations('hypothetical'))

# Full function with header changes and joins
searchAnnotations <- function(arg1) {
  query <- paste0("SELECT sequence.name AS SeqName, 
                  sample.name AS Sample, 
                  seqgroup.name AS SeqGroup, 
                  seqtype.type AS SeqType, 
                  alignedannot.name AS MatchName, alignedannot.annotation AS Annotation
                  FROM alignedannot 
                    JOIN sequence ON sequence.id = alignedannot.onSequence
                    JOIN sample ON sample.id = sequence.isSample
                    JOIN seqGroup ON seqGroup.id = sequence.belongsGroup
                    JOIN seqType ON seqType.id = sequence.isType
                  WHERE annotation LIKE '%", arg1, "%';")
  return(dbGetQuery(connection, query))
}
resultHypotheticals <- searchAnnotations('hypothetical')
head(resultHypotheticals, n=10)

# Database disconnection
dbDisconnect(connection)