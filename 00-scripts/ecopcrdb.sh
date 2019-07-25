###############################################################################
## generate ecopcr database

###############################################################################


## load global variables
source ./01-infos/config.sh

## convert EMBL database into ecopcrdb
obiconvert --skip-on-error --embl -t $TAXD --ecopcrdb-output=$ECOPCRDAT $EMBLDAT mullus.embl.id.dat

## in silico PCR testing primers F/R
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL1_F $MS_DL1_R > mullus_std_MS_DL1.ecopcr
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL2_F $MS_DL2_R > mullus_std_MS_DL2.ecopcr
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL3_F $MS_DL3_R > mullus_std_MS_DL3.ecopcr
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L 300 $MS_DL4_F $MS_DL4_R > mullus_std_MS_DL4.ecopcr

ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L 140 $MS_DL5_F $MS_DL5_R > mullus_std_MS_DL5.ecopcr
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L 257 $MS_DL6_F $MS_DL6_R > mullus_std_MS_DL6.ecopcr
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L 220 $MS_DL7_F $MS_DL7_R > mullus_std_MS_DL7.ecopcr

ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL9_F $MS_DL9_R > mullus_std_MS_DL9.ecopcr
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL10_F $MS_DL10_R > mullus_std_MS_DL10.ecopcr
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL11_F $MS_DL11_R > mullus_std_MS_DL11.ecopcr
ecoPCR -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL12_F $MS_DL12_R > mullus_std_MS_DL12.ecopcr



## in silico PCR testing 4 primers F/R
## 1
#ecoPCR -r $TELEOSTEI_TAXID -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL1_F $MS_DL1_R > pcr_MS_DL1.ecopcr
## 2
#ecoPCR -r $TELEOSTEI_TAXID -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL2_F $MS_DL2_R > pcr_MS_DL2.ecopcr
## 3
#ecoPCR -r $TELEOSTEI_TAXID -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL3_F $MS_DL3_R > pcr_MS_DL3.ecopcr
## 4
#ecoPCR -r $TELEOSTEI_TAXID -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L 300 $MS_DL4_F $MS_DL4_R > pcr_MS_DL4.ecopcr


## convert custom mullus EMBL int ocopcrdb
#obiconvert --skip-on-error --embl -t $TAXD -ecopcrdb-output=mullusEco mullus.embl.id.dat

## convert custom FASTA.taxid into ecopcrdb
#obiconvert --skip-on-error --embl -t $TAXD --ecopcrdb-output=$ECOPCRDAT $FASTAF
## convert EMBL .dat files into obiFASTA
#for DA in `ls $EMBLDAT`
#do
#	DAB=`basename $DA`
#	DAFA=${EMBLOBIFA}"/"${DAB/.dat/.fa} 
#	obiconvert --skip-on-error --embl -t $TAXD --fasta-output $DA > $DAFA
#done
## convert FASTA and obiFASTA into ecopcrdb
#obiconvert --skip-on-error --embl -t $TAXD --ecopcrdb-output=$ECOPCRDAT $FASTAF ${EMBLOBIFA}/*fa

