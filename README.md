# Primer design and in silico primer test
I present here the key steps to design primers and test them in silico rigorously. The ecoPrimer program (Riaz et al., 2011) has the particularity of being able to design primers that amplify markers specific to the target species. The primers are then tested using the ecoPCR program (Ficetola et al., 2010, Bellemain et al., 2010), performing an in-silico PCR based on EMBL data including a large number of referenced species. This EMBL database is combined with the sequences obtained in the laboratory for the species Mullus surmuletus (this species is taken as an example to create and test primers on the D-loop of the mitochondrial genome).The ecoPCR program allows you to see if the target species is amplified and if non-target species are amplified. For more information on the programs and their installation, do not hesitate to consult: 

ecoPrimers : 

https://git.metabarcoding.org/obitools/ecoprimers/wikis/home
https://pythonhosted.org/OBITools/scripts/ecoPrimers.html

ecoPCR : 

https://git.metabarcoding.org/obitools/ecopcr/wikis/home
https://pythonhosted.org/OBITools/scripts/ecoPCR.html

## Installation
To run the scripts, follow the installations below :

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

## Data

- [mullus.taxid.fa](02/raw/mullus.taxid.fa) : sequences obtained in the laboratory
- EMBL
- TAXO

# Primers design with ecoPrimers
## Step 1 : Download Mullidae's sequences on NCBI (.gbk format)
The design of primers is done on the sequences defined in laboratory combined with a base of references targeting for example the family of the target species (Mullidae) or the class (Teleostei). Thus, ecoPrimers will design primers on sequences of the target species (Mullus surmuletus) and avoid regions of the sequence that are similar to non-target species of the Mullidae family for D-loop. Download in .gbK format all referenced D-loop sequences from the Mullidae family and the taxonomic reference base.

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
## Step 2 : Convert the genbank file into Fasta format
The data downloaded in .gbk format contain important information such as the taxid number etc ... This is why we download them in this format. The conversion of this file into fasta format will allow us to copy/paste our fasta Mullus surmuletus sequences obtained in the laboratory.

```
obiconvert NCBI/* > mullidae_dloop.fasta
```
## Step 3 : Copy/paste D-loop sequences of Mullus surmuelus and convert en format ecopcr
Copy/paste manually the sequences obtained in the laboratory and their number taxid (taxid = 87757) in the file mullidae_dloop.fasta. Convert this file to ecopcr format (ndx, rdx, tdx, sdx) (ecoPrimer only works with this specific format).

```
obiconvert --skip-on-error --fasta -t ./TAXO --ecopcrdb-output=database_mullidae_dloop > /root/.../mullidae_dloop.fasta
```
## Step 4 : Primer design
Design the primers according to several criteria with ecoPrimers on the files in ecopcr format. Specify the maximum number of errors (inconsistencies) allowed by primer (-e 3), specify the minimum and maximum length of the barcode excluding primers (-l 100 -L 150), specify the taxid to amplify ( 87757) and the counterexample taxid (342443).
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

# Database design and ecoPCR test in silico
## Step 5: Download the EMBL database and convert it to ecopcr format
In the mullus_barcodes.ecoprimers file, you can choose the primers that match your request. Subsequently, we must test the quality of the primers with the ecoPCR program that performs in silico PCR. That is, ecoPCR will test whether the primers amplify the Mullus surmuletus target species well and will also see if the primers do not amplify other non-target taxa. To perform this operation, you must download all EMBL baselines and convert the ecopcr format (read by ecoPCR).

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
## Step 6: Test PCR in silico
To test the primers on the EMBL database combined with the sequences obtained in the laboratory, several criteria must be specified. It is necessary, for example, to specify the maximum size of the sequences that can be amplified (-L 1000) during a PCR, the maximum number of errors allowed by primers (-e 3) and the forward and reverse primers that will be tested.

