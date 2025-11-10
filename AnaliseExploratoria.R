# Script: analise_exploratoria.R
#
# Carregar bibliotecas
library(readxl)
library(dplyr)

dados <- read_excel("Base_trabalho.xlsx")

dados$escolaridade <- as.factor(dados$escolaridade)
dados$reincidente <- as.factor(dados$reincidente)

vars_numericas <- dados %>% 
  select(score_periculosidade, idade, tempo_preso)

summary(vars_numericas) 

apply(vars_numericas, 2, mean, na.rm = TRUE)
apply(vars_numericas, 2, median, na.rm = TRUE)
apply(vars_numericas, 2, quantile, probs = c(0.25, 0.75), na.rm = TRUE)

grafico_dispersao <- ggplot(dados, aes(x = tempo_preso, y = score_periculosidade)) +
  geom_point(alpha = 0.6, color = "darkblue") + # alpha para transparência
  geom_smooth(method = "lm", color = "red", se = FALSE) + # Linha de tendência
  labs(title = "Gráfico de Dispersão: Tempo Preso vs. Score",
       x = "Tempo Preso",
       y = "Score de Periculosidade") +
  theme_minimal()
print(grafico_dispersao)
ggsave("dispersao_tempo_score.png", plot = grafico_dispersao, width = 6, height = 4)


correlacao_tempo_score <- cor(dados$tempo_preso, dados$score_periculosidade, 
                              use = "pairwise.complete.obs") 
print(paste("Correlação:", round(correlacao_tempo_score, 4)))


apply(vars_numericas, 2, var, na.rm = TRUE)
# Desvio Padrão:
apply(vars_numericas, 2, sd, na.rm = TRUE)
# Amplitude (Máximo - Mínimo):
amplitude <- apply(vars_numericas, 2, function(x) max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
print(amplitude)