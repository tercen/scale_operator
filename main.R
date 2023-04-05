library(tercen)
library(dplyr)
library(data.table)

do.scale = function(y, ci, ...){
  
  scale.m = try(scale(as.matrix(y), ...), silent = TRUE)
  
  
  if(inherits(scale.m, 'try-error')) {
    return (double())
  }  
  
  result <- data.frame("value"=scale.m, ".ci"=ci)
  
  return (result)
}



ctx = tercenCtx()
df <- ctx$select(c(".ci", ".ri", ".y"))
dt <- data.table(df)
dt[ , .(.y = mean(.y)), by = c(".ci",".ri")]
outDf <- dt[ , c("scaled_value", ".ci") := 
               do.scale(.y, .ci, 
                        ctx$op.value("scale", as.logical, TRUE),
                        ctx$op.value("center", as.logical, TRUE)),
             by = c(".ri") ] %>% 
  select(-.y) %>%
  as.data.frame() %>%
  arrange(.ri, .ci) %>%
  relocate(.ri) %>%
  relocate(value) %>%
  ctx$addNamespace() %>%
  ctx$save()
