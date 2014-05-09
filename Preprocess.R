## Ler os dados da PDRS
rawdata = read.csv2(file = 'IndiceData.csv', header=TRUE, row.names = 1)
str(rawdata)

## Carregar funções
source("ProcessaResposta.R")
source("Processa.R")


## Criar constantes convenientes
n_pergunta = ncol(rawdata)
n_questionario = nrow(rawdata)


## Criar um índice para as colunas cujas perguntas com resposta 'Sim' são 
# negativas para o cálculo do índice de sustentabilidade e as respostas 'Não'
# são positivas. 
# Índices com valor igual a zero significa questão normal e com valor igual a 1
# representa questão invertida.
invert_index = rep(0,n_pergunta)

## Preencher o índice com as questões "invertidas".
invert_index[1] = 1

## Gerar Matriz de Respostas Processadas



## Testar se o tamanho do índice está correto
if( length(invert_index) != n_pergunta ){
  stop("Tamanho do Índice está incorreto. Verifique!")
}

data1 = ProcessaResposta(rawdata, invert_index)


data2 = Processa(rawdata, invert_index)


for(j in 1:ncol(rawdata)){
  ## Vericar se a questão é normal ou invertida
  if(invertindex == 0){
    
    ## Caso normal, executa esse loop
    for(i in 1:nrow(rawdata)){
      
      if(rawdata[i,j] == 'Sim') {
        data[i,j] = 1
      }else if(rawdata[i,j] == 'Não'){
        data[i,j] = 0      
      }else {data[i,j] = NA}
    }
    
  }else{
    ## Caso invertido, executa esse loop
    for(i in 1:nrow(rawdata)){
      
      if(rawdata[i,j] == 'Sim') {
        data[i,j] = 0
      }else if(rawdata[i,j] == 'Não'){
        data[i,j] = 1      
      }else {data[i,j] = NA}
    }    
  }    
}


w = as.character(rawdata[,2])
z = data[,2] 

cbind(w,z)




## Processar índices invertidos
for(j in invertido){
  # Para cada coluna normal, varrer linhas
  for(i in 1:nrow(rawdata)){
    if(rawdata[i,j]=='Não'){
      data[i,j] = 1
      print(data[i,j])
      
    }      
  }    
}