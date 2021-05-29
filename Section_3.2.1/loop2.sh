#!/bin/bash

set -ue pipefail

for i in $(cat ../filenames)

do

unzip -qq fastqc/${i}/${i}_R1_fastqc.zip -d fastqc/${i}/
unzip -qq fastqc/${i}/${i}_R2_fastqc.zip -d fastqc/${i}/

mv fastqc/${i}/${i}_R1_fastqc/Images/per_base_quality.png fastqc/${i}/${i}_R1_fastqc/Images/per_base_quality_${i}_R1.png
mv fastqc/${i}/${i}_R2_fastqc/Images/per_base_quality.png fastqc/${i}/${i}_R2_fastqc/Images/per_base_quality_${i}_R2.png

xdg-open fastqc/${i}/${i}_R1_fastqc/Images/per_base_quality_${i}_R1.png
xdg-open fastqc/${i}/${i}_R2_fastqc/Images/per_base_quality_${i}_R2.png

echo 'Stats for '${i}''

echo
sed -n '/^Vsearch mergepairs '${i}'$/,/^Cutadapt trimming adapter '${i}'$/p' log/output_loop.log | sed -n '/^Merging reads/,/^$/p' | tail -n +2

echo "The three most recurring issues during merging with number of not merged seqs"

echo
sed -n '/^Vsearch mergepairs '${i}'$/,/^Cutadapt trimming adapter '${i}'$/p' log/output_loop.log | sed -n '/^Pairs that failed/,/^$/p' | tail -n +2 | sort -r | head -n 3

echo "Cutadapt stats"

echo
sed -n '/^Total reads processed:/,/^$/p' cutadapt/${i}/${i}_report.txt

read -p ""

rm -rf fastqc/${i}/${i}_R[1,2]_fastqc

done
