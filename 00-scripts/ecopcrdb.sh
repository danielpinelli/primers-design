###############################################################################
## generate ecopcr database

###############################################################################


## load global variables
source ./01-infos/config.sh

## convert EMBL database into ecopcrdb
#obiconvert --skip-on-error --embl -t $TAXD --ecopcrdb-output=$ECOPCRDAT $EMBLDAT
## convert custom FASTA.taxid into ecopcrdb
obiconvert --skip-on-error --embl -t $TAXD --ecopcrdb-output=$ECOPCRDAT $FASTAF
## convert EMBL .dat files into obiFASTA
for DA in `ls $EMBLDAT`
do
	DAB=`basename $DA`
	DAFA=${EMBLOBIFA}"/"${DAB/.dat/.fa} 
	obiconvert --skip-on-error --embl -t $TAXD --fasta-output $DA > $DAFA
done
## convert FASTA and obiFASTA into ecopcrdb
obiconvert --skip-on-error --embl -t $TAXD --ecopcrdb-output=$ECOPCRDAT $FASTAF ${EMBLOBIFA}/*fa

