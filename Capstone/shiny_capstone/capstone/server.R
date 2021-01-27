#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tm)
library(stopwords)

bigram <- data.frame(readRDS("./bi_words.rds"))
trigram <- data.frame(readRDS("./tri_words.rds"))
quadgram <- data.frame(readRDS("./quad_words.rds"))

## predict next word using 2-gram dictionary
next_word_bigram <- function(input_split) {
    
    next_word <- as.character(head(bigram[bigram$word1 == input_split[1], ]$word2, 1))
    
    freq <- as.character(head(bigram[bigram$word1 == input_split[1], ]$n, 1))
    
    if(identical(next_word,character(0))) {
        next_word <- "it"
        freq < -0
    }
    
    next_word_list <- list(next_word, freq)
    return(next_word_list)
}

## Match input words in 3-gram dictionary
## if it not found, it use the 2-gram
next_word_trigram<-function(input_split) {
    
    next_word <- as.character(head(trigram[trigram$word1 == input_split[1] & 
                                               trigram$word2 == input_split[2], ]$word3, 1))
    
    freq <- as.character(head(trigram[trigram$word1 == input_split[1] & 
                                          trigram$word2 == input_split[2], ]$n, 1))
    
    next_word_list <- list(next_word, freq)
    
    if(identical(next_word,character(0))) {
        
        next_word_list = predict_next_word(input_split[2]) # use the last one word as input for 2-gram dictionary
        
    }
    return(next_word_list)
}

## Match input words in 4-gram dictionary
## if it not found, it use the 3-gram

next_word_quadgram<-function(input_split) {
    
    next_word <- as.character(head(quadgram[quadgram$word1 == input_split[1] 
                                           & quadgram$word2 == input_split[2]
                                           & quadgram$word3 == input_split[3]
                                           ,]$word4,1))
    
    freq <- as.character(head(quadgram[quadgram$word1 == input_split[1] 
                                      & quadgram$word2 == input_split[2]
                                      & quadgram$word3 == input_split[3]
                                      ,]$n, 1))
    
    next_word_list<-list(next_word, freq)
    if(identical(next_word,character(0))) {
        next_word_list = predict_next_word(paste(input_split[2],input_split[3],sep=" "))
    }
    return(next_word_list)
}


## function for searching the input text
## this function decides which above function to use

predict_next_word <- function(input, ngrams_dic = 0)  {
    # to lower case
    input_clean <- tolower(input)
    # remove and stop words
    input_clean <- removeWords(input_clean, stopwords("en"))
    # remove numbers and extra whitespace
    input_clean <- stripWhitespace(removeNumbers(input_clean, preserve_intra_word_dashes = TRUE))
    # split input text into single word
    input_split <- strsplit(input_clean," ")[[1]]
    # Number of effitive input words
    input_len <- length(input_split)
    
    if(input_len == 1 || ngrams_dic == 2) { ##use bigram to predict the next word
        next_word_list <- next_word_bigram(tail(input_split, 1))
    }  
    else if(input_len == 2 || ngrams_dic == 3) { ##use trigram to predict the next word
        next_word_list <- next_word_trigram(tail(input_split, 2))
    }
    else if(input_len > 2 || grams_dic == 3) {
        next_word_list <- next_word_quadgram(tail(input_split, 3))
    }
    else {
        next_word_list <- list("it", 0)
    }
    return(next_word_list)
}


# Set up server
shinyServer(function(input, output) {
    output$next_word <- renderPrint({
        result <- predict_next_word(input$inputText,0)
        result[[1]]
    });
    output$bigram <- renderPrint({
        result <- predict_next_word(input$inputText,2)
        result[[1]]
    });
    output$trigram <- renderPrint({
        result <- predict_next_word(input$inputText,3)
        result[[1]]
    });
    output$quadgram <- renderPrint({
        result <- predict_next_word(input$inputText,4)
        result[[1]]
    });
})








