## Dimension Reduction
## PCA and SVD


set.seed(12345)
par(mar = rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])

heatmap(dataMatrix)

## add a pattern
set.seed(678910)
for (i in 1:40){
  # flip a coin
  coinFlip <- rbinom(1, size = 1, prob = 0.5)
  # if coin is heads add a common pattern to that row
  if(coinFlip){
    dataMatrix[i, ] <- dataMatrix[i,] + rep(c(0,3), each = 5)
  }
}

dataMatrix
heatmap(dataMatrix)

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab = "Row Mean", ylan = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)


## Components of the SVD -u and v
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd1$u[,1], 40:1, , xlab = "Row", ylab = "First left singular vector", pch = 19)
plot(svd1$v[,1], xlab = "Column", ylab = "First right singular vector", pch =19)

## Components of the SVD - Variance Explained
par(mfrow = c(1,2), mar = c(4,4,1,2))
plot(svd1$d, xlab = "column", ylab = "Singular Value", pch =19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained", pch = 19)



## relationship to principal components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale =T)
plot(pca1$rotation[, 1], svd1$v[, 1], pch = 19, xlab = "PC1", ylab = "Right Singular Vector 1")
abline(c(0,1))



## Components of the SVD - variance explained
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){
  constantMatrix[i,] <- rep(c(0,1), each = 5)
}
svd1 <- svd(constantMatrix)
par(mfrow =c(1,3), mar = c(4, 4, 1,1 ))
image(t(constantMatrix)[, nrow(constantMatrix):1])
plot(svd1$d, xlab = "Column", ylab = "Singular Value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained", pch =19)

## what if we add a second pattern

set.seed(678910)
for(i in 1:40){
  #flip a coin
  coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
  coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
  # if coin is heads add a common pattern to hat row
  if (coinFlip1){
    dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5), each =5)
  }
  if (coinFlip2){
    dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5), 5)
  }
}

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]

## singular value decomposition - true patterns
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3), mar = c(4,4,1,1))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rep(c(0,1,5), each = 5), pch = 19, xlab = "Column", ylab = "Pattern 1")
plot(rep(c(0,1), 5), pch = 19, xlab = "Column", ylab = "Pattern 2")


## Impute missing values
library(impute)
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100, size = 40, replace =F)] <- NA
dataMatrix2 <- impute.knn(dataMatrix2)$data
svd1 <- svd(scale(dataMatrixOrdered)); svd2 <- svd(scale(dataMatrix2))
par(mfrow = c(1,2), mar = c(4,4,1,1)); plot(svd1$v[,1], pch=19); plot(svd2$v[,1], pch=19)



## Face example
load("data/face.rda")
image(t(faceData)[, nrow(faceData):1])

## Face example - create approximations
svd1 <- svd(scale(faceData))
## Note that %*% is matrix multiplication

# Here svd1$d[1] is a constant
approx1 <- svd1$u[,1] %*% t(svd1$v[,1]) * svd1$d[1]

# In these examples we need to make the diagnoal matrix out of d
approx5 <- svd1$u[, 1:5] %*% diag(svd1$d[1:5]) %8% t(svd1$v[, 1:5])
approx10 <- svd1$u[, 1:10] %*% diag(svd1$d[1:10]) %8% t(svd1$v[, 1:10])


par(mfrow = c(1,4))
image(t(approx1)[, nrow(approx1):1], main = "(a)")
image(t(approx5)[, nrow(approx5):1], main = "(b)")
image(t(approx10)[, nrow(approx10):1], main = "(c)")
image(t(faceData)[, nrow(faceData):1], main = "(d)") ## original data





