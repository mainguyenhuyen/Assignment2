#!/usr/bin/env nextflow

params.cutoff = 50

process filterlength {
  input:
    path inputFile
    val cutoff
  output:
    path 'output.txt'
  script:
  """
    #!/usr/bin/env python3
    from Bio import SeqIO
    record = list(SeqIO.parse('$inputFile', 'fasta'))
    with open('output.txt', 'w') as file:
      for i in record:
        if len(i.seq) > $cutoff:
            SeqIO.write(i, file, "fasta")
  """
}

workflow {
 inputFile = Channel.fromPath(params.input)
 filteredData = filterExp(inputFile, params.cutoff)
}