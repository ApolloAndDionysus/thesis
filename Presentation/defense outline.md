defense outline:

stick to: (1) what questions did I answer? (2) what are my answers, and how good are they? (3) why does this matter?

avoid complete explanations; we are not teaching a MAB class here. refer people to your paper for full details.

0. intro to problems
	- MAB intro:
		- you have a set of options you can learn about by testing them; repeated testing gives more accurate estimate of quality.
		- how can you find a high-quality item when you can't afford to thoroughly test every option?
		- budget used and quality of result are competing concerns. usually we fix one and optimize the other:
			1. fixed confidence: define "good," minimize budget
			2. fixed budget: define "budget," maximize "good"
		- two standard ways to measure algorithm success: cumulative regret (about the journey), simple regret (about the destination)
	- What I did: solved for fixed confidence and fixed budget, then did applications to dose finding and boosted decision tree training.
1. fixed confidence
	- map of talk
	- intro: how do we find a precisely-defined "good" arm while minimizing the budget used?
	- what is "good"? alpha, epsilon, delta
	- what is minimum possible budget?
	- diagram for LB
	- simple algorithm: sample and identify
	- how good is this algorithm? UB, compare to LB. so far every algorithm with no knowledge of reservoir has this gap.
	- show results
2. fixed budget
	- map of talk
	- intro: how do we minimize simple regret within a predetermined budget?
	- ISHA algorithm: surprise, we throw away stuff after one flip!
	- show results: fluidly adapts to explore/identify tradeoff
	- proof approach: under assumptions 1&2, reservoir (1) does not get worse, and (2) under extra condition does get better
	- simple regret bound (budget needed for regret target)
	- lower bound, comparison
3. dose finding
	- map of talk
	- setup: expert provides a few reasonable doses to try, but (1) not enough patients to estimate all accurately, (2) don't want to over-treat or under-treat patients. how to find best dose while treating as many trial patients as possible with best dosage?
	- before, # arms >> budget. now, #arms < budget but budget too small to test each arm thoroughly. also, unethical to test each arm thoroughly. we add assumptions about underlying structure.
	- structure assumptions: tox-only, tox + efficacy plateau
	- modify sequential halving, get a guarantee, but inefficient use of budget
	- Thompson sampling: can modify to consider our competing constraints
	- results: one great one, one ambiguous one to show competing constraints
4. AP boost
	- map of talk
	- setup: introduce greedy-optimal boosted decision trees. when the winner is much better than some other option, we want to prune that option cheaply.
		* standard method: test each hypothesis on all training docs
		* quick boost: score features on 90% of weight, sort, find best threshold for each feature in that order (pruning when you can't win), save best overall.
		* can use LUCB best arm identification to prune more aggressively.
	- algorithm
	- results: accuracy
	- results: gini
	- why quickboost sucks at gini	
5. conclusion/thanks


