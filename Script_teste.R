#####GGPlot2#####

####Aquisição de dados####
# GGPlot2 necessita que os dados utilizados sejam um dataframe ou tibble 

install.packages("tibble")
install.packages("dados")
install.packages("tidyverse")

pinguins <- data.frame(dados::pinguins); tibble::as_tibble(pinguins)

# Algumas outras formas de como apresentar os dados
str(pinguins)
dplyr::glimpse(pinguins)

# Como pode-se perceber há algumas pontos que se encontram sem valor (NA).
# Para não ficar aparecendo mensagem de erro na construção dos gráficos.
pinguins <- na.omit(pinguins) #Eliminando a linhas sem valores
View(pinguins)

attach(pinguins) #Essa função possibilita que acessemos os dados 
#                 pelo nome da coluna.
#Por exemplo:
tibble::as_tibble(ilha)

####Construção de Gráfico a partir da função 'plot'####

# Neste primeiro gráfico, a função 'plot' contruí um gráfico de dispersão, 
# pois ambos os fatores são quantitativos (x = comprimento_bico, y = massa_corporal).  
plot(x = comprimento_bico, y = massa_corporal,
     xlab = "Comprimento do Bico", ylab = "Massa corporal",
     title(main ="Gráfico de dispersão"),
     pch = 21, col ="Gray", bg="blue", cex=1.2)

# Neste segundo gráfico, a função 'plot' contruí um Box-plot, pois um dos fatores é quanlitativo (x = ilha).
plot(x = ilha, y = massa_corporal,
     xlab = "Origem", ylab = "Massa corporal",
     title(main ="Box-plot"),
     pch = 21, col ="Gray", cex=1.2)  

# Então a partir disso, observamos que a função 'plot' é funcional porém ela apresenta algumas limitações.
# Essas limitações serão superadas com a utilização do package 'GGPlot2'.

####Construção de Gráficos a partir do pacote 'GGPlot2'####

# Primeiramente, iremos instalar e chamar o pacote
install.packages("ggplot2")
library(ggplot2)

# É importante entender que a essência do 'GGPlot2' é a construção de gráficos em camadas, unidas a partir do '+'.
# Com será notório com o desenvolvimento dos códigos.
# Outro ponto, é que os dados utilizado devem estar preferencialmente como dataframe

# Um exemplo de como fica o design de um gráfico construido a partir do 'GGPlot'
ggplot(pinguins,
       aes(comprimento_bico, massa_corporal, 
           col=ilha)) +
  geom_point(pch = 16, size = 2.5) +
  geom_smooth(method = lm, col="black") +
  theme_light() +
  labs(x = "Comprimento do Bico", y = "Massa Corporal",
       title = paste("Gráfico de dispersão")) +
  theme(legend.position = "right", legend.title = element_blank(),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem"))

#Error_01
ggplot(pinguins,
       aes(comprimento_bico, massa_corporal, 
           col=ilha)) +
  geom_point(pch = 16, size = 2.5) +
  geom_smooth(method = lm, col="black") +
  theme_light() +
  labs(x = "Comprimento do Bico", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão")) +
  theme(legend.position = "right",
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem"),
         label.hjust = 0.5, label.vjust = 1)

#Error_02
ggplot(pinguins,
       aes(comprimento_bico, massa_corporal, 
           col=ilha)) +
  geom_point(pch = 16, size = 2.5) +
  geom_smooth(method = lm, col="black") +
  theme_light() +
  labs(x = "Comprimento do Bico", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão")) +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem"))

####Passo a passo para construção####

## Primeira camada - onde recebemos os dados
ggplot(data = pinguins, #Para definir de que arquivo os dados serão retirados
       aes(x = comprimento_nadadeira, y = massa_corporal)) #Define quais dados estarão na abscissa e na ordenada

# É necessário potuar que essa precisa ser a primeira informação do seu gráfico.
# Entretanto não necessário que as demais camadas estejam na ordem representada, isso é apenas para facilitar a didática 

## Segunda camada - tipo de gráfico
ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point() # Para contrução de um gráfico de dispersão

ggplot(data = pinguins,
       aes(x = comprimento_nadadeira)) +
  geom_histogram(col = "gray") # Para contrução de um histograma

# Nessa camada há a implementação visual dos dados de acordo com o demandado

## terceira camada - nomeação

ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão"))

# Aqui adicionamos nome ao gráfico e aos eixos

## Quarta camada - Mudança do tema de fundo do gráficp
# theme_...

# Aqui temos o default que é um pouco cinza, como podemos observar
ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão"))

# theme_light() - É o que eu mais uso
ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão")) + 
  theme_light()

# theme_minimal()
ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão")) + 
  theme_minimal()

# theme_dark()
ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão")) + 
  theme_dark()

## Quinta camada - alterações de pequenas configurações
# theme()

ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal, 
           col = ilha)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão")) + 
  theme_light() +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5))

# Recomendo muito você olharem, rapidamente, o 'help' dessa função, têm muita informação
help("theme")

# Essas são as principais camadas da função 'ggplot'
# Mas há muitas outras, que com o aprofundamento dos estudos e as necessidade de cada um, vocês irão se deparar e aprender

####Exemplos de gráfico####

##Exemplo_01 - Adicionando legenda

ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal, 
           col = ilha)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão"),
       caption = "Fonte: as melhores possíveis, confia!") + #Adicionei a fonte
  theme_light() +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5),
        plot.caption = element_text(color="black", size=11, 
                                    face="plain", hjust = 1, vjust = 0.5)) + #Editei a fonte
  guides(color = guide_legend(title = "Origem"))


ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal, 
           col = ilha)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal") + 
  theme_light() +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem")) + 
  ggtitle("Gráfico de dispersão",
          subtitle = "Fonte: as melhores possíveis, confia!")

