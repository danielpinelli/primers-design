###############################################################################
## config file

###############################################################################
## taxonomy
TAXD=02-raw/taxdump
## EMBL dat files
EMBLDAT=02-raw/EMBL/rel_std_*dat
## converted EMBL OBIFASTA files
EMBLOBIFA=02-raw/EMBL.obifasta
## FASTA.taxid custom files
FASTAF=02-raw/mullus.taxid.fa
## ecopcr database
#ECOPCRDAT=03-ecopcr/test
ECOPCRDAT=03-GROS_ecopcr/refdb

#ecoprimers database
#ECOPRIME=04-primers
ECOPRIME=04-primers/mullus01.ecoprimers

###############################################################################
## ecoPCR arguments
### [-e] Maximum number of errors (mismatches) allowed per primer.
ecoPCR_e=3
### [-l] Minimum length of the in silico amplified DNA fragment, excluding primers.
ecoPCR_l=50
### [-L] Maximum length of the in silico amplified DNA fragment, excluding primers.
ecoPCR_L=150

## teleostei taxon ID
TELEOSTEI_TAXID=32443


### 5' primer sequence MS-DL1-F
MS_DL1_F=CATACGTATACTGATATA
### 3' primer sequence MS-DL1-R
MS_DL1_R=TAATAAATCGCTAGCGGT

MS_DL2_F=GTGAGGGACAAAAATCGT
MS_DL2_R=TCGGCATGGTGGGTAACG


MS-DL3-F=GGGCAGGGGGTTCCTTTT
MS-DL3-R=TGAGGAGGTATAGATCAG

MS-DL4-F=TATGCATACGTATACTGA
MS-DL4-R=TTCAATAAACGTATGCTT