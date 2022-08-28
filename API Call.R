library(tidyverse)
library(httr)
library(jsonlite)
library(glue)

data <- httr::POST(
  'http://localhost:3000/api/session',
  body = list(username = 'kkharel@metabase.com', password = 'AmiloPiro!23'),
  encode = 'json'
) %>%
  httr::content(as = 'text', encoding = 'UTF-8') %>%
  fromJSON()
session_id <- data$id
headers <- add_headers('X-Metabase-Session' = session_id)


data <- GET('http://localhost:3000/api/card', headers) %>%
  content(as = 'text', encoding = 'UTF-8') %>%
  fromJSON()
num_questions <- data %>%
  nrow()
num_public <- data %>%
  pull(public_uuid) %>%
  discard(is.na) %>%
  length()
glue('{num_public} public of {num_questions} questions')


data <- glue('http://localhost:3000/api/public/card/{uuid}/query') %>%
  GET(headers) %>%
  content(as = 'text', encoding = 'UTF-8') %>%
  fromJSON()
rows <- data$data$rows
colnames(rows) <- c('Category', 'Average')
rows <- rows %>% as_tibble()
rows$Average <- as.numeric(rows$Average)
glue('First data')
rows
