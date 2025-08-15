process GOSPRINTER {
    time '24h'
    cpus 20
    memory '100 GB'
    label 'process_high'

    input:
    path chr_input
    path chr_reference_genome
    path chr_reference_genome_fa
    val sprinter_rtreads
    val sprinter_minreads
    val sprinter_cnreads
    val sprinter_mincells
    val sprinter_propsphase

    output:
    path "sprinter_results/*"

    script:
    """

    mkdir -p sprinter_results
    cd sprinter_results

    conda run -n sprinter sprinter "../${chr_input}" \
        --refgenome "../${chr_reference_genome}" \
        --rtreads ${sprinter_rtreads} \
        --minreads ${sprinter_minreads} \
        --cnreads ${sprinter_cnreads} \
        --minnumcells ${sprinter_mincells} \
        --propsphase ${sprinter_propsphase} \
        -j ${task.cpus}
    """
}