####### IMPORTS #######
import pandas as pd 	      # print(pd.__version__)
from bertopic import BERTopic # conda list bertopic
from datetime import datetime # Mesma do python
import plotly as plt  	      # print(plt.__version__)
import plotly.graph_objects as go
from plotly.subplots import make_subplots

from sklearn.metrics import silhouette_score
from sentence_transformers import SentenceTransformer
#from umap import UMAP
import numpy as np
####### IMPORTS #######

####### BANCO DE DADOS #######
# Importando o banco de dados.
data = pd.read_csv("banco_leite_carne_5_por_cento.csv")
#print(data)

# Tirando uma amostra dos dados.
# Aqui os valores da porcentagem sao variados.
# Se frac= 0.1, a amostra eh de 10% dos dados totais;
# Se frac= 0.05, a amostra eh de 5% dos dados totais e assim sucessivamente.
amostra = data#.sample(frac=0.2, random_state=123) 
#print(amostra)
####### BANCO DE DADOS #######

####### MODELAGEM #######
# Início contagem do tempo.
tempo_inicio = datetime.now() 

# Modelo BERTopic. 
# language="portuguese" indica lingua portuguesa.
# calculate_probabilities=True indica que as probabilidades de pertencer a cada topico serao calculadas e apresentadas.
# nr_topics=5 indica 5 topicos, nr_topics=10 indica 10 topicos e assim sucessivamente.
# top_n_words=10 indica 10 palavras chave por topico, top_n_words=20 indica 20 palavras chave por topico e assim sucessivamente.
# min_topic_size=50 indica tamanho minimo de componentes do topico de 50, min_topic_size=100 indica tamanho minimo de componentes do topico de 100 e assim sucessivamente.

###############################################

#Sentence transformer
sentence = SentenceTransformer("paraphrase-multilingual-MiniLM-L12-v2")#all-MiniLM-L6-v2")#paraphrase-multilingual-MiniLM-L12-v2")
embeddings = sentence.encode(amostra['produto'].tolist(), show_progress_bar=False)

###############################################

#Large Language Model
#from ctransformers import AutoModelForCausalLM
#from transformers import AutoTokenizer, pipeline

# Set gpu_layers to the number of layers to offload to GPU. Set to 0 if no GPU acceleration is available on your system.
#model = AutoModelForCausalLM.from_pretrained(
#    "TheBloke/zephyr-7B-alpha-GGUF",
#    model_file="zephyr-7b-alpha.Q4_K_M.gguf",
#    model_type="mistral",
#    gpu_layers=0,
#    hf=True
#)

#tokenizer = AutoTokenizer.from_pretrained("HuggingFaceH4/zephyr-7b-alpha")

# Pipeline
#generator = pipeline(
#    model=model, tokenizer=tokenizer,
#    task='text-generation',
#    max_new_tokens=50,
#    repetition_penalty=1.1
#)

# System prompt describes information given to all conversations
#prompt = """<|system|>Você é um assistente prestativo, respeitoso e honesto para rotular tópicos..</s>
#<|user|>
#Os topicos possuem diversas palavras chave relacionadas a ele.
#Crie palavras que resumem cada topico gerado pelo modelo.
#Como por exemplo, carne e seus documentos terao:
#carne, car, cr, bov. 
#Frango e seus documentos terao:
#frango, coxa, peito, asa, frang. 
#Leite e seus documentos terao:
#leite, lt, leit.
#Crie somente uma palavra chave a cada topico criado e somente isso. Muito obrigado.
#.</s>
#<|assistant|>""" 


#from bertopic.representation import TextGeneration

# Text generation with Zephyr
#zephyr = TextGeneration(generator, prompt=prompt)
#representation_model = {"zephyr": zephyr}

############################################

#Zero Shot
#from bertopic.representation import ZeroShotClassification
#candidate_topics = ["leite", "carne", "frango"]
#representation_model = ZeroShotClassification(candidate_topics, model="facebook/bart-large-mnli")#FacebookAI/xlm-roberta-large") #"FacebookAI/xlm-roberta-base")#facebook/bart-large-mnli")

