###############################################################################
## primer design

###############################################################################


## load global variables
source ./01-infos/config.sh

ecoPrimers -d $ECOPCRDAT -e 3 -l 50 -L 150 -r 87757 -3 2 > mullus01.ecoprimers
