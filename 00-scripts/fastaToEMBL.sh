## convert sequence fasta into embl
seqret -sequence 02-raw/mullus.taxid.fa -osformat embl -outseq mullus.taxid.dat
## remove empty line
sed -i 's/XX//g' mullus.taxid.dat
## add embl header
sed "s/DE   surmuletus (.*) taxid=87757\;/$(sed -e 's/[\&/]/\\&/g' -e 's/$/\\n/' 01-infos/header_dat | tr -d '\n')/" mullus.taxid.dat > mullus.embl.dat
## remove useless ID lines
grep -v "ID   Mullus; SV 1; linear; unassigned DNA; STD; UNC; 800 BP." mullus.embl.dat > mullus.embl.id.dat
## attribute ID to each sequence
grep DE mullus.taxid.dat | while read ligne;
do
	ID=`echo $ligne | cut -d "(" -f 2 | cut -d ")" -f 1 | sed 's/ //g'`
	sed -i "0,/INTRAPOPMUL1/s//INTRAPOPMUL$ID/g" mullus.embl.id.dat
	## twice
	sed -i "0,/INTRAPOPMUL1/s//INTRAPOPMUL$ID/g" mullus.embl.id.dat
done

## remove empty lines
grep -v "^$" mullus.embl.id.dat > tmpdat
mv tmpdat mullus.embl.id.dat
