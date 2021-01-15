install.packages("lattice")
library("nlme")
library("lattice")


plot <- xyplot(weight ~ Time | Diet, BodyWeight)
class(plot)
plot
BodyWeight


data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)
p

airquality = transform(airquality, Month = factor(Month))
library(ggplot2)
qplot(Wind, Ozone, data = airquality, facets = . ~Month)

install.packages("ggplot2moives")
library(ggplot2movies)

qplot(votes, rating, data = movies) + geom_smooth(method = "lm")
