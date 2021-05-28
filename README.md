# Scripts and pipelines from Cecchetto et al. 2021 - Plankton metabarcoding using desalination plant filters


Here are deposited the scripts and pipelines described in Cecchetto et al. 2021 "A metabarcoding protocol to analyze coastal planktic communities collected by desalination plant filters: from sampling to basic exploratory analyses." 

## Summary/Abstract

The temporal dynamics of coastal planktic communities can be disclosed through DNA metabarcoding on the filters of reverse-osmosis desalination plants. Here we describe the steps that are necessary to process the filters in order to create the subsamples used for DNA extraction and the bioinformatic pipeline to perform the first exploratory analyses on this kind of dataset.

## Repository Structure

The repository is subdivided in two directories that reflect the subheadings of the publication and store different pipelines.

This pipeline is here reported in the following two subheadings and should be executed in that order. The first part (Section 3.2.1) consists in commands and small scripts that can be executed in a Unix environment with the installed programs listed in section 2.2.1 (Cecchetto et al. 2021) and will process the original Illumina sequences fastq files to create the abundance table and taxonomy file. The second part (Section 3.2.2) will be executed on these files and will perform the first exploratory analyses of this kind of samples.

The pipeline starts after the demultiplexing step, which is not here reported as many sequence services providers usually perform it before sending the results to the client. Nonetheless, if a demultiplexing process is required by the reader, we suggest to adopt the first steps of the tutorial pipeline reported by the obitools programs suite authors (and specifically the command ngsfilter, <https://pythonhosted.org/OBITools/wolves.html>). The reader should then rename each file according to the name chosen with the labelling strategy followed by and underscore and R1 or R2, for the forward and reverse reads respectively.
