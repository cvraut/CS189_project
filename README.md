# Comparing Yeast Genomes
A genetic comparison of 5 different types of yeast

# Background
Yeast is a type of bacteria known to evolve rapidly and offer vast genetic variety even within the same species.
The purpose of this project is to understand and use tools to quantify differences in genome of 5 different yeast genomes:
   - Saccharomyces cerevisiae strain S288C
   - Saccharomyces cerevisiae strain W303
   - Saccharomyces cerevisiae strain SK1
   - Saccharomyces cerevisiae strain G833-1B
   - Saccharomyces uvarum strain CBS7001

An interesting insight that was identified in this project was that the contiguity of the genome affected the genome similarity differently across Mummer and Satsuma. More work would have to be done in the future to investigate this behavior.

Main Programs Used:
 - assembly-stats (quality assesment)
 - Satsuma2 (synteny maps)
 - Mummer (structural variant plots)
 - Clustalw (phylogeny tree)

# Pipeline
(2)Data --> (3)Preprocess --+--> (4)Assembly Stats
                            |
                            +--> (5)Satsuma2 --> Chromosomepaint
                            |
                            +--> (6)Nucmer --> Mummerplot
                            |
                            +--> (7)BLAST --> ClustalW --> Etetoolkit

# Pipeline Steps
## 1) setting up conda env
*Note all scripts were ran in a conda environment with python=2.7
If conda is installed then the environment can be replicated using:*
```
conda cg_yeast create -f environment.yml
conda activate cg_yeast
```
## 2) Data
The data was obtained through Edwin Solares from GautLab@UCI who primarily consulted [yeastgenome](https://www.yeastgenome.org). 
We have consolidated the data in the [data/originals](https://github.com/cvraut/CS189_project/tree/chinmay/data/originals) dir.

## 3) Preprocess
The data was preprocessed through [1 python script](https://github.com/cvraut/CS189_project/blob/chinmay/scripts/ren_condensed.py) which both renamed the contig descriptors to be shorter for better visualizations and eliminated reads of < 1kb.
```
python scripts/ren_condensed.py
```
The result is the "cleaned" fasta files in the [data dir](https://github.com/cvraut/CS189_project/tree/chinmay/data).

## 4) Evaluating the genome quality
The N50 of the genomes were retreived through the Assembly stats program by running the following [commands](https://github.com/cvraut/CS189_project/blob/chinmay/gen_n50s.sh).
```
assembly-stats "genome.fasta" > "output.stats"
```
![N50 Table](/pics/n50.png)

## 5) Synteny Maps
The Synteny maps consisted of 2 main processes:
 - running satsuma2 to generate the mappings of contigs ([bash script](https://github.com/cvraut/CS189_project/blob/chinmay/qsub_satsuma.sh)).
 ```
 SatsumaSynteny2 -t data/"reference.fasta" -q data/"query.fasta" -o outputs/"new dir"
 ```
 - visualizing mappings using satsuma's chromosomepaint functionality ([bash script](https://github.com/cvraut/CS189_project/blob/chinmay/gen_figs.sh)).
 ```
 BlockDisplaySatsuma -i outputs/"new dir"/satsuma_summary.chained.out -t data/"reference.fasta" -q data/"query.fasta" > "output.out"
 ChromosomePaint -d 10 -s 400 -i "output.out" -o "img.ps"
 ```
 ![Synteny Map](/pics/syn_map.png)

 ## 6) Identifying Structural Variants
 The mummerplots (like satsuma) follow 2 main steps [bash script](https://github.com/cvraut/CS189_project/blob/chinmay/qsub_nucmer.sh)
  - align fasta files
  ```
  nucmer --maxmatch -c 100 -p "query.fasta" "reference.fasta "query.fasta"
  ```
  - produce plot based on alignment
  ```
  mummerplot --png --fat --layout --filter ${SEED}.delta -R ${REF} -Q ${SEED} --prefix=${SEED}
  ```
  ![Mummerplot](/pics/mummerplot.png)

## 7) Producing the Phylogeny Tree
Producing the phylogeny tree was rather involved and required the use of many webtools to acquire the data
  1. First a gene/common section of dna would have to be identified from all the yeast strains to use for a comparison. We originally planned to use the 18s RNA section; however we could not find matches for it in the g833-1B, SK1, or CBS7001 genome. Therefore we began following a [paper]() which outlined many common genes between yeast species. We tried the genes by blasting their sequences against the genome of the organism in the [NCBI blastn suite](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome) until we found a gene that had at least 20% coverage in each yeast's genome. The gene we finally settled on was [yll065w](https://www.yeastgenome.org/locus/S000003988) found in the [data dir]()
  2. Then we ran this sequence in clustalw to generate the tree and the edge lengths ([bash script]())
  ```
  clustalw < clustalw.in
  ```
  3. Then we visualized the tree using the [web etetoolkit](http://etetoolkit.org/treeview/)
  ![Tree](/pics/tree.png)

# Conclusion
refer to the [writeup](https://docs.google.com/document/d/1KNQ6TGLGn5cANC1CSuzZIuPjTDEG9VN8L9dKRxzwwns/edit) for conclusion and analysis.