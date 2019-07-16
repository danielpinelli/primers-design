# primers-design


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

- [mullus.fa](02-raw/mullus.fa) : j'ai sequence ces donnees.....
- [mullus.taxid.fa](02/raw/mullus.taxid.fa) : taxid........
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
