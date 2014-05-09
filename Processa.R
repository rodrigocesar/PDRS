Processa <- function(rawdata, invert_index){
  
  ## Criar a matriz para armazenar os dados processados da PDRS.
  data = matrix(0, nrow = nrow(rawdata), ncol = ncol(rawdata))
  
  ## Separar índices normais e invertidos
  normal = which(invert_index == 0)
  invertido = which(invert_index == 1)
  
  ## Processar índices normais
  for(j in normal){
    # Para cada coluna normal, varrer linhas
    for(i in 1:nrow(rawdata)){
      if(rawdata[i,j]=='Sim'){
        data[i,j] = 1
        
      }      
    }    
  }
  
  
  ## Processar índices invertidos
  for(j in invertido){
    # Para cada coluna invertida, varrer linhas
    for(i in 1:nrow(rawdata)){
      if(rawdata[i,j]=='Nao'){
        data[i,j] = 1
                
      }      
    }    
  }
  
      
  return(data)
}