###############################################################################
## primer design

###############################################################################


## load global variables
source ./01-infos/config.sh

ecoPrimers -d $ECOPCRDAT -e 3 -l 50 -L 120 -r 87757 -3 2 > mullus01.ecoprimers

ecoPCR -d $ECOPCRDAT/mullos -e 3 -l 100 -L 130 CTGATATAGGACACGATA TAGCGGTCATCAGTTCTA > mysequences.ecopcr

