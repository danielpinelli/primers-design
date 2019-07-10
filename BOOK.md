# primers-design
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
The database must be converted to fasta format
```
obiconvert --skip-on-error --embl -t /root/bureau/projet1/PrimerDesign-master/PrimerDesign-master/taxo/TAXO/ --fasta-output ./mitochondria/*.dat
```

The database must be converted to ecoPrimers / ecoPCR format.
```
obiconvert --skip-on-error --embl -t /root/bureau/projet1/PrimerDesign-master/PrimerDesign-master/taxo/TAXO/ --ecopcrdb-output="testobiconvert" rel_est_env_01_r1
```
