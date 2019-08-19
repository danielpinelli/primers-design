# Primer design and in silico primer test
I present here the key steps to design primers and test them in silico rigorously. The ecoPrimer program (Riaz et al., 2011) has the particularity of being able to design primers that amplify markers specific to the target species and that can be used for eDNA. The primers are then tested using the ecoPCR program (Ficetola et al., 2010, Bellemain et al., 2010), performing an in-silico PCR based on EMBL data including a large number of referenced species. This EMBL database is combined with the sequences obtained in the laboratory. For more information on the programs do not hesitate to consult: 
ecoPrimers : https://pythonhosted.org/OBITools/scripts/ecoPrimers.html
ecoPCR : https://pythonhosted.org/OBITools/scripts/ecoPCR.html

## Installation

### Dependencies

#### EMBOSS

```
wget -m 'ftp://emboss.open-bio.org/pub/EMBOSS/'
cd emboss.open-bio.org/pub/EMBOSS
gunzip EMBOSS-latest.tar.gz
tar xvzf emboss-latest.tar.gz
cd EMBOSS-6.6.0/
./configure --prefix=/usr/local/emboss
mkdir /usr/local/emboss
make && make install
```

### singularity

Create a shell container
```
singularity shell -B `pwd`:/workf,/entrepot/donnees/edna/referenceDatabase/TAXO/:/taxo,/entrepot/donnees/edna/referenceDatabase/EMBL:/embl /entrepot/utils/conteneurs/obitools.simg
```
set up embl and taxo folders into the container
```
cd /workf/
rm -Rf 02-raw/EMBL
rm 02-raw/taxdump
ln -s /embl/ 02-raw/EMBL
ln -s /taxo/ 02-raw/taxdump

```

### R packages

#### ROBITOOLS

ubuntu linux shell
```
yes | sudo apt-get install libcurl4-openssl-dev libxml2 libxml2-dev libssl-dev

git clone https://git.metabarcoding.org/obitools/ROBITaxonomy.git
git clone https://git.metabarcoding.org/obitools/ROBITools.git
```

R environment
```
install.packages("devtools")
devtools::install_github("r-lib/devtools")
install.packages("igraph")


install.packages("~/src/ROBITaxonomy/", repos = NULL, type="source")
install.packages("~/src/ROBITools/", repos = NULL, type="source")
```

## Data

- [mullus.taxid.fa](02/raw/mullus.taxid.fa) : sequences obtained in the laboratory
- EMBL
- TAXO

## database design (sequences and taxa)
You have to download all NCBI sequences and combine them with our lab-defined sequences in .gbk format. In parallel, all taxon identifiers must be downloaded into a separate file.
```
wget 'ftp://ftp.ncbi.nlm.nih.gov://pub/taxonomy/taxdump.tar.gz'
mkdir TAXO
cd TAXO/
tar -zxvf taxdump.tar.gz
cd ..
```
```
mkdir EMBL
cd EMBL
wget ftp://ftp.ebi.ac.uk/pub/databases/ena/sequence/release/std/*
gunzip -d *gz
cd ..
```
The database must be converted to ecoPrimers / ecoPCR format.
```
obiconvert --skip-on-error --embl -t /root/bureau/projet1/PrimerDesign-master/PrimerDesign-master/taxo/TAXO/ --ecopcrdb-output="testobiconvert" rel_est_env_01_r1
```
PE : ou tu tapes (les parameters sont dans 01-infos/config.sh) :
```
bash 00-scripts/ecopcrdb.sh
```

####error pour ecoPrimers#####
root@DESKTOP-DI0FSDD:~/bureau/WORKING/primers-design# bash 00-scripts/ecopcrdb.sh
Reading taxonomy database ...Reading 2096301 taxa...
No local taxon
Ok
Reading sequence database ...
# Reading file 03-ecopcr/multidata_001.sdx containing 0 sequences...
# Reading file 03-ecopcr/multidata_002.sdx containing 0 sequences...
Ok
Sequence read : 0
Database is constituted of     0 examples        corresponding to     0 species
                       and     0 counterexamples corresponding to     0 species
Total distinct species count 0
Indexing words in sequences
Filtering...
00-scripts/ecopcrdb.sh: line 26: 15448 Segmentation fault      (core dumped) ecoPrimers -d $ECOPCRDAT -e 3 -l 50 -L 120 -r 87757 -3 2 > mullus01.ecoprimers

####error pour ecoPCR####
Reading 2096301 taxa...
No local taxon
# Reading file 03-ecopcr/mulos_001.sdx containing 0 sequences...
# Reading file 03-ecopcr/mulos_002.sdx containing 0 sequences...

_________________


## primers-design with ecoPrimers
The design of primers is done on the sequences defined in laboratory combined with a base of references targeting for example the family of the target species (Mullidae) or the class (Teleostei). Download in .gbK format all referenced D-loop sequences from the Mullidae family and the taxonomic reference base.

