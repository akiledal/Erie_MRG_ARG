import os 
import re
from glob import glob

rule map_reads_to_database:
    input:
        f_reads="data/metagenomic_reads/{sample}_fwd.fastq.gz",
        r_reads="data/metagenomic_reads/{sample}_rev.fastq.gz",
        ref="data/metalresistancegenes.fasta"
    output:
        temp_bam=temp("data/gene_mapping/{sample}_mapped_temp.bam"),
        sam=temp("data/gene_mapping/{sample}_mapped.sam"),
        unsorted_bam=temp("data/gene_mapping/{sample}_mapped_unsorted.bam"),
        bam="data/gene_mapping/{sample}_mapped.bam"
    conda: "config/conda/minimap2.yaml"
    resources: cpus=16
    shell: 
        """
        minimap2 \
            -ax sr \
            -t {resources.cpus} \
            --sam-hit-only \
            --secondary=no \
            {input.ref} \
            {input.f_reads} {input.r_reads} > {output.sam} 

        samtools view -bS {output.sam} > {output.temp_bam} 

        filterBam \
            --in {output.temp_bam} \
            --out {output.unsorted_bam} \
            --minCover 50 \
            --minId 80 \

        samtools sort -o {output.bam} -@ {resources.cpus} {output.unsorted_bam}
        samtools index -@ {resources.cpus} {output.bam}
        """

rule run_read_mapping:
    input:expand("data/gene_mapping/{sample}_mapped.bam", sample=glob_wildcards("data/metagenomic_reads/{sample}_fwd.fastq.gz").sample)

