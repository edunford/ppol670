# Exploratory Data Analysis

**Assumption**: the data is new, the data generating process is not something you're familiar with (that is, you haven't gone to graduate school or read a lot about a certain topic) --- how do you go about exploring a data set.

## Layer 0: Train/Test Split

- Always split the data into a train/test dataset. 

## Layer 1: Distributions

- What types of data do you have?
- How is that data distributed?
- Is the data incomplete? 
- Why is the data incomplete? 
- Should the data be transformed?
- Are there ways to back out new variables from the variables you have? (feature engineering)

Surface level questions about the data as observed. 

## Layer 2: Relationships

- What is the relationship between the variables?
- What variables are highly correlated?
- What can bi-variate models tell us about the relationship between two variables?
- Does a decomposition reveal anything interesting about the variation in the data?
- Can we plot the data spatially or temporally? Do any interesting patterns emerge? 

## Layer 3: Unpacking an Outcome

- What outcome variable do you care about (or seems important) in the data? 
- Build a model that best predicts this outcome.
	- Use relevant features 
		- that is, features that appear to measure different concepts.
		- make sure all features are pre-processed
			- deal with missing, ordered, categorical entries
- Explore the most predictive model.
	- **Variable importance**: what features mattered most in the model. What features did the heavy lifting. 
		- _Go into the different ways feature importance can be calculated_
	- **Partial dependency**: what is the marginal effect of the predicted probability along specific values of the predictor?
		- Look at the relationship 
	- **ICE**: what is the marginal effect of the predicted probability along specific values of the predictor across each observation? 
		- Look for heterogeneity. Are there observations that appear to deviate in the relationship?
	- **Feature interactions**: explore the ways features potentially interact with one another. 

## Layer 4: Theorize

- We have a sense of what is driving the outcome. Let's now theorize. 
	- What confounders might be lurking (generating false correlations)?
	- What are some hypotheses that we might be able to generate from the data?
	- What are some plausible interventions that we might be able to employ to test a causal relationship?
		- Are those interventions ethical?
		- Are those interventions practical?
- Always write, record, and proceed in a reproducible way. 
- These types of data exploration are valid only in that we hold out and never look at the test data. The test data is where we can test our theory, once formulated. 
