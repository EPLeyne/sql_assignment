import sqlite3

def searchAnnotations(database_file, annotation):
    query = "SELECT sequence.name AS SeqName, 
                  sample.name AS Sample, 
                  seqgroup.name AS SeqGroup, 
                  seqtype.type AS SeqType, 
                  alignedannot.name AS MatchName, alignedannot.annotation AS Annotation
                  FROM alignedannot 
                    JOIN sequence ON sequence.id = alignedannot.onSequence
                    JOIN sample ON sample.id = sequence.isSample
                    JOIN seqGroup ON seqGroup.id = sequence.belongsGroup
                    JOIN seqType ON seqType.id = sequence.isType
                  WHERE annotation LIKE '%" + annotation + "%';"
    connection = sqlite3.connect(database_file)
    cursor = connection.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()
    connection.close()

    return results[0] #10 results only

print(searchAnnotations('sql_assigment.db','hypothetical'))
