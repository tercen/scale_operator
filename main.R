library(tercen)
library(dplyr)
library(data.table)

do.scale = function(y, ci, ...){
  
  scale.m = try(scale(as.matrix(y), ...), silent = TRUE)
  
  
  if(inherits(scale.m, 'try-error')) {
    return (double())
  }  
  
  # browser()
  result <- data.frame("value"=scale.m, ".ci"=ci)
  
  # return (unlist(as.list(scale.m)))
  return (result)
}



ctx = tercenCtx()
df <- ctx$select(c(".ci", ".ri", ".y"))
dt <- data.table(df)
dt[ , .(.y = mean(.y)), by = c(".ci",".ri")]
outDf <- dt[ , c("value", ".ci") := do.scale(.y, .ci), by = c(".ri") ] %>% 
  select(-.y) %>%
  as.data.frame() %>%
  arrange(.ri, .ci) %>%
  relocate(.ri) %>%
  relocate(value) %>%
  ctx$addNamespace() %>%
  ctx$save()
# do.scale = function(df, ...){
#   
#   scale.m = try(scale(as.matrix(df$.y), ...), silent = TRUE)
#   
#   if(inherits(scale.m, 'try-error')) {
#     return (data.frame(.ri = integer(),
#                        .ci = integer(),
#                        scale=double()))
#   }  
#   
#   result = as_tibble(scale.m) %>% 
#   rename_all(.funs=function(x) 'scale') %>% 
#   mutate(.ri = df$.ri, .ci = df$.ci)
#   
#   return (result)
# }
#  
# (ctx = tercenCtx()) %>% 
#   select(.ci, .ri, .y) %>% 
#   group_by(.ci, .ri) %>% 
#   summarise(.y = mean(.y)) %>%
#   group_by(.ri) %>%
#   do(do.scale(., scale=as.logical(ctx$op.value('scale')), 
#               center=as.logical(ctx$op.value('center')))) %>%
#   ctx$addNamespace() %>%
#   ctx$save()

