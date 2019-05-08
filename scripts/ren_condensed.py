import re
import argparse
import sys
import os

parser = argparse.ArgumentParser(description="This program goes through the original fasta files and renames their contigs to be shorter so the synteny visualizations come out better")
args = parser.parse_args()

og_fastas = ["./data/originals/suvarum_cbs7001.fasta",
             "./data/originals/S288C_reference.fasta",
             "./data/originals/W303_reference.fasta",
             "./data/originals/SK1_reference.fasta",
             "./data/originals/g833-1B_reference.fasta"]
out_fastas = ["./data/suvarum_cbs7001.fasta",
             "./data/S288C_reference.fasta",
             "./data/W303_reference.fasta",
             "./data/SK1_reference.fasta",
             "./data/g833-1B_reference.fasta"]

def ren_desc(case):
    in_fasta = open(og_fastas[case])
    out_fasta = open(out_fastas[case],"w")
    
    buff = ""
    for line in in_fasta:
        if line.startswith('>'):
            if len("".join(buff.split()[1:])) >= 1000:
                out_fasta.write(buff)
            buff = ""
            if case == 0:
                patt = r'\[(\w+); (\d+)bp]'
                s = re.search(patt,line)
                line = '>CBS7001_{}\n'.format(s.group(1))
            elif case == 1:
                patt = r'(chromosome|location)=(\w{0,4})'
                line = '>S288C_chr_{}\n'.format(re.search(patt,line).group(2))
            elif case == 2:
                patt = r'scf7180000000(\d+)\|quiver'
                line = '>W303_scf_{}\n'.format(re.search(patt,line).group(1))
            elif case == 3:
                patt = r'NCSL01000(\d+)'
                line = '>SK1_scaf_{}\n'.format(re.search(patt,line).group(1))
            elif case == 4:
                patt = r'g833-1B (\w{4})\w+-(\d+),'
                s = re.search(patt,line)
                line = '>g833_1B_{}_{}\n'.format(s.group(1),s.group(2))
        buff+=line
    if len("".join(buff.split()[1:])) >= 1000:
        out_fasta.write(buff)
    in_fasta.close()
    out_fasta.close()

for i in range(len(og_fastas)):
    ren_desc(i)
print("all done!")
    
    