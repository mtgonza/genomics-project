#!/bin/bash

# Pipeline script for single-sample genomic alignment
# Usage: bash run_pipeline.sh

# Exits if any command fails
set -e

# Variables for file names
REF="data/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa"
R1="data/1M_SRR9336468_1.fastq"
R2="data/1M_SRR9336468_2.fastq"
SAMPLE="1M_SRR9336468"

echo "Starting alignment pipeline for sample: ${SAMPLE}"

echo "Step 1: Indexing reference genome..."
bwa index $REF

echo "Step 2: Aligning reads to reference..."
bwa mem $REF $R1 $R2 > ${SAMPLE}.sam

echo "Step 3: Converting SAM to BAM..."
samtools view -S -b ${SAMPLE}.sam > ${SAMPLE}.bam 

echo "Step 4: Sorting BAM file..."
samtools sort ${SAMPLE}.bam -o ${SAMPLE}_sorted.bam

#echo "Step 5: Removing intermediate SAM file..."
#rm ${SAMPLE}.sam

echo "Pipeline complete! Final output: ${SAMPLE}_sorted.bam"
ls -lh ${SAMPLE}_sorted.bam
