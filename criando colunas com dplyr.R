library(dplyr)# pacote que ajuda manipular linhas e colunas
head(iris)# esse pacote já existe no sistema R

# vamos criar com a função mutate uma coluna que será o comprimento da sépala
# somado ao da pétala
iris_2 = iris %>% select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species) %>%
  mutate(soma_comprimento = Sepal.Length + Petal.Length)

  head(iris_2)
  
  # podemos agora exluir a coluna que acabamos de criar
  iris_3<-iris_2 %>% mutate(soma_comprimento=NULL)
  head(iris_3)
  
  # função .keep escolhe as colunas que serão mantidas
  # used mantém somente as colunas utilizadas
  iris_2 = iris %>% mutate(soma_comprimento = Sepal.Length + Petal.Length, .keep='used') 
  
  head(iris_2)
  
  # unsed mantém as colunas que não foram utilizadas
  iris_2 = iris %>% mutate(soma_comprimento = Sepal.Length + Petal.Length, .keep='unused')
  head(iris_2)
  
  # escolhe onde sua nova coluna irá aparer .before .after
  iris_2 = iris %>% mutate(soma_comprimento = Sepal.Length + Petal.Length,
                           multiplica_comprimento = Sepal.Length * Petal.Length,
                           .before = Species)
  
  head(iris_2)
  
  #pegar o valor da linha posterior ou da linha anterior com mutate() lag() ou lead()
  iris_2 = iris %>% mutate(soma_comprimento = Sepal.Length + Petal.Length,
                           multiplica_comprimento = Sepal.Length * Petal.Length,
                           proximo_comprimento_petala = lead(Petal.Length),
                           anterior_comprimento_petala = lag(Petal.Length),
                           .before = Petal.Width)
  
  head(iris_2)

  ## agora vamos usar outro data set
  ## vamos usar apenas 5 linhas
  USArrests_amostra<- USArrests[1:5,]
  USArrests_amostra

  # usar novamnete o mutate com condionais
  USArrests_amostra_2<- USArrests_amostra %>% 
    mutate(seguranca= case_when(Murder>9 ~'perigoso', Murder<= 9 ~ 'seguro'))
  USArrests_amostra_2  
  
  
  
  
  
  
  
  
    