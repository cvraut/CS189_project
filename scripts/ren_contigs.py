import re
import argparse
import sys
import os

parser = argparse.ArgumentParser(description="renames the contig descriptors to adhere to cactus's naming conventions. It replaces any 'bad' character with an '_'.\n Reads file through stdin, sends changed file through stdout.")
args = parser.parse_args()

patt = r'[^\w_\-:.]+'
for line in sys.stdin:
    if line.startswith(">"):
        print(">"+"_".join(re.split(patt,line)).strip("_"))
    else:
        print(line,end='')