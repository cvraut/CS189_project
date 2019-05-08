import re
import argparse
import sys
import os

parser = argparse.ArgumentParser(description="reads in a fasta file through stdin & prints out the contig headers to stdout")
args = parser.parse_args()

for line in sys.stdin:
    if line.startswith(">"):
        print(line.strip())