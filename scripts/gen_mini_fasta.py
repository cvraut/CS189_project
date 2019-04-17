from __future__ import print_function
import argparse
import sys
import os

parser = argparse.ArgumentParser(description="print first c contigs of fasta file fed through stdin")
parser.add_argument("-c","--contigs",help="# of contigs from fasta file to include",type=int,default=10)
args = parser.parse_args()

c = args.contigs
for line in sys.stdin:
    name,file_name = line.split()
    dest_dir = './'+'/'.join(file_name.split('/')[:-1]) + "/smol/"
    if not os.path.exists(dest_dir):
        os.makedirs(dest_dir)
    
    mini_fasta = open(dest_dir+file_name.split('/')[-1],"w+")
    fasta = open('.'+file_name)
    contig_cnt = 0
    for l in fasta:
        if l.startswith('>'):
            if contig_cnt < c:
                contig_cnt+=1
            else:
                break
        mini_fasta.write(l)
    mini_fasta.close()
    fasta.close()
    print("done with {}".format(file_name))