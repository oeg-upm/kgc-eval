# Knowledge Graph Construction with R2RML and RML
We conduct an evaluation of KGC engines considering several R2RML and RML processors to identify their strengths and weaknesses. We (i) perform a qualitative analysis of the distinctive features of each engine, (ii) examine their conformance with the mapping language specification they support, and (iii) assess their performance and scalability using the GTFS-Madrid-Bench benchmark.

**Citing**:

```bib
@inproceedings{arenas2021knowledge,
  title = {{Knowledge Graph Construction with R2RML and RML: An ETL System-based Overview}},
  author = {Arenas-Guerrero, Julián and Scrocca, Mario and Iglesias-Molina, Ana and Toledo, Jhon and Pozo-Gilo, Luis and Doña, Daniel and Corcho, Oscar and Chaves-Fraga, David},
  booktitle = {Proceedings of the 2nd International Workshop on Knowledge Graph Construction},
  year = {2021}
}
```

## Engines
We test the performance and scalability of a set of KG construction engines:

R2RML-based:
- Ontop v4.1.0
- Morph-RDB v3.12.5
- R2RML-F v1.2.3
- db2triples v2.2

RML-based:
- RMLMapper v4.9.1
- CARML v0.3.1
- RocketRML v1.8.2
- SDM-RDFizer v3.5
- RMLStreamer v2.0
- Chimera v2.1

## Evaluation resources

### GTFS-Madrid-Bench
Using the [GTFS-Madrid-Bench](https://github.com/oeg-upm/gtfs-bench) and based on the input dataset we create the following distributions to test the engines:

- Formats: CSV, XML, JSON, RDB and Random-Custom (sources in different formats)
- Scale-Sizes: 1, 10, 100 and 1000

Data can be directly download executing `bash scripts/download-data.sh`

### R2RML and RML test-cases
We use the resources provided by the W3C community on KG-Construction (https://www.w3.org/community/kg-construct/) to run the R2RML and RML test-cases over the selected engines.



## Authors
- Julián Arenas-Guerrero - julian.arenas.guerrero@upm.es (Ontology Engineering Group - UPM)
- Mario Scrocca (Cefriel - Politecnico di Milano)
- David Chaves-Fraga (Ontology Engineering Group - UPM)
- Jhon Toledo (Ontology Engineering Group - UPM) 
- Daniel Doña (Ontology Engineering Group - UPM)
- Luis Pozo-Gilo (Ontology Engineering Group - UPM)
- Ana Iglesias (Ontology Engineering Group - UPM)
