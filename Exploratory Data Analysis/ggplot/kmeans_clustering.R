# K-Means clustering

set.seed(1234)
par(mar = c(1,1,1,1))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = 0.2)

dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)

kmeansObj$cluster

plot(x,y, col = kmeansObj$cluster, pch = 19, cex =2)
points(kmeansObj$centers, col = 1:3, pch = 3, cex =3, lwd = 3)


## plot heatmap for kmeans
dataFrame <- data.frame(x = x, y = y)
dataFrame

set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObj2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1,2), mar = c(2,4,0.1,0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n")
