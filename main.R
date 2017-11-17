library(tercen)
library(dplyr)
library(reshape2)

(ctx = tercenCtx())  %>% 
  select(.ci, .ri, .y) %>% 
  reshape2::acast(.ci ~ .ri, value.var='.y', fun.aggregate=mean) %>%
  scale(scale=as.logical(ctx$op.value('scale')), 
         center=as.logical(ctx$op.value('center'))) %>%
  as_tibble() %>%
  ctx$addNamespace() %>%
  ctx$save()

