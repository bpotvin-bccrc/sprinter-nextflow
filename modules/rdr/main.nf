process RUNRDRESTIMATOR {
    time '24h'
    cpus 20
    memory '8 GB'
    label 'process_high'

    input:
    path reference_genome
    path reference_genome_fai
    path reference_genome_dict
    path normal_bam
    path normal_bam_bai
    path tumor_bam
    path tumor_bam_bai
    val chromosomes
    val rdr_binsize
    val rdr_minreads

    output:
    path "rdr.tsv", emit: rdr

    script:
    """
    runrdr \
        -r "${reference_genome}" \
        -t "${tumor_bam}" \
        -j ${task.cpus} \
        -m ${rdr_minreads} \
        -b ${rdr_binsize} \
        -c "${chromosomes}" \
        --samtools /opt/conda/envs/rdr_py27/bin/samtools \
        -n "${normal_bam}" > rdr.tsv

    """
}
