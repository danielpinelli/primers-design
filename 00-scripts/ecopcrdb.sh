###############################################################################
## generate ecopcr database

###############################################################################


## load global variables
source ./01-infos/config.sh

## convert EMBL database into ecopcrdb
#obiconvert --skip-on-error --embl -t $TAXD --ecopcrdb-output=$ECOPCRDAT $EMBLDAT mullus.embl.id.dat
## convert custom mullus EMBL int ocopcrdb
#obiconvert --skip-on-error --embl -t $TAXD -ecopcrdb-output=mullusEco mullus.embl.id.dat
ecoPCR -r $TELEOSTEI_TAXID -d mullus_pcr -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL1_F $MS_DL1_R > mullus_MS_DL1.ecopcr
ecoPCR -r $TELEOSTEI_TAXID -d mullus_pcr -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL2_F $MS_DL2_R > mullus_MS_DL2.ecopcr
ecoPCR -r $TELEOSTEI_TAXID -d mullus_pcr -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL3_F $MS_DL3_R > mullus_MS_DL3.ecopcr
ecoPCR -r $TELEOSTEI_TAXID -d mullus_pcr -e $ecoPCR_e -l $ecoPCR_l -L 300 $MS_DL4_F $MS_DL4_R > mullus_MS_DL4.ecopcr



## in silico PCR testing 4 primers F/R
## 1
ecoPCR -r $TELEOSTEI_TAXID -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL1_F $MS_DL1_R > pcr_MS_DL1.ecopcr
## 2
ecoPCR -r $TELEOSTEI_TAXID -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL2_F $MS_DL2_R > pcr_MS_DL2.ecopcr
## 3
ecoPCR -r $TELEOSTEI_TAXID -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L $ecoPCR_L $MS_DL3_F $MS_DL3_R > pcr_MS_DL3.ecopcr
## 4
ecoPCR -r $TELEOSTEI_TAXID -d $ECOPCRDAT -e $ecoPCR_e -l $ecoPCR_l -L 300 $MS_DL4_F $MS_DL4_R > pcr_MS_DL4.ecopcr


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

