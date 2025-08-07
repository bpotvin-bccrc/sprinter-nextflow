process RUNRDRESTIMATOR {
    time '24h'
    cpus 2
    memory '8 GB'
    label 'process_high'

    input:
    path reference_genome
    path reference_genome_dict
    path bam
    path bam_bai
    val chromosomes
    val rdr_binsize
    val rdr_minreads

    output:
    path "rdr.tsv", emit: rdr

    script:
    """
    runrdr \
        -r "${reference_genome}" \
        -t "${bam}" \
        -j ${task.cpus} \
        -m ${rdr_minreads} \
        -b ${rdr_binsize} \
        -c "${chromosomes}" \
        --samtools /opt/conda/envs/rdr_py27/bin/samtools \
        -n "${bam}" > rdr.tsv

    """
}
