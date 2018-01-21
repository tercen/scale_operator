library(tercen)
library(dplyr)
 
do.scale = function(df, ...){
  
  scale.m = try(scale(as.matrix(df$.y), ...), silent = TRUE)
  
  if(inherits(scale.m, 'try-error')) {
    return (data.frame(.ri = integer(),
                       .ci = integer(),
                       scale=double()))
  }  
  
  result = as_tibble(scale.m) %>% 
  rename_all(.funs=function(x) 'scale') %>% 
  mutate(.ri = df$.ri, .ci = df$.ci)
  
  return (result)
}
 
(ctx = tercenCtx()) %>% 
  select(.ci, .ri, .y) %>% 
  group_by(.ci, .ri) %>% 
  summarise(.y = mean(.y)) %>%
  group_by(.ri) %>%
  do(do.scale(., scale=as.logical(ctx$op.value('scale')), 
              center=as.logical(ctx$op.value('center')))) %>%
  ctx$addNamespace() %>%
  ctx$save()