```
ecoPCR -d ./EMBL -e 3 -L 1000  CATACGTATACTGATATA TAATAAATCGCTAGCGGT> MS_DL1.ecopcr
ecoPCR -d ./EMBL -e 3 -L 1000  GTGAGGGACAAAAATCGT TCGGCATGGTGGGTAACG> MS_DL2.ecopcr
ecoPCR -d ./EMBL -e 3 -L 1000  GGGCAGGGGGTTCCTTTT TGAGGAGGTATAGATCAG> MS_DL3.ecopcr
ecoPCR -d ./EMBL -e 3 -L 1000 TATGCATACGTATACTGA TTCAATAAACGTATGCTT> MS_DL4.ecopcr
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
# amplifiat length between [,1000] bp
# output in superkingdom mode
# DB sequences are considered as linear
#
CP003973        |   1806219 |  1211705 | no rank              |      670 | Vibrio parahaemolyticus        |      662 | Vibrio                         |      641 | Vibrionaceae                   |        2 | Bacteria                       | R | CAGAAGTTTACTGATATA               |  3 | 15.89 | TAATCAATCGCTAACCGT               |  3 | 11.35 |   325 | CGCATGGCTGGCTGCTGCGAATTGTAAAAATTGATGTCGGCCTATTGCTGACCATCGATTTTCGATAGCATATTTCTCAGCTTTGAGAGCATTTTTCAGATCGCAATTGGCACCGTTGTTTAACTTTTCACCATCGTACTTCTTTACAATGCTGTTATAGTTAGCAACATCTGACTCTAGGACACCCAGTAGTTTTAATAAATTTTCTTTACTGCTGTCTAACTCAATTTCATCTTTAACTCTAAAGTAGAATTCAGATGGCAGTTCGCTGACTCTTTTTAGGTCTTCTACAAACTTCTGATACCCTTCCGCTTCAATATTGAGC | Vibrio parahaemolyticus BB22OP chromosome 2
INTRAPOPMULMS9SN |       800 |    87757 | species              |    87757 | Mullus surmuletus              |    37006 | Mullus                         |    30854 | Mullidae                       |     2759 | Eukaryota                      | D | CATACGTATACTGATATA               |  0 | 41.19 | TAATAAATCGCTAGCGGT               |  0 | 50.30 |   140 | GGACACGATATGTATTAAAACCATTTTAATGATTTAAACCAATCAGGTCCCAAATCCGTAGAAATCCCAGAAAACAGGACAGATAAAAAAGAAGACTCAAATAAGTACGAAACAGCAAAAATACAGAAATAGAACTGATG | Mullus surmuletus mitochondrial DNA Dloop
INTRAPOPMULMS8SN |       800 |    87757 | species              |    87757 | Mullus surmuletus              |    37006 | Mullus                         |    30854 | Mullidae                       |     2759 | Eukaryota                      | D | CATACGTATACTGATATA               |  0 | 41.19 | TAATAAATCGCTAGCGGT               |  0 | 50.30 |   140 | GGACACGATATGTATTAAGACCATCTTARTGATTCAAACCAATCGG-TCCAAAATCCATAGAAGTCCCAGAAAACAGGACAGATAAAAAAGAAGACTCAAATAAGTACGAAATACCAAAAATACAGAAATAGAACTGATG | Mullus surmuletus mitochondrial DNA Dloop
INTRAPOPMULMS2SN |       800 |    87757 | species              |    87757 | Mullus surmuletus              |    37006 | Mullus                         |    30854 | Mullidae                       |     2759 | Eukaryota                      | D | CATACGTATACTGATATA               |  0 | 41.19 | TAATAAATCGCTAGCGGT               |  0 | 50.30 |   140 | GGACACGATATGTATTAAGACCATTTTARTGATTCAAACCAATCRGGTCCAAAATCCATARAAGTCCCAGAAAACAGGACAGATAAAAAAGAAGACTCAAATAAGTACGAAATACCAAAAATACAAAAATAGAACTGATG | Mullus surmuletus mitochondrial DNA Dloop
```

