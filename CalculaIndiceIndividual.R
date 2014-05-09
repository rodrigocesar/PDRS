CalculaIndiceIndividual <- function(data){

  ## Criar frame vazia para receber indice de cada questionário
  
  frame = data.frame(Social = numeric(), Economico = numeric(),
                     Ambiental = numeric(), Geral = numeric())
  
  for(i in 1:nrow(data)){
    
    ## Criar uma lista com os dados por dimensao
    dimensoes = list(data[i,dim1], data[i,dim2], data[i,dim3], data[i,dim4])
    #names(dimensoes) = c('Social', 'Economico', 'Ambiental', 'Geral')
    ## Calcular Índice de sustentabilidade
    indice = CalculaIndice(dimensoes)
    
    frame[i,] = indice
    
  }
  
  rownames(frame) = rownames(data)
  
    
  return(frame)
  
}
