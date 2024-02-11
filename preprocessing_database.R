# Iniciando o pre processamento em R.

# Lendo o banco de dados.
data = read.csv("C:/Users/Antonio/miniconda3/envs/my_env/bancao_1_por_cento.csv", header = TRUE, sep = ";")

# Mudando o nome do banco de dados.
names(data) = "produtos"

# Biblioteca para o operador pipe.
library(dplyr)

# Processando o banco de dados.
data <- data %>%
  mutate(produtos = gsub("^\\d+;|\"", "", produtos) %>% # Removendo o que esta na esquerda do ";" e as aspas.
           iconv(to = "ASCII//TRANSLIT", sub = " ") %>% # Removendo a acentuacao.
           tolower()) # Deixando todas palavras em minusculo.

# Exportando o banco de dados final.
write.csv(data, file = "C:/Users/Antonio/miniconda3/envs/my_env/data.csv", row.names = FALSE)



