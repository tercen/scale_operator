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
df <- ctx$select(c(".ri", ".ci", ".y"))
dt <- data.table(df)

dt[ , .(.y = mean(.y)), by = c(".ri",".ci")]

outDf <- dt[ , c("scaled_value", ".ri") := 
               do.scale(.y, .ri, 
                        ctx$op.value("scale", as.logical, TRUE),
                        ctx$op.value("center", as.logical, TRUE)),
             by = c(".ci") ] %>% 
  select(-.y) %>%
  as.data.frame() %>%
  arrange(.ci, .ri) %>%
  relocate(.ci) %>%
  relocate(scaled_value) %>%
  ctx$addNamespace() %>%
  ctx$save()