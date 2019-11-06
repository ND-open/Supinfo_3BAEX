
library(readxl)
ex1 <- read_excel("ex1.xlsx")

library(ggplot2)
library(dplyr)

ex1 %>% 
        ggplot(. , aes(x = deckchairs, y = recipe)) +
        geom_point() +
        geom_smooth(method = "lm")

fit <- lm(recipe ~ deckchairs, data = ex1)
fit
summary(fit)

pred <- predict.lm(object = fit)

ex1$pred <- pred
ex1 %>% 
        tidyr::pivot_longer(. , cols = c("recipe", "pred")) %>% 
        ggplot(. , aes(x = deckchairs, y = value, colour = name) ) +
        geom_point() +
        geom_line()

mean(pred - ex1$recipe)**2
