

#' Question 1
#'
#' The following vector contains some country names. The following code seeks to
#' separate these country names into a `starts_with_A` group and `starts_with_B`
#' group. We'll use the first letter of each country name to figure out which
#' group the country should be member to. If it's not either group, store it as
#' `other`.
#'
#' Answer: E, C, D, B, A
some_countries <- c("Afghanistan", "Albania", "Algeria", "Angola",
                    "Argentina", "Australia", "Sierra Leone",
                    "Austria", "Bahrain", "Swaziland","Turkey",
                    "Bangladesh", "Belgium", "Benin", "Bolivia",
                    "Bosnia and Herzegovina", "Botswana", "Brazil",
                    "Bulgaria", "Burkina Faso", "Burundi","Zambia")
starts_with_A <- c()
starts_with_B <- c()
other         <- c()
for ( country in some_countries ){
  if(substr(country, start = 1, stop = 1) == "A"){
    starts_with_A <- c(starts_with_A,country)
  }else{
    if(substr(country, start = 1, stop =  1) == "B"){
      starts_with_B <- c(starts_with_B,country)
    }else{
      other <- c(other,country)
    }
  }
}



#' Question 2
#'
#' The following code uses the `sleep` dataset (which comes built into `R`). The
#' data records the effect of two soporific drugs (increase in hours of sleep
#' compared to control) on 10 patients in each group. The following code
#' calculates the average increased hours of sleep by group and stores it into a
#' new data frame called `group_ave`.
#'
#' ANSWER: C, D, E, A, B
dat <- sleep
group_ave <- data.frame(group=c(NA,NA),extra_sleep = c(NA,NA))
groups <- unique(dat$group)
for ( i in 1:length(groups) ){
 grab_these <- sleep$group == groups[i]
 ave <- mean(sleep[grab_these,"extra"])
 group_ave[i,1] = groups[i]
 group_ave[i,2] = ave
}



?sleep
