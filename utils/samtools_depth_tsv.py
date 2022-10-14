#!/usr/bin/env python3

import argparse
from glob import glob
import subprocess 
from subprocess import Popen, PIPE

parser = argparse.ArgumentParser(description='Input BAM files for samtools depth, to be output as a tsv file')
parser.add_argument('-i', '--infiles', nargs = '+', help = 'BAM files for samtools', required = True, dest = 'infiles')
args = parser.parse_args()



def run_samtools(files):

	for file in files:

		overall = 0
		cov_10 = 0

		sample_name = file.split('-')[0]
		ref_name = file.split('REF_')[1].split(':')[0]
		print(f"{sample_name}\t{file}")
		command = (f"samtools depth -a {file}")
		output = Popen(['bash', '-c', command], stdout=PIPE)
			
		for line in output.stdout:

			overall += 1
			line = line.decode('utf8')
			coverage = line.split('\t')[2]
			
			if coverage >= 10:
				cov_10 += 1 
			
			print(f'{sample_name}\t{ref_name}\t{coverage}')
			C10 = cov_10 / overall
			print(f'{sample_name}\t{ref_name}\t{C10}')  

def main():
	infiles = args.infiles
	run_samtools(infiles)


if __name__ == "__main__":
	main()