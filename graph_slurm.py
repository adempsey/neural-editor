
import numpy as np
import matplotlib.pyplot as plt
import os
import seaborn as sns
import re

# set path to where .txt output is stored
print "The current working directory is", os.getcwd()

dataset = ['one_billion', 'yelp']
for d in dataset:
	# specify txt directory
	METRICS_PATH = os.getcwd() + '/' + d + '.txt'


	# open and clean data
	with open(METRICS_PATH, 'r') as file:
		loss, bleu, gleu, ribes, chrf = [], [], [], [], []
		for line in file:
			line = line.replace(' ', '').split(",") # parse line
			line = [float(re.sub('[^0-9^.]','', item)) for item in line] # convert item to float
			loss.append(line[0])
			bleu.append(line[1])
			gleu.append(line[2])
			ribes.append(line[3])
			chrf.append(line[4])

	# use seaborn to do regression plot
	def seabornPlot(metric, name, title, data):
		ax1 = sns.regplot(x=x, y=np.asarray(metric), fit_reg=True, order=1)
		ax1.set_title(data)
		plt.suptitle(title)
		plt.savefig(str(name)+'_'+str(data))
		plt.clf()

	x = np.asarray(range(0, len(loss))) # seaborn takes np.arrays

	seabornPlot(loss, "loss",  "loss", d)
	seabornPlot(bleu, "bleu", "Bilingual Evaluation Understudy (BLEU)", d) #  how similar candidate to reference between 0.0 and 1.0
	seabornPlot(gleu, "gleu", "Google-BLEU (GLEU)", d) # 0 (no matches) and 1 (all match)
	seabornPlot(ribes, "ribes", "Rank-based Intuitive Bilingual Evaluation Score (RIBES)", d) # between 0.0 and 1.0
	seabornPlot(chrf, "chrf", "Character n-gram F-score (ChrF)", d)
