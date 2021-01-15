library(ggplot2)
## Calculate the deciles of the data
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 4), na.rm = T)

## Cut the data at the deciles and create a new factor variable
maacs$no2dec <- cut(maacs$logno2_new, cutpoints)

## See the levels of the newly created factor variable
levels(maacs$no2dec)

g <- ggplot(maccs, aes(logpm25, NocturnalSympt))

## Add layers
g + geom_point(alpha = 1/3)
  + facet_grid(bmicat ~ no2dec, nrow = 2, ncol = 4)
  + geom_smooth(method = "lm", se = F, col = "steelblue")
  + theme_bw(base_family = "Avenir", base_size = 10)
  + labs(x = expression("log" * PM{2.5}))
  + labs(y = "Nocturnal Symptoms")
  + labs(title = "MAACS Cohort")