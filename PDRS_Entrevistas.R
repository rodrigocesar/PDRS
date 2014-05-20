## Ler os dados da PDRS - Entrevista
rawdata = read.csv2(file = 'IndiceEntrevistas.csv', header=TRUE, row.names = 1)
str(rawdata)

## Ler os dados com a classificação das perguntas da PDRS. 
class =  read.csv2(file = 'classificacao.csv', header=TRUE, row.names = 1)

## Ler os dados com a correspondência entre respondentes e bacia. 
bacia =  read.csv2(file = 'Bacia.csv', header=TRUE, row.names = 1)

## Carregar funções
source("Processa.R")
source("CalculaIndice.R")
source("CalculaIndiceIndividual.R")

## Criar constantes convenientes
n_pergunta = ncol(rawdata)
n_questionario = nrow(rawdata)


## Criar um índice para as colunas cujas perguntas com resposta 'Sim' são 
# negativas para o cálculo do índice de sustentabilidade e as respostas 'Não'
# são positivas. 
# Índices com valor igual a zero significa questão normal e com valor igual a 1
# representa questão invertida.
#invert_index = rep(0,n_pergunta)
invert_index = class$Invertido

## Preencher o índice com as questões "invertidas".
#invert_index[1] = 1

## Testar se o tamanho do índice está correto
if( length(invert_index) != n_pergunta ){
  stop("Tamanho do Índice está incorreto. Verifique!")
}

## Pre-processar dados
data = Processa(rawdata, invert_index)

## Separar as variaveis por dimensão de sustentabilidade
dim1 = which(class$Dimensao == 'Social')
dim2 = which(class$Dimensao == 'Econômico')
dim3 = which(class$Dimensao == 'Ambiental')
dim4 = c(1:n_pergunta)

## Criar uma lista com os dados por dimensao
dimensoes = list(data[,dim1], data[,dim2], data[,dim3], data[,dim4])
names(dimensoes) = c('Social', 'Economico', 'Ambiental', 'Geral')


## Criar uma lista com a soma dos valores positivos para sustentabilidade,
# separado por dimensao de sustentabilidade.
respostas_dim = lapply(dimensoes, function(x) colSums(x))



## Calcular Índice de sustentabilidade
indice_total = CalculaIndice(dimensoes)
print(indice_total)

## Escrever uma tabela com o resultado dos índices
write.csv2(indice_total, file = 'indice_sustentabilidade_total_Entrevistas.csv')


indice_individual = CalculaIndiceIndividual(data)
## Escrever uma tabela com o resultado dos índices
write.csv2(indice_individual, file = 'indice_sustentabilidade_individual_Entrevistas.csv')

indice = rbind(indice_individual,indice_total)
rownames(indice)[nrow(indice)] = 'Total'

## Escrever uma tabela com o resultado agregado dos índices individuais e total.
write.csv2(indice, file = 'indice_sustentabilidade_Entrevistas.csv')

## Calcular o índice por Microbacia
## Unir os dados do índice indice individual aos dados da microbacia 
# à qual pertencem.
bacia_data = merge(bacia, indice_individual, by = 'row.names')

## Separar os dados por microbacia
bacia_split = split(bacia_data, bacia_data$Microbacia)

## Calcular indice por microbacia
indice_microbacia = t( sapply(bacia_split, function(x) colMeans(x[3:6])) )

## Escrever uma tabela com o resultado agregado dos índices por microbacia.
write.csv2(indice_microbacia, file = 'indice_sustentabilidade_microbacia_Entrevistas.csv')

# Logo abaixo segue outro modo de calcular o indice de sustentabilidade.
#sustenta_index = lapply(respostas_dim, function(x) sum(x)/(length(x)*n_questionario ) )
## Inserir o índice de sustentabilidade geral à lista



