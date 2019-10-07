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

#Exponential Distributions
ggplot(data=data.frame(x=c(0, 7)), aes(x=x)) +
  stat_function(fun=dexp, geom = "line", size=2, col="black", args = (mean=1)) +
  stat_function(fun=dexp, geom = "line", size=2, col="red", args = (mean=.5)) +
  stat_function(fun=dexp, geom = "line", size=2, col="blue", args = (mean=2)) +
  theme_economist() +
  theme(text = element_text(size=20)) +
  xlab("x") + ylab("Exponential Densities")

x <- seq(0.1,10,0.1)
d1 <- dexp(x,0.5)
d2 <- dexp(x,1)
d3 <- dexp(x,2)
df <- data.frame(x,d1,d2,d3)
df.melt <- melt(df, measure.vars=2:4)
names(df.melt) <- c("x","Distribution","Density")
ggplot(df.melt,aes(x=x,y=Density,col=Distribution))+geom_line(size=3,alpha=0.7)+theme_few()

#Gamma Distributions
ggplot(data=data.frame(x=seq(10^-3, 5, length.out = 500)), aes(x=x)) +
  stat_function(fun=dgamma, geom = "line", size=2, col="black", args = list(shape=1, scale=1)) +
  stat_function(fun=dgamma, geom = "line", size=2, col="red", args = list(shape=3, scale=1/3)) +
  stat_function(fun=dgamma, geom = "line", size=2, col="blue", args = list(shape=8, scale=1/8)) +
  theme_classic() +
  theme(text = element_text(size=20)) +
  xlab("x") + ylab("Gamma Densities")

x <- seq(0.1,10,0.1)
d1 <- dgamma(x,1,scale=1)
d2 <- dgamma(x,3,scale=1/3)
d3 <- dgamma(x,8,scale=1/8)
df <- data.frame(x,d1,d2,d3)
df.melt <- melt(df, measure.vars=2:4)
names(df.melt) <- c("x","Distribution","Density")
ggplot(df.melt,aes(x=x,y=Density,col=Distribution))+geom_line(size=3,alpha=0.7)+theme_few()

#K distributions
ggplot(data=data.frame(x=seq(0.01, 7, length.out = 500)), aes(x=x)) +
  stat_function(fun=dKI, geom = "line", size=2, col="red", args = list(p_alpha=1, p_lambda=1, p_Looks=1)) +
  stat_function(fun=dKI, geom = "line", size=2, col="blue", args = list(p_alpha=3, p_lambda=3, p_Looks=1)) +
  stat_function(fun=dKI, geom = "line", size=2, col="black", args = list(p_alpha=8, p_lambda=8, p_Looks=1)) +
  theme_classic() +
  theme(text = element_text(size=20)) +
  xlab("x") + ylab("Intensity K and Exponential Densities")

#GI0 distributions
ggplot(data=data.frame(x=seq(0.01, 10, length.out = 500)), aes(x=x)) +
  stat_function(fun=dGI0, geom = "line", size=2, col="red", args = list(p_alpha=-1.5, p_gamma=.5, p_Looks=1)) +
  stat_function(fun=dGI0, geom = "line", size=2, col="blue", args = list(p_alpha=-3, p_gamma=2, p_Looks=1)) +
  stat_function(fun=dGI0, geom = "line", size=2, col="black", args = list(p_alpha=-8, p_gamma=7, p_Looks=1)) +
  theme_classic() +
  theme(text = element_text(size=20)) +
  coord_trans(y="log10") +
  xlab("x") + ylab("Intensity G0 and Exponential Densities")

#assignment3
x <- seq(0.1,10,0.1)
lambda = 1 
d <- dexp(x,lambda)
m1 <- mean(d)
m2 <- mean(d^2)
bias <- m1-m2