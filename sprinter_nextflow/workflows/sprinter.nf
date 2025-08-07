nextflow.enable.dsl=2
include { RUNRDRESTIMATOR as RUNRDRESTIMATOR } from '../modules/rdr'
include { POSTPROCESS_RDR as POSTPROCESS_RDR } from '../modules/post_rdr'

////////////////////////////////////////////////////
/* --          VALIDATE INPUTS                 -- */
////////////////////////////////////////////////////

def assert_required_param(param, param_name){
    if(! param){
        exit 1, param_name +' not specified. Please provide --${param_name} <value> !'
    }
}
assert_required_param(params.reference_genome, 'reference_genome') //e.g. gsc_hg19a.fa
assert_required_param(params.reference_genome_dict, 'reference_genome_dict') //e.g. gsc_hg19a.dict
assert_required_param(params.bam, 'bam') //e.g. AT31022_reference_cells.bam
assert_required_param(params.bam_bai, 'bam_bai') //e.g. AT31022_reference_cells.bam.bai
assert_required_param(params.chromosomes, 'chromosomes') //e.g. "1 2 3 4 5 6 7 8 9 10 11"
assert_required_param(params.rdr_binsize, 'rdr_binsize') //e.g. 50000
assert_required_param(params.rdr_minreads, 'rdr_minreads') //e.g. 100000


reference_genome = file(params.reference_genome)
reference_genome_dict = file(params.reference_genome_dict)
bam = file(params.bam)
bam_bai = file(params.bam_bai)
chromosomes = params.chromosomes
rdr_binsize = params.rdr_binsize
rdr_minreads = params.rdr_minreads


workflow SPRINTER_PIPELINE{

    main:


    rdr_output = RUNRDRESTIMATOR(
        reference_genome,
        reference_genome_dict,
        bam,
        bam_bai,
        chromosomes,
        rdr_binsize,
        rdr_minreads
    )

    postrdr_output = POSTPROCESS_RDR(rdr_output.rdr)

    // postrdr_output.chrrdr ("chr_sprinter.input.tsv.gz") 
}
