require(tidyverse)

#' explain_df
#'
#' Function to create an easy visualization to explain data frames...
#'
#' @param cond
#' @param type
#'
#' @return
#' @export
#'
#' @examples
explain_df <- function(cond,type){
  cond = enquo(cond)
  V = enquo(type)
  title = ifelse(quo_name(V)=="Row",
                 str_glue("data[ {quo_name(cond)} ,   ]\n\n"),
                 str_glue("data[ , {quo_name(cond)}]\n\n"))
  expand.grid(1:4,1:4) %>%
    transmute(Row=fct_rev(factor(Var1)),
              Col=factor(Var2),
              Var3 = ifelse(!!V %in% !!cond,"A",'B'),
    ) %>%
    ggplot(aes(Col,Row,fill=Var3)) +
    geom_tile(size=3,color="white") +
    scale_fill_manual(values=c("steelblue",'grey80')) +
    scale_x_discrete(position="top") +
    theme_minimal() +
    labs(x="Columns\n(Variables)\n",y="Rows\n(Unit of Analysis)\n",
         title=title) +
    theme(legend.position = "none",
          axis.title = element_text(size=16,family="serif",face="bold"),
          axis.text = element_text(size=14,family="serif",face="bold"),
          plot.title = element_text(hjust=.5,size=20,family="serif",face="bold"))
}





#' explain_df2
#'
#' Function to create an easy visualization to explain data frames...
#' This function manages cell calls
#'
#' @return
#' @export
#'
#' @examples
explain_df2 <- function(cond1,cond2){
  cond1 = enquo(cond1)
  cond2 = enquo(cond2)
  title = str_glue("data[ {quo_name(cond1)} , {quo_name(cond2)} ]\n\n")
  expand.grid(1:4,1:4) %>%
    transmute(Row=fct_rev(factor(Var1)),
              Col=factor(Var2),
              Var3 = ifelse(Row %in% !!cond1 & Col %in% !!cond2,"A",'B'),
    ) %>%
    ggplot(aes(Col,Row,fill=Var3)) +
    geom_tile(size=3,color="white") +
    scale_fill_manual(values=c("steelblue",'grey80')) +
    scale_x_discrete(position="top") +
    theme_minimal() +
    labs(x="Columns\n(Variables)\n",y="Rows\n(Unit of Analysis)\n",
         title=title) +
    theme(legend.position = "none",
          axis.title = element_text(size=16,family="serif",face="bold"),
          axis.text = element_text(size=14,family="serif",face="bold"),
          plot.title = element_text(hjust=.5,size=20,family="serif",face="bold"))
}

