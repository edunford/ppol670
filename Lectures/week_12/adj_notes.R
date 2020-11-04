# Notes for the variable importance lecture.

require(tidyverse)
require(recipes)
require(rsample)
require(caret)


# What is "importance" mean?

# Outline the concept of permutation: breaking the tie between predictor and outcome

# Show variable importance (using healthcare outcome or toy example where we know the effect)

set.seed(1234)
N = 1000
age <- round(runif(N,18,75))/100
political_therm <- round(runif(N,0,1),2)
visited_europe <- rbinom(N,1,.3)
eat_bread <- rbinom(N,1,.7)
z = -2+ 2*political_therm + 1.5*age + -.1*age^2 + 3*political_therm*age + -.01*visited_europe
pr <- pnorm(z)
hist(pr)
voted <- c("Yes","No")[rbinom(N,1,pr)+1]
table(voted)
vote_data <- tibble(voted,age,political_therm,visited_europe,eat_bread)
vote_data


cc = rpart::rpart(voted ~ .,data = vote_data,
                        control = rpart::rpart.control(maxdepth = 3))
rpart::rsq.rpart(cc)






set.seed(1988)
folds <- createFolds(vote_data$voted, k = 5)
control_conditions <-
  trainControl(method='cv',
               summaryFunction = twoClassSummary,
               classProbs = TRUE,
               index = folds )

rf_model <-
  train(voted ~ .,
        data=vote_data,
        method = "ranger", metric = "ROC",
        trControl = control_conditions)
# probs <- predict(svm_model,vote_data,type = "prob")
# Metrics::auc(vote_data$voted=="Yes",probs$Yes)

pred <- predict(rf_model,vote_data)
Metrics::accuracy(vote_data$voted,pred)



# Surrage models
y_preds <- predict(rf_model,vote_data,type = "prob")$Yes
vote_data2 <- vote_data %>%
  mutate(y_preds=y_preds) %>%
  select(-voted)

# Plot the predictions
vote_data2 %>%
  ggplot(aes(y_preds)) +
  geom_histogram()

lin_mod = lm(y_preds ~ . ,data=vote_data2)
summary(lin_mod)
summary()

cart_surrogate <-
  train(y_preds ~ . ,
        data=vote_data2,
        method = "rpart", # Decision Tree
        metric = "Rsquared",
        tuneGrid = data.frame(cp = c(.005,.01,.02,.05,.1,.2)),
        trControl = trainControl(method='cv',number = 5))

cart_surrogate = rpart::rpart(y_preds ~ .,data = vote_data2,
                        control = rpart::rpart.control(maxdepth = 3))

y_hat <- predict(cart_surrogate)
y <- vote_data2$y_preds
MSS = sum((y_hat-mean(y))^2)
TSS = sum((y-mean(y))^2)
R2 = MSS/TSS
R2


cart_sur$control$maxdepth
Metrics::mae(vote_data2$y_preds,predict(cart_sur,vote_data2))

rattle::fancyRpartPlot(cart_sur,type = 1)

cart_sur

# install.packages("iml")

mod <- iml::Predictor$new(rf_model, data = vote_data, type = "prob")
dt <- iml::TreeSurrogate$new(mod, maxdepth = 3)

plot(dt)
plot(dt$tree)


interact <- iml::Interaction$new(mod,feature="age")
plot(interact)

imp <- FeatureImp$new(mod, loss = "ce")
plot(imp)
# Importance vs Relationship: importance tells us what matters but doesn't tell
# us how a variable is related to an outcome.

# Introduce a partial dependency: manipulate one variable, holding the other
# variables at their observed values. Looking at the change in one variable
# holding all else constant.

# Introduce ICE curve: PDP useful to get average effects, but can miss
# heterogeneity in the across observations. ICE plots the marginal effect for
# each observation in the data. We can use it to identify potential interactions
# and heterogeneity. (show the x effect)

# Talk about plotting interactions between variables.

# Talk about Anchors (???)


