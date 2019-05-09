CREATE TABLE sample (
    id integer PRIMARY KEY,
    name text,
    species text,
    description text
);

CREATE TABLE seqgroup(
    id integer PRIMARY KEY,
    name text,
    description text
);

CREATE TABLE seqtype(
    id integer PRIMARY KEY,
    type text
);

CREATE TABLE sequence (
    id integer PRIMARY KEY,
    name text,
    length integer,
    belongsGroup integer,
    isSample integer,
    isType integer,
    FOREIGN KEY (belongsGroup) REFERENCES seqgroup (id),
    FOREIGN KEY (isSample) REFERENCES sample(id),
    FOREIGN KEY (isType) REFERENCES seqtype(id)
);

CREATE TABLE alignedannot(
    id integer PRIMARY KEY,
    onsequence integer,
    start integer,
    end integer,
    strand boolean,
    name text,
    annotation text,
    species text,
    source text,
    method text,
    score text,
    FOREIGN KEY (onsequence) REFERENCES sequence(id)
);

CREATE TABLE seqrelation(
    id integer PRIMARY KEY,
    parentseq integer,
    childseq integer,
    strand boolean,
    pstart integer,
    pend integer,
    cstart integer, 
    cend integer,
    method text,
    FOREIGN KEY (parentseq) REFERENCES sequence (id),
    FOREIGN KEY (childseq) REFERENCES sequence (id)
);

