# Evaluation of Knowledge Graph Creation Engines
In this repository we describe the resources we use to evaluate the current approaches focused on creating Knowledge Graph using declarative mapping languages (RML in this case). We have selected a set of relevant use cases covering relevant paremeters that affect to this process and we report in a [previous work](https://www.researchgate.net/publication/336220947_What_are_the_Parameters_that_Affect_the_Construction_of_a_Knowledge_Graph). We also create the corresponding mappings and create docker images to run each selected engine to ensure the reproducibility of our experiments.

## Use Cases
We include 4 different uses cases to evaluate this engines:
- Bio2RDF project: 
- GTFS-Madrid-Bench:
- IASIS project:
- Synthetic data: 

We have prepared a set of scripts in bash to download the data and prepared for the experimentation (please, note that the data from IASIS project is not open so we cannot provide it).

## Mappings
We create a set of mappings for each use case using RML specification. It can be found in the mappings folder


## Engines
We test the performance and correctness of the RML compliant engines deatiled in the [RML-Implementation-report](http://rml.io/implementation-report/):

- RMLMapper v4.5.1
- CARML v0.2.3
- RocketRML v.1.0.6
- SDM-RDFizer v3.2
- RMLStreamer v1.0.0

## Authors
- David Chaves-Fraga (Ontology Engineering Group - UPM) 
- Ana Iglesias-Molina (Ontology Engineering Group - UPM)
- Enrique Iglesias (University of Bonn)
- Kemele M. Endris (TIB and L3S Research Group)
- Maria-Esther Vidal (TIB and L3S Research Group)
- Oscar Corcho (Ontology Engineering Group - UPM)
