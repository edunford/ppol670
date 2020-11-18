#### Dealing with IMBALANCED DATA ####


# Example of imbalance
outcome = sample(c("yes","no"),size=1000,prob=c(.7,.3),replace = T)
table(outcome)


#' **Sample Weighting**
#'   - _Down Sampling_: randomly remove instances in the majority class
#'   - _Up Sampling_: randomly replicate instances in the minority class
#'   - _SMOTE Sampling_: (synthetic minority sampling technique) - down samples 
#'   the majority class and synthesizes new minority instances by interpolating 
#'   between existing ones
#'   - _ROSE Sampling_: (Random Over-Sampling Example) -- generates comparable bootstrapped
#'   samples from both classes.
#'   
#'   [Note:  "smote" &  "rose" require the `DMwR` and `ROSE` packages to run.]
#'   


# IMPLEMENTATION is easy with caret
control_conditions <- 
  trainControl(method='cv',
               summaryFunction = twoClassSummary, 
               classProbs = TRUE, 
               sampling = "up",  # HERE WE CAN CHANGE THE SAMPLING METHODS
               index = folds
  )


# Helpful reading
# https://dpmartin42.github.io/posts/r/imbalanced-classes-part-1