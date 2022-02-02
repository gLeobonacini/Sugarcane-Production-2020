# Instalação e Carregamento dos Pacotes Necessários para a Aula -----------

pacotes <- c("dplyr","ggplot2","viridis")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Reading CSV
db <- read.csv("FAOSTAT_data_2-2-2022.csv")
db$Value = db$Value/1000000

# Sugar cane production
sugarcane.db <- db %>% filter(Item == "Sugar cane" & Flag.Description == "Official data")


# English Graphic
sugarcane.db %>% ggplot() +
  geom_col(aes(y = reorder(Area, Value), x = Value, fill = Value)) +
  scale_fill_viridis() +
  labs(y = "", x = "Million tonnes", title = "The 10 largest sugarcane producers", fill = "Million Tonnes") 

# Order Countries
sugarcane.db <- sugarcane.db[order(-sugarcane.db$Value),]

# Portuguese Country Names
sugarcane.db$Area <- c("Brasil","Índia","China","Paquistão","Tailândia",
            "México","EUA","Austrália","Colômbia","Filipinas",
            "África do Sul","Vietnã","Equador","Peru","Bolívia",
            "Paraguai","Quênia","República Dominicana","Honduras",
            "Costa Rica", "Bangladesh","Nepal","Panamá","Moçambique",
            "Maurícia","Fiji","Belize","Etiópia","Sri Lanka","Marrocos",
            "Taiwan","Jamíca","Níger","Afeganistão","Malásia","Cabo Verde",
            "Iraque")

# The 10 Largest Sugarcane Producers
head.sugarcane.db <- sugarcane.db[1:10,]

# The 10 Largest Sugarcane Producers - Portuguese
head.sugarcane.db %>% ggplot() +
  geom_col(aes(y = reorder(Area, Value), x = Value, fill = Value)) +
  scale_fill_viridis() +
  labs(y = "", x = "Milhão de Tonelada", title = "10 Maiores produtores de cana-de-açúcar", fill = "Milhão de Tonelada") + 
  theme(plot.title = element_text(hjust = 0.5)) 

