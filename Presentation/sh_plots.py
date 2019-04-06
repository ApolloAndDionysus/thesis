#!/usr/bin/env python3

import argparse, gzip, json, numpy as np, matplotlib.pyplot as plt
from collections import defaultdict

def main():
	parser = argparse.ArgumentParser()
	parser.add_argument('--input', help='path to input data')
	parser.add_argument('--output', help='prefix of output path')
	args = parser.parse_args()

	with gzip.open(args.input, 'rt') as f:
		data = json.load(f)

	# Figure out the coins in each reservoir
	coins = defaultdict(list)
	for bias, flips, heads in data['algs']['sh']['data'][0]['flips']:
		coins[flips].append(bias)

	# Plot the reservoir for each number of flips
	for flips, biases in coins.items():
		biases = np.array(sorted(biases))
		xs = np.array(sorted({0, 1} | set(biases)))
		ys = np.array([np.sum(biases <= x) for x in xs]) / len(biases)

		plt.figure()
		plt.step(xs, ys, where='post', color='r', linestyle='--')
		plt.xticks([0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1.0])
		plt.yticks([0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1.0])
		plt.grid(which='major', axis='both')
		plt.xlabel('Coin Bias')
		plt.ylabel('Empirical CDF')
		plt.title('ISHA Round {}, {} coins left, best bias {:.2f}'.format(
			1 + int(np.log2(flips)), len(biases), np.max(biases)))
		plt.tight_layout()
		plt.savefig('{}_{}.pdf'.format(args.output, flips))
		plt.close()


if __name__ == '__main__':
	main()
