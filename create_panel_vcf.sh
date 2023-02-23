#!/bin/bash
set -x

reference_prefix='./hprc-jun1-mc-chm13'

echo "popping bubbles"
vcfbub -l 0 -r 100000 --input ${reference_prefix}.vcf.gz | bcftools view --samples ^GRCh38 --min-ac 1 -O z - > ${reference_prefix}.popped.vcf.gz
tabix -p vcf ${reference_prefix}.popped.vcf.gz

echo "filtering"
zcat ${reference_prefix}.popped.vcf.gz | ./filter-vcf.py 70 57 27 --chromosomes CHM13v2.chr{1..22} CHM13v2.chrX CHM13v2.chrY CHM13v2.chrMT \
2> ${reference_prefix}.filtered.pangenie_panel_creation.log 1> ${reference_prefix}.filtered.vcf

echo "trimming"
bcftools view --trim-alt-alleles ${reference_prefix}.filtered.vcf > ${reference_prefix}.filtered.trimmed.vcf

echo "annotating"
./annotate_vcf.py -vcf ${reference_prefix}.filtered.trimmed.vcf -gfa ${reference_prefix}.gfa -o ${reference_prefix}_filtered_ids-tmp &> ${reference_prefix}_filtered_ids.log

echo "sorting"
cat ${reference_prefix}_filtered_ids-tmp.vcf | awk """\$1 ~ /^#/ {{print \$0;next}} {{print \$0 | \"sort -k1,1 -k2,2n\"}}""" | bcftools view --min-ac 1 - > ${reference_prefix}_filtered_ids.vcf
cat ${reference_prefix}_filtered_ids-tmp_biallelic.vcf | awk """\$1 ~ /^#/ {{print \$0;next}} {{print \$0 | \"sort -k1,1 -k2,2n\"}}""" | bcftools view --min-ac 1 - > ${reference_prefix}_filtered_ids_biallelic.vcf

echo "compressing"
bcftools view ${reference_prefix}_filtered_ids.vcf --threads 10 -O b > ${reference_prefix}.pangenie_panel.bcf.gz && bcftools index --threads 10 ${reference_prefix}.pangenie_panel.bcf.gz && \\
bcftools view ${reference_prefix}_filtered_ids_biallelic.vcf --threads 10 -O b > ${reference_prefix}.pangenie_panel_biallelic.bcf.gz && bcftools index --threads 10 ${reference_prefix}.pangenie_panel_biallelic.bcf.gz



