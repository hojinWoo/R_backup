# Box plot : 최대값, 중앙값, 
# 최소값, Q1, Q3을 그래프화
# boxplot(x, data,  main, xlab, ylab, col)
# data는 데이터프레임을 지정하는 인자


quakes

mag<-quakes$mag
mag

min(mag)
max(mag)

median(mag)

quantile(mag)

boxplot(mag, main="지진 발생강도의 분포", 
        xlab="지진", ylab="지진강도",
        col="orange")

par(mfrow=c(1,1))

mtcars

attach(mtcars)

boxplot(mpg~cyl, data=mtcars, 
        main="자동차 Milage 데이터",
        xlab="Cylinder 수", 
        ylab=" Miles per Gallon")

detach(mtcars)


