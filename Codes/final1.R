require(ggplot2)
require(scales)
require(ggthemes)
require(reshape2)
require(maxLik)
source("E:/其他/研一/Operational Statistics for SAR/Statistics-SAR-Intensity-master/Codes/GammaSAR.R")
source("E:/其他/研一/Operational Statistics for SAR/Statistics-SAR-Intensity-master/Codes/GI0distribution.R")
source("E:/其他/研一/Operational Statistics for SAR/Statistics-SAR-Intensity-master/Codes/KI0distribution.R")
source("E:/其他/研一/Operational Statistics for SAR/Statistics-SAR-Intensity-master/Codes/myread.ENVI.R")
source("E:/其他/研一/Operational Statistics for SAR/Statistics-SAR-Intensity-master/Codes/imagematrix.R")

imagepath <- "E:/其他/研一/Operational Statistics for SAR/Statistics-SAR-Intensity-master/Data/Images/ESAR/"
HH_Complex <- myread.ENVI(paste(imagepath, "ESAR97HH.DAT", sep = ""), 
                          paste(imagepath, "ESAR97HH.hdr", sep = ""))
HH_Intensity <- (Mod(HH_Complex))^2
example <- HH_Intensity[1500:1599,1500:1599]
vexample <- data.frame(HH=as.vector(example))

plot(imagematrix(equalize_indep(example)))
#plot(imagematrix(equalize(example)))
imagematrixPNG(name = "E:/其他/研一/Operational Statistics for SAR/example.png", imagematrix(equalize(example)))
binwidth_complete <- 2*IQR(vexample$HH)*length(vexample$HH)^(-1/3)

ggplot(data=vexample, aes(x=HH)) + 
  geom_histogram(aes(y=..density..), 
                 binwidth = binwidth_complete) + 
  xlab("Intensities") +
  ylab("Proportions") +
  ggtitle("Complete Histogram") +
  theme_few()
ggsave(filename = "E:/其他/研一/Operational Statistics for SAR/HistogramExample.pdf")

ggplot(data=vexample, aes(x=HH)) + 
  geom_histogram(aes(y=..density..), 
                 binwidth = binwidth_complete,
                 col="white") + 
  xlab("Intensities") +
  xlim(0, 200000) +
  ylab("Proportions") +
  ggtitle("Restricted Histogram") +
  theme_few()
ggsave(filename = "E:/其他/研一/Operational Statistics for SAR/HistogramRestrictedExample.pdf")

## Estimation
require(maxLik)

GI0.Estimator.m1m2 <- function(z, L) {
  m1 <- mean(z)
  m2 <- mean(z^2)
  m212 <- m2/m1^2
  
  a <- -2 - (L+1) / (L * m212)
  g <- m1 * (2 + (L+1) / (L * m212))
  
  return(list("alpha"=a, "gamma"=g))
}

estim.example <- GI0.Estimator.m1m2(example, 1)

LogLikelihoodLknown <- function(params) {
  
  p_alpha <- -abs(params[1])
  p_gamma <- abs(params[2])
  p_L <- abs(params[3])
  
  n <- length(z)
  
  return(
    n*(lgamma(p_L-p_alpha) - p_alpha*log(p_gamma) - lgamma(-p_alpha)) + 
      (p_alpha-p_L)*sum(log(p_gamma + z*p_L)) 
  )
}

z <- example$HH
estim.exampleML <- maxNR(LogLikelihoodLknown, 
                       start=c(estim.example$alpha, estim.example$gamma,1), 
                       activePar=c(TRUE,TRUE,FALSE))$estimate[1:2]

