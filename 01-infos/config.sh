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
ECOPCRDAT=03-ecopcr/refdb

#ecoprimers database
#ECOPRIME=04-primers
ECOPRIME=04-primers/mullus01.ecoprimers

###############################################################################
## ecoPCR arguments
### [-e] Maximum number of errors (mismatches) allowed per primer.
ecoPCR_e=3
### [-L] Maximum length of the in silico amplified DNA fragment, excluding primers.
ecoPCR_L=1000

## teleostei taxon ID
TELEOSTEI_TAXID=32443


### 5' primer sequence MS-DL1-F
MS_DL1_F=CATACGTATACTGATATA
### 3' primer sequence MS-DL1-R
MS_DL1_R=TAATAAATCGCTAGCGGT

MS_DL2_F=GTGAGGGACAAAAATCGT
MS_DL2_R=TCGGCATGGTGGGTAACG

MS_DL3_F=GGGCAGGGGGTTCCTTTT
MS_DL3_R=TGAGGAGGTATAGATCAG

MS_DL4_F=TATGCATACGTATACTGA
MS_DL4_R=TTCAATAAACGTATGCTT

MS_DL5_F=TGATATAGGACACGATAT
MS_DL5_R=GTTTAATCTGATTAATAA

MS_DL6_F=TGATATAGGACACGATAT
MS_DL6_R=TGTCCCTCACCTTCAATA

MS_DL7_F=AGGACACGATATGTATTA
MS_DL7_R=AGTTATCAACTGATGGTA

MS_DL8_F=AGACTCAAATAAGTACGA
MS_DL8_R=AAAAGGAACCCCCTGCCC

MS_DL9_F=AAGACTCAAATAAGTACG
MS_DL8_R=AAAAGGAACCCCCTGCCC

MS_DL10_F=CATAAGTTAATGCTTTCG
MS_DL10_R=TGAGGAGGTATAGATCAG

MS_DL11_F=ACGCTTGCATAAGTTAAT
MS_DL11_R=TGAGGAGGTATAGATCAG