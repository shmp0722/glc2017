# add path
library(psych)
library(readxl)

# load data
x <- read_excel("~/Google Drive/CSFI/glc2017/30-10-6forMatlab.xlsx", sheet = "30-2")

# 
cor01 = cor(x); cor01

## 30-2
# eigen value
(x.eigen = eigen(cor01)$value); x.eigen
plot(x.eigen,type = 'b',ylab = 'eigen value',xlab = 'Component Num',main = 'Scree Plot 30-2');abline(h=1,col='red')

# number of factors
PM =fa.parallel(x,fa = 'both')

nfactors(x,rotate = 'promax') 
#result <- factanal(x=x,factors = , rotation = 'promax')
#print(result)

#result <- factanal(x=x,factors = 9, rotation = 'promax')
#print(result)

pm = fa(x,nfactors = PM$nfact,rotate = "Promax",	fm="ml")
print(pm)


## 24-2
x <- read_excel("~/Google Drive/CSFI/glc2017/30-10-6forMatlab.xlsx", sheet = "24-2")

cor01 = cor(x); cor01

(x.eigen = eigen(cor01)$value); x.eigen
plot(x.eigen,type = 'b',xlab = 'eigen value',ylab = 'Component Num',main = 'Scree Plot 24-2');abline(h=1,col='red')

optimnum=fa.parallel(x,fa = 'both')

result <- factanal(x=x, factors = optimnum$nfact, rotation = 'promax')
print(result)

pm = fa(x,nfactors = optimnum$nfact,rotate = "Promax",	fm="ml")
print(pm)

## combined  24-2, 10-2
x <- read_excel("~/Google Drive/CSFI/glc2017/30-10-6forMatlab.xlsx", sheet = "Cluster 24-2,10-2")

cor01 = cor(x); cor01

(x.eigen = eigen(cor01)$value); x.eigen
plot(x.eigen,type = 'b',xlab = 'eigen value',ylab = 'Component Num',main = 'Scree Plot 24-2');abline(h=1,col='red')

optimnum=fa.parallel(x,fa = 'both')

result <- factanal(x=x, factors = optimnum$nfact, rotation = 'promax')
print(result)

pm = fa(x,nfactors = optimnum$nfact,rotate = "Promax",	fm="ml")
print(pm)


F <- read_excel("~/Google Drive/CSFI/glc2017/30-10-6forMatlab.xlsx", sheet = "30-2,10-2")
summary(F)

sd(F$`age(30)`)
sd(F$`MD24-2`)
sd(F$`VFI(30)`,na.rm = T)

