##################### BANCO CARNE E LEITE #####################

# Observando os grupos.

# Lendo o banco de dados.
data = read.csv("C:/Users/Antonio/miniconda3/envs/my_env/amostra_50pc.csv", header = TRUE, sep = ",")
data <- data %>%
  filter(topicos != -1)


# Biblioteca para o operador pipe.
library(dplyr)

# Biblioteca para os graficos.
library(ggplot2)

# Biblioteca para a descritiva dos topicos.
library(tidytext)

######## TUDO ########
# Graficos descritiva todos.

# Transformando o topico em categorias.
data$topicos <- as.factor(data$topicos)

# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data %>%
  count(topicos, produto, sort = TRUE) %>% 
  mutate(produto = reorder(produto, n)) %>%
  filter(n > 1000) %>%
  ggplot(aes(n, produto)) +
  geom_col(fill = "#482878FF") +
  scale_fill_manual(guide = FALSE)


# Realizando o grafico de bigrams.
data %>%
  unnest_tokens(bigram, produto, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  filter(n > 1450) %>%
  mutate(bigram = reorder(bigram, n)) %>%
  ggplot(aes(n, bigram)) +
  geom_col(fill = "#482878FF") +
  scale_fill_manual(guide = FALSE)



######## LEITE ########

# Graficos descritiva Leite.

# Filtrando o banco de dados para os grupos de Leite.
data_leite <- data %>%
  filter(topicos %in% c(0,2,3,5,6,8,9,10,14,15))

# Transformando o topico em categorias.
data_leite$topicos <- as.factor(data_leite$topicos)

# Colocando uma cor designada a cada topico.
library(viridis)

# Gerando as 10 cores.
viridis_pal(option = "D")(10)

# Paleta de coores
cores <- c("0" = "#440154FF", "2" = "#482878FF", "3" = "#3E4A89FF", "5" = "#31688EFF", "6" = "#26828EFF",
           "8" = "#1F9E89FF", "9" = "#35B779FF", "10" = "#6DCD59FF", "14" = "#B4DE2CFF", "15" = "#FDE725FF")

# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_leite %>%
  count(topicos, produto, sort = TRUE) %>% 
  mutate(produto = reorder(produto, n)) %>%
  filter(n > 250) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_leite %>%
  unnest_tokens(bigram, produto, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  filter(n > 1200) %>%
  mutate(bigram = reorder(bigram, n)) %>%
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Observando o grupo 0 do Leite.
data_leite_g0 <- data %>%
  filter(topicos %in% c(0))

# Observando o grupo 3 do Leite.
data_leite_g3 <- data %>%
  filter(topicos %in% c(3))

# Observando o grupo 6 do Leite.
data_leite_g6 <- data %>%
  filter(topicos %in% c(6))

# Observando o grupo 10 do Leite.
data_leite_g10 <- data %>%
  filter(topicos %in% c(10))

# Observando o grupo 2 do Leite.
data_leite_g2 <- data %>%
  filter(topicos %in% c(2))

# Observando o grupo 8 do Leite.
data_leite_g8 <- data %>%
  filter(topicos %in% c(8))

# Observando o grupo 5 do Leite.
data_leite_g5 <- data %>%
  filter(topicos %in% c(5))

# Observando o grupo 9 do Leite.
data_leite_g9 <- data %>%
  filter(topicos %in% c(9))

# Observando o grupo 14 do Leite.
data_leite_g14 <- data %>%
  filter(topicos %in% c(14))

# Observando o grupo 15 do Leite.
data_leite_g15 <- data %>%
  filter(topicos %in% c(15))


######## FRANGO ########

# Graficos descritiva Frango.

# Filtrando o banco de dados para os grupos de Frango.
data_frango <- data %>%
  filter(topicos %in% c(4))

# Transformando o topico em categorias.
data_frango$topicos <- as.factor(data_frango$topicos)

# Colocando uma cor designada a cada topico.
library(viridis)

# Paleta de coores
cores <- c("4" = "#440154FF")

# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
#data_frango %>%
#  count(topicos, produto, sort = TRUE) %>% 
#  mutate(produto = reorder(produto, n)) %>%
#  filter(n > 250) %>%
#  ggplot(aes(n, produto, fill = topicos)) +
#  geom_col() +
#  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_frango %>%
  unnest_tokens(bigram, produto, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  filter(n > 350) %>%
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)


# Observando o grupo 4 do Frango.
data_frango_g4 <- data %>%
  filter(topicos %in% c(4))

######## CARNE ########

# Graficos descritiva Carne.

# Filtrando o banco de dados para os grupos de Carne.
data_carne <- data %>%
  filter(topicos %in% c(7,13))

# Transformando o topico em categorias.
data_carne$topicos <- as.factor(data_carne$topicos)

# Colocando uma cor designada a cada topico.
library(viridis)

# Paleta de coores
cores <- c("7" = "#440154FF", "13" = "#3E4A89FF")

# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_carne %>%
  count(topicos, produto, sort = TRUE) %>% 
  mutate(produto = reorder(produto, n)) %>%
  filter(n > 20) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_carne %>%
  unnest_tokens(bigram, produto, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  filter(n > 150) %>%
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Observando o grupo 7 de Carne.
data_carne_g7 <- data %>%
  filter(topicos %in% c(7))

# Observando o grupo 13 de Carne.
data_carne_g13 <- data %>%
  filter(topicos %in% c(13))

######## OUTROS ########

# Graficos descritiva Outros.

# Filtrando o banco de dados para os grupos de Outros.
data_outros <- data %>%
  filter(topicos %in% c(1,11,12,17,18,19))

# Transformando o topico em categorias.
data_outros$topicos <- as.factor(data_outros$topicos)

# Colocando uma cor designada a cada topico.
library(viridis)

# Paleta de coores
cores <- c("1" = "#440154FF", "11" = "#3E4A89FF", "12" = "#31688EFF", "17" = "#26828EFF",
           "18" = "#1F9E89FF", "19" = "#35B779FF")

# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_outros %>%
  count(topicos, produto, sort = TRUE) %>% 
  mutate(produto = reorder(produto, n)) %>%
  filter(n > 70) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_outros %>%
  unnest_tokens(bigram, produto, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  filter(n > 800) %>%
  mutate(bigram = reorder(bigram, n)) %>%
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)


# Observando o grupo 1 dos outros.
data_outros_g1 <- data %>%
  filter(topicos %in% c(1))

# Observando o grupo 11 dos outros.
data_outros_g11 <- data %>%
  filter(topicos %in% c(11))

# Observando o grupo 12 dos outros.
data_outros_g12 <- data %>%
  filter(topicos %in% c(12))

# Observando o grupo 17 dos outros.
data_outros_g17 <- data %>%
  filter(topicos %in% c(17))

# Observando o grupo 18 dos outros.
data_outros_g18 <- data %>%
  filter(topicos %in% c(18))

# Observando o grupo 19 dos outros.
data_outros_g19 <- data %>%
  filter(topicos %in% c(19))











##################### BANCO GERAL #####################

# Lendo o banco de dados.
data = read.csv("C:/Users/Antonio/miniconda3/envs/my_env/amostra_50pc2.csv", header = TRUE, sep = ",")
data <- data %>%
  filter(topicos != -1)


######## TUDO ########
# Graficos descritiva todos.

# Transformando o topico em categorias.
data$topicos <- as.factor(data$topicos)

# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data %>%
  count(topicos, produtos, sort = TRUE) %>% 
  mutate(produto = reorder(produtos, n)) %>%
  filter(n > 30) %>%
  ggplot(aes(n, produto)) +
  geom_col(fill = "#482878FF") +
  scale_fill_manual(guide = FALSE)


# Realizando o grafico de bigrams.
data %>%
  unnest_tokens(bigram, produtos, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  filter(n > 500) %>%
  mutate(bigram = reorder(bigram, n)) %>%
  ggplot(aes(n, bigram)) +
  geom_col(fill = "#482878FF") +
  scale_fill_manual(guide = FALSE)


######## LEITE ########

# Graficos descritiva Leite.

# Filtrando o banco de dados para os grupos de Leite.
data_leite <- data %>%
  filter(topicos %in% c(6,19,23,32))

# Transformando o topico em categorias.
data_leite$topicos <- as.factor(data_leite$topicos)

# Paleta de coores
cores <- c("6" = "#1F9E89FF", "19" = "#31688EFF", "23" = "#6DCD59FF", "32" = "#440154FF")

# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_leite %>%
  count(topicos, produtos, sort = TRUE) %>% 
  mutate(produto = reorder(produtos, n)) %>%
  filter(n > 20) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_leite %>%
  unnest_tokens(bigram, produtos, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  filter(n > 155) %>%
  mutate(bigram = reorder(bigram, n)) %>%
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Observando o grupo 0 do Leite.
data_leite_g6 <- data %>%
  filter(topicos %in% c(6))

# Observando o grupo 3 do Leite.
data_leite_g19 <- data %>%
  filter(topicos %in% c(19))

# Observando o grupo 6 do Leite.
data_leite_g23 <- data %>%
  filter(topicos %in% c(23))

# Observando o grupo 10 do Leite.
data_leite_g32 <- data %>%
  filter(topicos %in% c(32))


######## CARNES ########

# Graficos descritiva Carnes.

# Filtrando o banco de dados para os grupos de Carnes.
data_carnes <- data %>%
  filter(topicos %in% c(1,15,17))

# Transformando o topico em categorias.
data_carnes$topicos <- as.factor(data_carnes$topicos)

# Colocando uma cor designada a cada topico.
library(viridis)

# Paleta de coores
cores <- c("1" = "#1F9E89FF", "15" = "#31688EFF", "17" = "#440154FF")

# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_carnes %>%
  count(topicos, produtos, sort = TRUE) %>% 
  mutate(produto = reorder(produtos, n)) %>%
  filter(n > 14) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_carnes %>%
  unnest_tokens(bigram, produtos, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  filter(n > 180) %>%
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)


# Observando o grupo 1 das Carnes.
data_carnes_g1 <- data %>%
  filter(topicos %in% c(1))

# Observando o grupo 15 ddas Carnes.
data_carnes_g15 <- data %>%
  filter(topicos %in% c(15))

# Observando o grupo 17 das Carnes.
data_carnes_g17 <- data %>%
  filter(topicos %in% c(17))


######## PORTAS ########

# Graficos descritiva Portas.

# Filtrando o banco de dados para os grupos de Portas.
data_portas <- data %>%
  filter(topicos %in% c(0,2,4,18,29))

# Transformando o topico em categorias.
data_portas$topicos <- as.factor(data_portas$topicos)

# Paleta de coores
cores <- c("0" = "#440154FF", "2" = "#3E4A89FF", "4" = "#26828EFF",
           "18" = "#6DCD59FF", "29" = "#B4DE2CFF")


# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_portas %>%
  count(topicos, produtos, sort = TRUE) %>% 
  mutate(produto = reorder(produtos, n)) %>%
  filter(n > 7) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_portas %>%
  unnest_tokens(bigram, produtos, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  filter(n > 80) %>%
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)



######## ROUPAS ########

# Graficos descritiva Roupas.

# Filtrando o banco de dados para os grupos de Roupas.
data_roupas <- data %>%
  filter(topicos %in% c(5,9,14,24))

# Transformando o topico em categorias.
data_roupas$topicos <- as.factor(data_roupas$topicos)

# Paleta de coores
cores <- c("5" = "#440154FF", "9" = "#3E4A89FF", "14" = "#26828EFF",
           "24" = "#6DCD59FF")


# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_roupas %>%
  count(topicos, produtos, sort = TRUE) %>% 
  mutate(produto = reorder(produtos, n)) %>%
  filter(n > 6) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_roupas %>%
  unnest_tokens(bigram, produtos, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  filter(n > 60) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

######## COMIDAS ########

# Graficos descritiva Comidas

# Filtrando o banco de dados para os grupos de Comidas
data_comidas <- data %>%
  filter(topicos %in% c(11,25,26,27))

# Transformando o topico em categorias.
data_comidas$topicos <- as.factor(data_comidas$topicos)

# Paleta de coores
cores <- c("11" = "#440154FF", "12" = "#3E4A89FF", "25" = "#26828EFF",
           "26" = "#6DCD59FF", "27" = "#B4DE2CFF")



# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_comidas %>%
  count(topicos, produtos, sort = TRUE) %>% 
  mutate(produto = reorder(produtos, n)) %>%
  filter(n > 8) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_comidas %>%
  unnest_tokens(bigram, produtos, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  filter(n > 50) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)


# Observando o grupo 12 de Comidas.
data_comidas_g12 <- data %>%
  filter(topicos %in% c(12))

######## GERAIS 1 ########

# Graficos descritiva Gerais 1.

# Filtrando o banco de dados para os grupos de Gerais 1.
data_gerais1 <- data %>%
  filter(topicos %in% c(3,7,8,21,22,28))

# Transformando o topico em categorias.
data_gerais1$topicos <- as.factor(data_gerais1$topicos)

# Paleta de coores
cores <- c("3" = "#440154FF", "7" = "#3E4A89FF", "8" = "#26828EFF",
           "21" = "#FDE725FF", "22" = "#6DCD59FF", "28" = "#B4DE2CFF")



# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_gerais1 %>%
  count(topicos, produtos, sort = TRUE) %>% 
  mutate(produto = reorder(produtos, n)) %>%
  filter(n > 10) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_gerais1 %>%
  unnest_tokens(bigram, produtos, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  filter(n > 70) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)


# Observando o grupo 7 de Gerais 1.
data_gerais1_g7 <- data %>%
  filter(topicos %in% c(7))

# Observando o grupo 21 de Gerais 1.
data_gerais1_g21 <- data %>%
  filter(topicos %in% c(21))

######## GERAIS 2 ########

# Graficos descritiva Gerais 2.

# Filtrando o banco de dados para os grupos de Gerais 2.
data_gerais2 <- data %>%
  filter(topicos %in% c(10,11,13,16,20,30,31))

# Transformando o topico em categorias.
data_gerais2$topicos <- as.factor(data_gerais2$topicos)

# Paleta de coores
cores <- c("10" = "#440154FF", "11" = "#3E4A89FF", "13" = "#26828EFF","16" = "#1F9E89FF",
           "20" = "#FDE725FF", "30" = "#6DCD59FF", "31" = "#B4DE2CFF")



# Gerando um grafico das palavras mais frequentes.
# Baseado no livro da Julia Silge.
data_gerais2 %>%
  count(topicos, produtos, sort = TRUE) %>% 
  mutate(produto = reorder(produtos, n)) %>%
  filter(n > 10) %>%
  ggplot(aes(n, produto, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)

# Realizando o grafico de bigrams.
data_gerais2 %>%
  unnest_tokens(bigram, produtos, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  count(topicos, bigram, sort = TRUE) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  filter(n > 70) %>%
  mutate(bigram = reorder(bigram, n)) %>% 
  ggplot(aes(n, bigram, fill = topicos)) +
  geom_col() +
  scale_fill_manual(values = cores)


# Observando o grupo 7 de Gerais 1.
data_gerais1_g7 <- data %>%
  filter(topicos %in% c(7))

# Observando o grupo 21 de Gerais 1.
data_gerais1_g21 <- data %>%
  filter(topicos %in% c(21))