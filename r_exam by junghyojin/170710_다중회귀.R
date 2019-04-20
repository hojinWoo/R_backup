
rm(list=ls())

x=sample(0:(2*pi), 1000, replace = T)
y=sin(x)
e=rnorm(1000,0,1)
y_e = y+e

data=data.frame()
x1=seq(0,(2*pi),0.01)
for(i in x1){
  e=rnorm(10,0,1)
  y=sin(i)+e
  x2=rep(i, 10)
  data1 = cbind(x2,y)
  rbind(data1)
  data =rbind(data, data1)
  }

x2
plot(data,cex=0.1)

non1=lm(y~x2, data)
line(data$x2, non1$fitted.values, col='red') # 안 나옴
abline(non1, col='blue')# abline : 점 찍혀있는 거에 대표 선 시각화(선형)



 ## 비선형 일 경우 line 그리기
install.packages('e1071') # 패키지 설치
library(e1071)
# ?svm(Support Vector Mach)
svm1=svm(y~x2, data) # svm 함수는 y값이 수(num)로 들어가면 회귀식으로 결과를 보여주고, factor값이면 분류값을 보여준다
predict(svm1,newdata = data)

plot(x,y_e)
pred1 = predict(svm1, newdata=data)
points(data$x2, pred1, col='red', pch='*', cex=0.3)


# 이론값과 실험값이 일치하는지 보기
points(data$x2, sin(data$x2), col='green', pch='#', cex=0.4)


non_svm1=lm(y~x2,data)
pred2=predict(non_svm1, newdata = data)

rmse_s=sqrt(mean((data$y-pred1)^2))
rmse_n=sqrt(mean((data$y-pred2)^2))
c(rmse_s,rmse_n)



n=nrow(iris)
set.seed(200)
ind = sample(1:n, n*0.7, replace = F)

train = iris[ind, ]
test = iris[-ind,]


svm2=svm(Species ~.,train)
pred3 =predict(svm2, newdata = test) 

t1=table(test$Species,pred3) # 대각선 보기

#대각선의 있는 값 추출하기
diag(t1)
sum(diag(t1))/sum(t1) # 정확도율 = 대각선 값의 합 / 전체 합


## 등분산이 아닌 이분산으로 ##

data=data.frame()
k1=seq(0,(2*pi),0.01)
for(i in k1){
  e=rnorm(10,0,sample(1:3,1,replace =  T))
  y=sin(i)+e
  k2=rep(i, 10)
  data1 = cbind(k2,y)
  rbind(data1)
  data =rbind(data, data1)
}

plot(data,cex=0.1)

non1=lm(y~k2, data)
line(data$k2, non1$fitted.values, col='red') # 안 나옴
abline(non1, col='blue')# abli

svm3=svm(y~k2, data) # svm 함수는 y값이 수(num)로 들어가면 회귀식으로 결과를 보여주고, factor값이면 분류값을 보여준다
predict(svm3,newdata = data)

plot(k,y_e)
pred1 = predict(svm3, newdata=data)
points(data$k2, pred1, col='red', pch='*', cex=0.3)

y2=data$y-pred1 
data3=cbind(data, y2)

svm_e=svm(y2~k2, data3 )
pred4 =predict(svm_e, data3)
hat_y=pred1 + pred2

?pch
points(x=data3$k2, hat_y, col='green' ,pch='$')
svm_n=svm(y2~k2, data3 )

