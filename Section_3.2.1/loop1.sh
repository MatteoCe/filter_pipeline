#!/bin/bash

set -ue pipefail

(

for i in $(cat ../filenames)

do

mkdir fastqc/${i}

echo "FastQC on ${i}"
fastqc ../raw/${i}_R1.fastq ../raw/${i}_R2.fastq -outdir fastqc/${i}/ -d temp/ -q

mkdir merging/${i}
mkdir merging/${i}/not_merged

echo "Vsearch mergepairs ${i}"
vsearch --fastq_mergepairs ../raw/${i}_R1.fastq --reverse ../raw/${i}_R2.fastq --fastq_maxns 0 --fastq_maxdiffs 3 --fastqout_notmerged_fwd merging/${i}/not_merged/${i}_R1_notmerged.fastq --fastqout_notmerged_rev merging/${i}/not_merged/${i}_R2_notmerged.fastq --fastqout merging/${i}/${i}_merged.fastq --log merging/${i}/${i}_merge.log

mkdir cutadapt/${i}
mkdir cutadapt/${i}/untrimmed

echo "Cutadapt trimming adapter ${i}"
cutadapt -a ^CGGTAAYTCCAGCTCYV...AYTTRAAGDAATTGACGG$ -o cutadapt/${i}/${i}_merged_adapt.fastq merging/${i}/${i}_merged.fastq --untrimmed-output cutadapt/${i}/untrimmed/${i}_merge_noadapt.fastq > cutadapt/${i}/${i}_report.txt

echo "Vsearch relabel with ${i}.#"
vsearch --fastq_filter cutadapt/${i}/${i}_merged_adapt.fastq --relabel ${i}. --fastqout fastq_prefilter/${i}.fastq

done

) 2>&1 | tee log/output_loop.log