# Visualization with R of the ecoPCR test with ROBITools, ROBITaxonomy and ROBIBarcodes packages.
It is possible to obtain a representation of the ecoPCR results in order to visualize the target or non-target species that are amplified. It is also possible to observe if the nucleotide sites are well conserved in the primers within the target species (between all the amplified sequences of the target species).

## Step 7: Use R on linux and install the packages

```
install.packages ('/root/.../ROBITaxonomy-master.tar.gz', repos = NULL, type = "source")
install.packages ('/root/.../ROBITools-master.tar.gz', repos = NULL, type = "source")
install.packages ('/root/.../ROBIBarcodes-master.tar.gz', repos = NULL, type = "source")
library (ROBITaxonomy)
library (ROBITools)
library (ROBIBarcodes)
```
## Step 8: Loading taxonomic data and ecopcr file
```
fishpcr = read.ecopcr.result('MS_DL1.ecopcr')
taxo = read.taxonomy ('/root/.../TAXO')
```

## Step 9: Identify the amplified sequences and create a graph
Depending on the output of ecoPCR, create groups of taxa that are amplified. The MS-DL1 primer pair amplifies the sequences of the target species (Mullus surmuletus) but also sequences belonging to other species such as a marine bacterium (Vibrio parahaemolyticus), a marine fish (Sparus aurata) and other species that are unlikely to be in the same ecosystem as our target species.

```
is_a_mullus=is.subcladeof(taxo,mullus$taxid,37006)
is_a_fish=is.subcladeof(taxo,mullus$taxid,2759)
is_a_bact=is.subcladeof(taxo,mullus$taxid,641)
is_a_fish1=is.subcladeof(taxo,mullus$taxid,8169)
group = rep('Other species',length(is_a_fish))
group[is_a_mullus]='Mullus surmuletus'
group[is_a_bact]='Marine bacteria'
group[is_a_fish1]='Other marine fish'
group=as.factor(group)
table(group)

```
Results of creating groups

```
Marine bacteria Mullus surmuletus Other marine fish     Other species
       7                20                 1                15
```

After creating the groups, we can represent them with a graph.

```
png(file = "Mismatch1.png")
par(mfcol=c(1,1))
mismatchplot(mullus,group =group, col=c('orange','red','white','dodgerblue'))
dev.off()

```
```
 ![Number of mismatch with reverse (y) and forward (x) primers](/root/bureau/WORKING/GITHUB/primers-design/Mismatch1.png) 

 ![Number of mismatch with reverse (y) and forward (x) primers](bureau/Mismatch1.png)
```
## Step 10: Testing the conservation of the priming sites and create a graph
```
MS_DL1.forward = ecopcr.forward.shanon(ecopcr = fishpcr, group = is_a_fish)
MS_DL1.reverse = ecopcr.reverse.shanon(ecopcr = fishpcr, group = is_a_fish)
```
Ploting the results of conservation of the priming sites.
```
png(file = "primers1.png")
par(mfcol=c(3,2))
dnalogoplot(Fish.forward$'TRUE',primer = "CATACGTATACTGATATA", main='Forward MS-DL1')
dnalogoplot(Fish.forward$'FALSE',primer = "CATACATATAATGATATA", main='Forward not Fish')
dnalogoplot(Fish.reverse$'TRUE',primer = "TAATAAATCGCTAGCGGT", main='Reverse MS-DL1')
dnalogoplot(Fish.reverse$'FALSE',primer = "TAATAACTCGATAGAGGT",main='Reverse not Fish')
dev.off()
```
## Repeat the operation with the other pairs of primers
We finished. Specific target species primers (Mullus surmuletus) were created and these primers were tested in silico PCR throughout the EMBL database. The primers are not perfect because they also amplify some other taxa but it can still work in eDNA. After having designed and tested in silico the primers, the next step will be to perform an in vitro test (test the primers on the DNA extracted from the target species to ensure that it is well amplified).
