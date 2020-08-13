library(data.table)
library(tidyverse)
df <- 
  list.files(pattern = "*.csv") %>% 
  map_df(~fread(., colClasses = c("publishedAt" = "character" )))

train_df <- df %>% 
  select(comment_text = textOriginal, label = Code)

train_df <- train_df %>% 
  mutate(label = case_when(is.na(label) ~ 0,
                           TRUE ~ 1))

train_df %>% write_csv("ctec_training_data.csv")
