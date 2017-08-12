library(segmented)
set.seed(1234)
z<-runif(100)
y<-rpois(100,exp(2+1.8*pmax(z-.6,0)))
o<-glm(y~z,family=poisson)
o.seg<-segmented(o,seg.Z=~z,psi=.5)


confint(o)


library("segmented")
data("down")
View(down)
fit.glm<-glm(cases/births~age, weight=
                 + births, family=binomial, data=down)

print(fit.glm)

fit.seg<-segmented(fit.glm, seg.Z=~age,psi=25)
