#  exemplo

library(tidyverse)
library(readxl)

path <- "dados/base_vespa1.xlsx"

tab_coleta <- excel_sheets(path) %>% 
  set_names() %>% 
  map(~ read_excel(path, .x)) %>% 
  bind_rows(.id = "coleta")

tab_coleta_tidy <- tab_coleta %>% 
  gather(local, galhas, Peciolo, Nervura, Caule)


tab_resumo <- tab_coleta_tidy %>% 
  group_by(coleta, Tratamento, local) %>% 
  summarise(galhas = sum(galhas, na.rm = TRUE))

tab_resumo %>% 
  ggplot(aes(local, galhas, fill = Tratamento)) +
    geom_col(position = "dodge") +
    scale_fill_brewer(palette = "Set1") +
    facet_wrap(~coleta) +
    theme_bw()
