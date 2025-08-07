process POSTPROCESS_RDR {
    cpus 1
    memory '8 GB'
    label 'process_light'

    input:
    path rdr_tsv

    output:
    path "chr_sprinter.input.tsv.gz", emit: chrrdr

    script:
    """
    # Rename input for clarity
    mv ${rdr_tsv} sprinter.input.tsv

    # Compress the file
    gzip -f sprinter.input.tsv

    # Run R script to add chr
    Rscript /usr/local/bin/process_chr sprinter.input.tsv.gz
    """
}
