# Repository for efforts to produce SV calls in T2T reference genome coordinates using Pangenie.

## VCF Pangenome file for Pangenie
[Pangenie](https://github.com/eblerjana/pangenie) is a software package written by [Jana Ebler](https://github.com/eblerjana) to genotype fastq files. Specifically, it uses a kmer based approach, it takes a reference pangenome (whose paths are represented as haplotypes in a vcf) and determines which of the vcf pangenome's variations are contained in your sample of interest.

This stub repository contains the scripts I used to generate a Pangenie-compatible vcf representation of the HPRC draft human pangenome. This work was performed in August 2022. To replicate, please clone this repository, ensure that vcfbub and bcftools are installed, and place the following files in the repository folder:

[June 2022 working draft pangenome in gfa format (MC-Cactus)](https://s3-us-west-2.amazonaws.com/human-pangenomics/pangenomes/scratch/2022_06_01_minigraph_cactus/hprc-jun1-mc-chm13-full.gfa.gz)
 - note: unzip this file using the command gzip -d hprc-jun1-mc-chm13-full.gfa.gz before running script

[June 2022 working draft pangenome in vcf format (MC-Cactus)](https://s3-us-west-2.amazonaws.com/human-pangenomics/pangenomes/scratch/2022_06_01_minigraph_cactus/hprc-jun1-mc-chm13.vcf.gz)  

[Draft pangenome vcf index](https://s3-us-west-2.amazonaws.com/human-pangenomics/pangenomes/scratch/2022_06_01_minigraph_cactus/hprc-jun1-mc-chm13.vcf.gz.tbi)

Then run:
```
chmod +x create_panel_vcf.sh
./create_panel_vcf.sh
```