```
wget 'ftp://ftp.ncbi.nlm.nih.gov://pub/taxonomy/taxdump.tar.gz'
mkdir TAXO
cd TAXO/
tar -zxvf taxdump.tar.gz
cd ..
```
Write in NCBI the link below and download the 552 sequences in .gbk format. Create an NCBI folder and drop the genbank file.
```
D-loop[All Fields] AND ("Mullidae"[Organism] OR ("Mullidae"[Organism] OR Mullidae[All Fields]))

mkdir NCBI/
```
Convert the genbank file into Fasta format. 
```
obiconvert NCBI/* > mullidae_dloop.fasta
```
Copy paste the 21 sequences obtained in the laboratory and their number taxid (taxid = 87757) in the file Mullidae_Dloop.fasta. Convert this file to ecopcr format (ndx, rdx, tdx, sdx).
```
obiconvert --skip-on-error --fasta -t ./TAXO --ecopcrdb-output=database_mullidae_dloop > /root/.../mullidae_dloop.fasta
```
Design the primers according to several criteria with ecoPrimers on the files in ecopcr format. Specify the maximum shadow of errors (inconsistencies) allowed by primer (-e 3), specify the minimum and maximum length of the barcode excluding primers (-l 100 -L 150), specify the taxid to amplify ( 87757) and the counterexample taxid (342443).
```
ecoPrimers -d database_mullidae_dloop -e 3 -l 100 -L 150 -r 87757 -E 342443 > mullus_barcodes.ecoprimers
```
Example of ecoPrimers result.
```
# ecoPrimer version 0.5
# Rank level optimisation : species
# max error count by oligonucleotide : 3
#
# Restricted to taxon:
#     87757 : Mullus surmuletus (species)
#
# strict primer quorum  : 0.70
# example quorum        : 0.90
# counterexample quorum : 0.10
#
# database : sequences
# Database is constituted of    18 examples        corresponding to     1 species
#                        and    65 counterexamples corresponding to     1 species
#
# amplifiat length between [100,150] bp
# DB sequences are considered as linear
# Pairs having specificity less than 0.60 will be ignored
#

1  CATACGTATACTGATATA      TAATAAATCGCTAGCGGT      42.4    30.0    51.5    49.7    5       7       GG      18      0       1.000   1       0       1.000   1       1.000   140     140     140.00
2  CATACGTATACTGATATA      TTAATAAATCGCTAGCGG      42.4    30.0    50.5    45.7    5       7       GG      18      0       1.000   1       0       1.000   1       1.000   141     141     141.00
3  ATTAATAAATCGCTAGCG      CATACGTATACTGATATA      48.2    43.2    42.4    30.0    6       5       GG      18      0       1.000   1       0       1.000   1       1.000   142     142     142.00
4  CATACGTATACTGATATA      GATTAATAAATCGCTAGC      42.4    30.0    46.4    41.1    5       6       GG      18      0       1.000   1       0       1.000   1       
```