##Exemplo_02 - Limites ao gráfico

ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal, 
           col = ilha)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal",
       title = paste("Gráfico de dispersão")) + 
  theme_light() +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem")) + 
  xlim(180,200) + 
  ylim(3000,4000)

# Neste ponto, houve a delimitação do intervalo de interesse e um zoom no gráfico

##Exemplo_03 - Repartição da tela

# Instalação de um pacote
install.packages("gridExtra")
library(gridExtra)

#Na função desse pacote, devemos chamar o gráfico já salvo, por isso:
grafico <- ggplot(data = pinguins,
                  aes(x = comprimento_nadadeira, y = massa_corporal, 
                      col = ilha)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal") + 
  theme_light() +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem")) 

grafico.zoom <- ggplot(data = pinguins,
                       aes(x = comprimento_nadadeira, y = massa_corporal, 
                           col = ilha)) +
  geom_point(pch = 16, size = 2.5) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal") + 
  theme_light() +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem")) + 
  xlim(180,200) + 
  ylim(3000,4000)

grid.arrange(grafico, grafico.zoom, ncol=2)

##Exemplo_04
ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal)) +
  stat_summary(fun = mean, geom = "point", pch = 16, size = 2.5,
               col = "black") + 
  stat_summary(fun = mean, geom = "line", col = "red") +
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal",
       title = paste("Gráfico de dispersão")) + 
  theme_light() +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5))

####Mensagem Final####

# Dessa aula gostaria de ter deixado dois pontos importantes

# 1 - Que vocês entendam que a melhor forma de trabalhar com o 'ggplot' não 
#     é decorando códigos, mas, sim, entendendo da lógica e da organização 
#     dessa função, e utilizando-se muito do 'help' e pesquisas.
#     Assim, como recomendação deixo para vocês vários exemplos de gráficos
#     para vocês alterarem, adicionarem e retirarem pontos deles e tentar 
#     rodar, a fim de entender a lógica.

# 2 - Gostaria de lançar um primeiro pensamento, que os gráficos são exce-
#     lentes ferramentas para visualização e levantamento de hipotéses
#     entretanto essas hipotéses apenas se validaram com os testes de 
#     hipóteses.


####Dicas - Estatística Geral####

##Algumas funções

mean(comprimento_nadadeira)  #Média
var(comprimento_nadadeira,massa_corporal)  #Variância
sd(comprimento_nadadeira)  #Desvio padrão
cor(comprimento_nadadeira,massa_corporal)  #Coeficiente de correlação
((sd(comprimento_nadadeira)/mean(comprimento_nadadeira))*100) #Coeficiente de variação
quantile(comprimento_nadadeira)  #Retorna os quantis

##Gráfico de barras

ggplot(data = pinguins,
       aes(massa_corporal)) +
  geom_bar(col = "black", fill = "red") + 
  labs(x = "Massa Corporal",
       title = paste("Gráfico de barras")) + 
  theme_light() +
  theme(plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5))

ggplot(data = pinguins,
       aes(factor(ilha), fill = factor(ano))) +
  geom_bar(position = "dodge2") + 
  labs(x = "Ilhas", y = "Quantidade" ,
       title = paste("Gráfico de barras")) + 
  theme_light() +
  theme(plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5))

##Histograma

# Histograma por quantidade
ggplot(data = pinguins,
       aes(massa_corporal)) +
  geom_histogram(col = "black", fill = "gray") +
  labs(x = "Massa Corporal",
       title = paste("Histograma")) + 
  theme_light() +
  theme(plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5))  

# Histograma por densidade
ggplot(data = pinguins,
       aes(massa_corporal)) +
  geom_histogram(aes(y = ..density..), col = "black", fill = "gray") +
  labs(x = "Massa Corporal",
       title = paste("Histograma")) + 
  theme_light() +
  theme(plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) 


ggplot(data = pinguins,
       aes(bins = 30, massa_corporal)) +
  geom_histogram(aes(y = ..density..),col = "black", fill = "gray") +
  geom_density(col = "red") +
  labs(x = "Massa Corporal",
       title = paste("Histograma")) + 
  theme_light() +
  theme(plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5))

##Box-plot

ggplot(data = pinguins,
       aes(x = comprimento_nadadeira, y = massa_corporal, 
           col = ilha)) +
  geom_boxplot(size = 0.8) + 
  labs(x = "Comprimento da Nadadeira", y = "Massa Corporal",
       title = paste("Diagrama de caixa")) + 
  theme_light() +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem"))

##Regressão linear

# Ajuste do modelo de regressão linear simples
regressao<- lm(comprimento_nadadeira ~ massa_corporal)

# Vendo o ajuste
regressao

# Teste geral pela anova
anova(regressao)

# Resultados do modelo de regressão linear simples (coeficientes estimados, testes...)
summary(regressao)

# Diagnóstico do modelo (análise dos resíduos)
plot(regressao) #Pressione 'enter' para seguir

# Gráfico com regressão linear plotado
ggplot(pinguins,
       aes(comprimento_nadadeira, massa_corporal, 
           col=ilha)) +
  geom_point(pch = 16, size = 2.5) +
  geom_smooth(method = lm, col="black") + #Essa função insere a regressão
  theme_light() +
  labs(x = "Comprimento da Nadadeira
               ", y = "Massa Corporal", 
       title = paste("Gráfico de dispersão")) +
  theme(legend.position = "right", 
        legend.title = element_text(size = 11, face = "bold"),
        plot.title = element_text(color="black", size=18,
                                  face="bold", hjust = 0.5, vjust = 0.5)) +
  guides(color = guide_legend(title = "Origem"))