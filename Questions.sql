-- 1. Can you list all details about all samples?
SELECT * 
FROM Samples;

-- 2. Can you list just the name and species for all samples?
SELECT name, species 
FROM sample;

-- 3. Can you list details of the first 10 sequences?
SELECT *
FROM sequence 
LIMIT 10;

-- 4. How many loaded sequences are there?
SELECT COUNT(id)
FROM sequence;

-- 5. How many sequences are of the type “genomeAssembly”?
SELECT COUNT(sequence.isType)
FROM sequence 
    JOIN seqtype 
    ON seqtype.id = sequence.isType
WHERE seqtype.type = 'genomeAssembly';

-- 6. How many loaded sequences are there of each different type?
SELECT seqtype.type, COUNT(sequence.isType)
FROM sequence 
    JOIN seqtype 
    ON seqtype.id = sequence.isType
GROUP BY seqtype.type ;

-- 7. How many sequences have a length greater than 1000?
SELECT COUNT(length)
FROM sequence 
WHERE length > 999;

-- 8. How many sequences have a length greater than 1000 and are from sample “D36-s2-tr”?
SELECT COUNT(length)
FROM sequence 
    JOIN sample 
    ON sequence.isSample = sample.id
WHERE length > 1000 AND sample.name = 'D36-s2-tr';

-- 9. What is the average length of all sequences?
SELECT ROUND(AVG(length), 2)
FROM sequence;

-- 10. What is the average length of sequences of type “genomeAssembly”?
SELECT ROUND(AVG(length), 2)
FROM sequence
    JOIN seqtype
    ON seqtype.id = sequence.isType
WHERE seqtype.type = 'genomeAssembly';

-- 11. What is the average length of sequences of type “genomeAssembly” AND what is the average length of sequences
-- of type “protein”?
SELECT seqtype.type, ROUND(AVG(length), 2)
FROM sequence
    JOIN seqtype
    ON seqtype.id = sequence.isType
WHERE seqtype.type = 'genomeAssembly' OR seqtype.type = 'protein'
GROUP BY seqtype.type;

-- 12. How many annotations (alignedannot.annotation) contain the phrase “hypothetical”?
SELECT COUNT(annotation)
FROM alignedAnnot
WHERE annotation LIKE '%hypothetical%';

-- 13. Can you list details of the sequence named “D18-gDNA-s1638”, replacing the foreign keys with sensible 
-- info (e.g. replace ‘isSample’ id with actual sample name)?

SELECT sequence.id, sequence.name, sequence.length, seqgroup.name, sample.name, seqtype.type  
FROM sequence 
    JOIN seqgroup ON seqgroup.id = sequence.belongsGroup
    JOIN sample ON sample.id = sequence.isSample
    JOIN seqtype ON seqtype.id = sequence.isType
    WHERE sequence.name = 'D18-gDNA-s1638';

-- 14. Does the sequence named “D18-gDNA-s1638” have any other sequences that align onto it 
-- (it’ll appear in seqRelation.parentSeq)? List the name(s) of any such sequence(s). 
-- Solution thanks to YingYing

SELECT sequence.id, sequence.name 
FROM sequence 
    JOIN 
    (SELECT seqrelation.childSeq
        FROM sequence
            JOIN seqrelation ON sequence.id = seqrelation.parentSeq
        WHERE name = 'D18-gDNA-s1638') AS Child
    ON sequence.id = Child.childSeq;
