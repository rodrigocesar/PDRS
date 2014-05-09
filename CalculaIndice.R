CalculaIndice <- function(dimensoes){
  
  ## Calcular sustentabilidade para cada dimensao
  media = lapply(dimensoes, function(x) colMeans(x))
  sustenta_index = lapply(media, function(x) mean(x) )
  
  
  return(sustenta_index)
  
  
}