## database design and ecoPCR test in silico
In the mullus_barcodes.ecoprimers file you can choose the primers that match your request. Subsequently, we must test the quality of primers with the ecoPCR program. ecoPCR performs in silico PCR. Primers designed should only amplify the target species, Mullus surmuletus.
To perform this operation you have to download all the basic EMBL references and convert ecopcr format.
```
mkdir EMBL
cd EMBL
wget ftp://ftp.ebi.ac.uk/pub/databases/ena/sequence/release/std/*
gunzip -d *gz
cd ..
```
Before converting the reference database to .ecopcr format, we have to combine our 21 laboratory-defined sequences with the EMBL reference database.
```
seqret -sequence mullus_dloop.fasta -osformat embl -outseq mullus_dloop.dat
```
Convert the entire EMBL + mullus_dloop.dat reference database to ecopcr format.
```
Obiconvert --skip-on-error --embl -t ./TAXO --ecopcrdb-output=database_embl ./EMBL/*.dat
```
Test the quality of primers with ecoPCR.
```
ecoPCR -d ./EMBL -e 3 -l 100 -L 150  CATACGTATACTGATATA TAATAAATCGCTAGCGGT> MS_DL1.ecopcr
ecoPCR -d ./EMBL -e 3 -l 100 -L 150  GTGAGGGACAAAAATCGT TCGGCATGGTGGGTAACG> MS_DL2.ecopcr
ecoPCR -d ./EMBL -e 3 -l 100 -L 150  GGGCAGGGGGTTCCTTTT TGAGGAGGTATAGATCAG> MS_DL3.ecopcr
ecoPCR -d ./EMBL -e 3 -l 100 -L 300  TATGCATACGTATACTGA TTCAATAAACGTATGCTT> MS_DL4.ecopcr
```
Example of ecoPCR result.
```
# ecoPCR version 1.0.1
# direct  strand oligo1 : CATACGTATACTGATATA               ; oligo2c :               ACCGCTAGCGATTTATTA
# reverse strand oligo2 : TAATAAATCGCTAGCGGT               ; oligo1c :               TATATCAGTATACGTATG
# max error count by oligonucleotide : 3
# optimal Tm for primers 1 : 41.19
# optimal Tm for primers 2 : 50.30
# database : 03-ecopcr/refdb
# amplifiat length between [50,150] bp
# output in superkingdom mode
# DB sequences are considered as linear
#
CP017762        |   4749385 |  1911587 | species              |  1911587 | Virgibacillus sp. 6R           |    84406 | Virgibacillus                  |   186817 | Bacillaceae                    |        2 | Bacteria                       | D | CATACATATAATGATATA               |  2 | 17.44 | TAATAACTCGATAGAGGT               |  3 | 21.47 |   143 | AGAGTTTCTCCAGCAATCCATATAACGTTGGGTTTTTCTGTTCCATTTCGTTAATGATGAGAAAAATTTGTTTCACTAACGTATGATCCCGGAAGTCTTCCATATCGTTTGGGTTTATTTCTATATTTCTTCCCCACTTGCTA | Virgibacillus sp. 6R, complete genome
INTRAPOPMULMS9SN |       800 |    87757 | species              |    87757 | Mullus surmuletus              |    37006 | Mullus                         |    30854 | Mullidae                       |     2759 | Eukaryota                      | D | CATACGTATACTGATATA               |  0 | 41.19 | TAATAAATCGCTAGCGGT               |  0 | 50.30 |   140 | GGACACGATATGTATTAAAACCATTTTAATGATTTAAACCAATCAGGTCCCAAATCCGTAGAAATCCCAGAAAACAGGACAGATAAAAAAGAAGACTCAAATAAGTACGAAACAGCAAAAATACAGAAATAGAACTGATG | Mullus surmuletus mitochondrial DNA Dloop
INTRAPOPMULMS8SN |       800 |    87757 | species              |    87757 | Mullus surmuletus              |    37006 | Mullus                         |    30854 | Mullidae                       |     2759 | Eukaryota                      | D | CATACGTATACTGATATA               |  0 | 41.19 | TAATAAATCGCTAGCGGT               |  0 | 50.30 |   140 | GGACACGATATGTATTAAGACCATCTTARTGATTCAAACCAATCGG-TCCAAAATCCATAGAAGTCCCAGAAAACAGGACAGATAAAAAAGAAGACTCAAATAAGTACGAAATACCAAAAATACAGAAATAGAACTGATG | Mullus surmuletus mitochondrial DNA Dloop
INTRAPOPMULMS2SN |       800 |    87757 | species              |    87757 | Mullus surmuletus              |    37006 | Mullus                         |    30854 | Mullidae                       |     2759 | Eukaryota                      | D | CATACGTATACTGATATA               |  0 | 41.19 | TAATAAATCGCTAGCGGT               |  0 | 50.30 |   140 | GGACACGATATGTATTAAGACCATTTTARTGATTCAAACCAATCRGGTCCAAAATCCATARAAGTCCCAGAAAACAGGACAGATAAAAAAGAAGACTCAAATAAGTACGAAATACCAAAAATACAAAAATAGAACTGATG | Mullus surmuletus mitochondrial DNA Dloop
```

## Visualization with R of the ecoPCR test with ROBITools, ROBITaxonomy and ROBIBarcodes packages.
Use R on linux and install the packages.
```
install.packages ('/root/.../ROBITaxonomy-master.tar.gz', repos = NULL, type = "source")
install.packages ('/root/.../ROBITools-master.tar.gz', repos = NULL, type = "source")
install.packages ('/root/.../ROBIBarcodes-master.tar.gz', repos = NULL, type = "source")
library (ROBITaxonomy)
library (ROBITools)
library (ROBIBarcodes)
```
Loading taxonomic data and ecopcr file.
```
fishpcr = read.ecopcr.result('MS_DL1.ecopcr')
taxo = read.taxonomy ('/root/.../TAXO')
```
Identify sequences that belong to Mullidae or Mullus surmuletus.
```
mullus.taxid = ecofind(taxo,'^Mullidae$')
```
```
is_a_fish=is.subcladeof(taxo,fishpcr$taxid,mullus.taxid)
table(is_a_fish)

## is_a_fish
## FALS TRUE 
##   1   21
```
Testing the conservation of the priming sites.
```
MS_DL1.forward = ecopcr.forward.shanon(ecopcr = fishpcr, group = is_a_fish)
MS_DL1.reverse = ecopcr.reverse.shanon(ecopcr = fishpcr, group = is_a_fish)
```
Ploting the results.
```
png(file = "primers1.png")
par(mfcol=c(3,2))
dnalogoplot(Fish.forward$'TRUE',primer = "CATACGTATACTGATATA", main='Forward MS-DL1')
dnalogoplot(Fish.forward$'FALSE',primer = "CATACATATAATGATATA", main='Forward not Fish')
dnalogoplot(Fish.reverse$'TRUE',primer = "TAATAAATCGCTAGCGGT", main='Reverse MS-DL1')
dnalogoplot(Fish.reverse$'FALSE',primer = "TAATAACTCGATAGAGGT",main='Reverse not Fish')
dev.off()
```
How mismatches influence taxonomical selection.
```
png(file = "Mismatch1.png")
par(mfcol=c(1,1))
mismatchplot(fish,group = is_a_fish, legend=c('Virgibacillus sp','Mullus surmuletus'),  col = c('red','gray14'))
dev.off()
```
repeat the operation with the other 3 pairs of primers.
```
# End
```
