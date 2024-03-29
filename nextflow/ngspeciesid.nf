#!/usr/bin/env nextflow

def helpMessage() {
    log.info"""
    ============================================================================
     :  Git version: ${version}
    ============================================================================
    Usage:
       Mandatory arguments:
           --fastq          FASTQ files to be Assembled
           --out_dir        Output Directory (for things that aren't intermediate files to keep)
       Optional arguments:
           --size           Size of Genome being Assembled
           --run_dir        Directory for Canu to run in 
           
    """.stripIndent()
}

def proc_git = "git -C $baseDir rev-parse HEAD".execute()
version = proc_git.text.trim()

params.help = false
if (params.help){
    println(params)
    helpMessage()
    exit 0
}

fastq_files = Channel.fromPath(params."fastq")
				   .map {it -> [it.simpleName, it]}



process ngspeciesid {

    container 'liamtkane/ngspeciesid'

    memory '30 G'
    
    cpus 8

    publishDir "${params."out_dir"}/NGSpeciesID/", mode: 'copy', overwrite: true, pattern: "*/*"

    input:
    set val(sample_id), file(fastq) from fastq_files

    output:
    file ("$sample_id/*") optional true into output

    script:

    """
    NGSpeciesID --ont --sample_size 300 --m 750 --s 50 --consensus --medaka --fastq ${fastq} --outfolder ${params."out_dir"}
    """
}