###############################################

# KeyBertInspired
#from bertopic.representation import KeyBERTInspired
#representation_model = KeyBERTInspired()

####################################################

modelo = BERTopic(language="portuguese",
		  embedding_model=sentence, 
		  top_n_words=5,   
		  min_topic_size=500, 
  		  nr_topics=10,
		  #representation_model=representation_model, 
		  verbose = True) # Modelo
#print(modelo)

# Extracao dos topicos e probabilidades do modelo.
# Aqui eh onde se aplica o fit do modelo para gerar os topicos.
topicos, probabilidades = modelo.fit_transform(amostra['produto'], embeddings)

# Final do tempo de execucao.
tempo_de_execucao = datetime.now() - tempo_inicio
print(f"Treinamento do modelo executado em: {tempo_de_execucao}")

# Adicionando ao banco das amostras os topicos e as probabilidades.
amostra['topicos'] = topicos
print(probabilidades)
amostra['probabilidades'] = probabilidades#.max(axis=1) # Aqui apenas retorna a maior probabilidade, ou seja, a do grupo denominado. 
print(amostra)

# Salvando o banco de dados de cada amostra com suas probabilidades.
amostra.to_csv('D:/Antonio/Documentos/ArquivosUFRGS/8semestre/tcc/a_imagens/config_leitecarne/amostra_50pc.csv', index = False)

# Extraindo as informacoes do proprio modelo.
informacoes = modelo.get_topic_info()
print(informacoes.head())

# Observando cada informacao dentro do modelo.
print(informacoes['Topic']) # Topico, ou seja, o valor de cada topico gerado.
print(informacoes['Count']) # Contagem, ou seja, o valor de elementos dentro do topico.
print(informacoes['Name']) # Nome, ou seja, os principais nomes de observacoes dentro do topico.

# Este 'for' esta realizando a impressao de cada topico.
# A cada iteracao ele realiza a impressao das, se determinado, por exemplo, palavras chave por topico = 10(top_n_words=10),
# top 10 palavras de cada topico.
for index, row in informacoes.iterrows():
    print(row)
    print(f"Topico {row['Topic']} - {row['Name']} - Top 5 de cada topico:")
    print(row['Representation'][:10])
    print("\n")

# Observando os topicos em um grafico
grafico_modelo = modelo.visualize_topics()
#print(grafico_modelo)
fig = go.Figure(grafico_modelo)
fig.show()

# Outro tipo de visualizacao
topicos_grafico = informacoes['Topic'].nunique()
grafico_modelo2 = modelo.visualize_barchart(top_n_topics = topicos_grafico)
fig2 = go.Figure(grafico_modelo2)
fig2.show()

# Um terceiro tipo
grafico_modelo3 = modelo.visualize_heatmap()
fig3 = go.Figure(grafico_modelo3)
fig3.show()

# Um grafico para as probabilidades
#grafico_modelo4 = modelo.visualize_distribution(probabilidades, )
#fig4 = go.Figure(grafico_modelo4)
#fig4.show()

fig.write_html("D:/Antonio/Documentos/ArquivosUFRGS/8semestre/tcc/a_imagens/config_leitecarne/foto1.html")
fig2.write_html("D:/Antonio/Documentos/ArquivosUFRGS/8semestre/tcc/a_imagens/config_leitecarne/foto2.html")
fig3.write_html("D:/Antonio/Documentos/ArquivosUFRGS/8semestre/tcc/a_imagens/config_leitecarne/foto3.html")

# Metrica de silhueta 
umap_embeddings = modelo.umap_model.transform(embeddings)
indices = [index for index, topico in enumerate(topicos) if topico != -1]
ue = umap_embeddings[np.array(indices)]
label = [topico for index, topico in enumerate(topicos) if topico != -1]

# Calcular o score
print(silhouette_score(ue, label))

###
