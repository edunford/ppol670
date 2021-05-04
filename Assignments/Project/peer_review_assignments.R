#'  **Peer-View Assignments for Presentations**
#' Students will review each others work; the following
#' allocates students at random into pairings where each student
#' reviews at least 5 other students work.

require(tidyverse)


# Student Data ------------------------------------------------------------

  # Student data (drawn in from Canvas using datapasta)
  # datapasta::tribble_paste()
  studat <- tibble::tribble(
    ~ student,
    "Hye-lim An",
    "Jess Belledonne",
    "Lucia Carrillo",
    "Pedro Casas Alatriste",
    "Zhaocheng Gu",
    "Andrea Lau",
    "Nathaniel Millard",
    "Youn Park",
    "Emily Pelles",
    "Xiyue Yang",
    "Xilin Yao",
    "Bongheum Yeon",
    "Izzy Youngs",
  )



# Random allocation -------------------------------------------------------

  # set.seed(20201203)
  set.seed(123)
  allocations <-
    crossing(studat  %>% select(A = student),
             studat %>% select(B = student)) %>%
    filter(A != B) %>%
    group_by(A) %>%
    sample_n(5) %>%
    rename(student = A, peer_to_review = B) %>%
    ungroup()



# Clean for uneven assignment distribution -------------------------------------------------------------------

  # Check the number of times the student is reviewed (make sure no student is
  # excluded or will recieve very few views), if so clean the data.

  # REALLOCATIONS
  on = T
  while(on){
    # Calculate the distribution of comments each student will receive
    fairness_dist <-
      allocations %>%
      count(peer_to_review) %>%
      arrange(n)

    # If everyone has at least 5 allocations, quit
    if(max(fairness_dist$n)<=5){
      on = F
      next()
    }

    # find the student with the lowest and highest number of allocations
    low = fairness_dist %>% filter(n == min(n)) %>% sample_n(1) %>% pluck('peer_to_review')
    over = fairness_dist %>% filter(n == max(n)) %>% sample_n(1) %>% pluck('peer_to_review')

    # randomly swap one allocation from the highest to the lowest
    swap = T
    while(swap){
      n = nrow(allocations[allocations$peer_to_review == over,])
      loc = sample(1:n,1)
      review_stu = allocations$student[(allocations$peer_to_review == over)][loc]

      # Check if the placement is already in the students quue
      in_queue = low %in% allocations$peer_to_review[allocations$student==review_stu]

      # Only allocate if the student isn't assigned to themselves
      if(low != review_stu & !in_queue){
        allocations$peer_to_review[(allocations$peer_to_review == over)][loc] = low
        swap = F
      }
    }
  }


# Tests -------------------------------------------------------------------


  # Final check
  fairness_dist <-
    allocations %>%
    count(peer_to_review) %>%
    arrange(n)

  # Look at dist eyeball to ensure it is even
  fairness_dist

  # Check if assigned to self
  allocations %>% summarize(assigned_to_self = sum(student == peer_to_review))

  # Check for expansions
  nrow(studat)*5 == nrow(allocations)

  # Check does a name appear twice in a students queue?
  allocations %>%
    group_by(student) %>%
    count(peer_to_review) %>%
    filter(n>1) %>%
    {nrow(.) == 0}



# Export Assignments ------------------------------------------------------

  allocations %>% stargazer::stargazer(type="text",summary = F,rownames = F)

  allocations$student %>%
    unique %>%
    paste0(.,collapse="\n") %>% cat
