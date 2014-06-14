#!/bin/bash

#this script totally depends on ntc ko slc-result page
#might broke in future 

#request url
SLC_URL="http://slc.ntc.net.np/slc2070_ledger.php"

#make temporary directory
mkdir -p results

while read i
do
	name="$(cut -d',' -f1 <<< $i)"
	symbol=$(cut -d',' -f2 <<< $i)
	dob=$(cut -d',' -f3 <<< $i)

	#download the result first
	#curl --data "symbol=0275509m&dob=2054-10-17&submit=Submit" http://slc.ntc.net.np/slc2070_ledger.php 
	curl --data "symbol=$symbol&dob=$dob&submit=Submit" $SLC_URL|sed -n "/table/,/table/ w results/$name.html"
	
	#process the result
done < slc.csv
