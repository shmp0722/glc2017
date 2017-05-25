library(psych)
library(readxl)
x <- read_excel("~/Google Drive/CSFI/glc2017/30-10-6forMatlab.xlsx", sheet = "30-2")

cor01 = cor(x); cor01

(x.eigen = eigen(cor01)$value); x.eigen
plot(x.eigen,type = 'b',xlab = 'eigen value',ylab = 'Component Num',main = 'Scree Plot');abline(h=1,col='red')

fa.parallel(x, fa='pc')
fa.parallel(x,fa = 'both')

result <- factanal(x=x,factors = 3, rotation = 'promax')
