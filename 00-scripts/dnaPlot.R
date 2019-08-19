###############################################################################
## Representation of the results of in silico PCR tests
###############################################################################

## load global variables
source ./01-infos/config.sh

##PRIMERS MS-DL1##
## Loading data
mullus = read.ecopcr.result('mullus_std_MS_DL1.ecopcr')
taxo = read.taxonomy ('/root/bureau/WORKING/R/taxo/ncbi20150518')

## Identify the sequences belonging to the amplified species and not amplified species
is_a_mullus=is.subcladeof(taxo,mullus$taxid,37006)
is_a_fish=is.subcladeof(taxo,mullus$taxid,2759)
is_a_homo=is.subcladeof(taxo,mullus$taxid,9604)
is_a_bact=is.subcladeof(taxo,mullus$taxid,641)
is_a_fish1=is.subcladeof(taxo,mullus$taxid,8169)
group = rep('Other species',length(is_a_fish))
group[is_a_homo]='Homos sapiens'
group[is_a_mullus]='Mullus surmuletus'
group[is_a_bact]='Marine bacteria'
group[is_a_fish1]='Other marine fish'
group=as.factor(group)
table(group)

## Marine bacteria Mullus surmuletus Other marine fish     Other species
##        7                20                 1                15

## Plot mismatch
png(file = "Mismatch1.png")
par(mfcol=c(1,1))
mismatchplot(mullus,group =group, col=c('orange','red','white','dodgerblue'))
dev.off()

## Test the conservation of boot sites
Fish.forward = ecopcr.forward.shanon(ecopcr = mullus, group = is_a_mullus)
Fish.reverse = ecopcr.reverse.shanon(ecopcr = mullus, group = is_a_mullus)

## Plot the test of the sites conservation
png(file = "DL1.png")
par(mfcol=c(3,2))
dnalogoplot(Fish.forward$'TRUE',primer = "CATACGTATACTGATATA", main='Forward MS-DL1')
dnalogoplot(Fish.forward$'FALSE',primer = "CATACGTATACTGATATA", main='Forward no')
dnalogoplot(Fish.reverse$'TRUE',primer = "TAATAAATCGCTAGCGGT", main='Reverse MS-DL1')
dnalogoplot(Fish.reverse$'FALSE',primer = "TAATAAATCGCTAGCGGT",main='Reverse no')
dev.off()
