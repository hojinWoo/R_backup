#비선형

rm(list=ls())

x=sample(0:(2*pi),1000,replace=T)
x1=seq(0,(2*pi),0.01)#0.01 단계로 값이 나오도록

y=sin(x)
data=data.frame()
for(i in x1){
  e1=rnorm(10,0,1)
  y1=sin(i)+e1
  x2=rep(i,10)
  data1=cbind(x2,y1)
  data=rbind(data,data1)
}
plot(data,cex=0.1)#cex:size 정밀도를 나타
str(y)
#오차 유도
e=rnorm(1000,0,1)
y_e=y+e
y1_e=y1+e1
plot(x,y_e)
#non-linear
non1=lm(y1~x2,data)#y:종속변수,x2 : 독립변수 (사전에 정리 필수)//선형으로 중심선을 찾는 
plot(non1)
line(data$x2,non1$fitted.values,col='red')#추정된 값으로 overlapt그리기
abline(non1,col='blue')

install.packages('e1071')#신경망 machine learning과 관련 기
library(e1071)
sv1=svm(y1~x2,data)#스스로 변수를 찾아서 고차원으로 넘김 // 비선형으로 중심선을 찾는 것
pred1=predict(sv1,newdata = data)
points(data$x2,pred1,col='red',pch='*',cex=0.3)

#
# matrix를 이용한 계산 (y=wX)

# 비선형 > 선형으로 변환하는 과정 많이 해
# 비선형 y=wf(x)

x=sample(0:(2*pi),1000,replace=T)
# 오차항들이 위아래로 흩어질 수 있게 복원으로 뽑아
y=sin(x)
e=rnorm(length(x),0,1)
y_e=y+e
plot(x,y_e)
# 하나의 x값에 따라 골고루 흩어져 있는 모양


runif(1)



x1=seq(0,(2*pi),0.01)
data=data.frame()
for(i in x1) {
  e=rnorm(10,0,runif(1))
  y=sin(i)+e
  x2=rep(i,10)
  data1=cbind(x2,y)
  data=rbind(data,data1)
}
plot(data,cex=0.1)

non1=lm(y~x2,data)
line(data$x2,non1$fitted.values,col='red')
abline(non1,col='blue')
# 비선형인데도 불구하고 모양이 선형으로 구해져 > error 발생
# svm() 함수 이용 > 비선형 데이터 다뤄 (?)
#install.packages('e1071') # 신경망, 머신러닝 등과 관련된 기법들 포함
library(e1071)
str(data)
svm1=svm(y~x2,data)
pred1=predict(svm1,newdata=data)
points(data$x2,pred1,col='red',pch='*',cex=0.3)

points(data$x2,sin(data$x2),col='blue',pch='#',cex=0.2)

non_svm1=lm(y~x2,data)
pred2=predict(non_svm1,newdata = data)

rmse_s=sqrt(mean((data$y-pred1)^2))
rmse_n=sqrt(mean((data$y-pred2)^2))
c(rmse_s,rmse_n)

#다른커널 기법, 튜닝이 안된 상태
svm2=svm(Species~.,train)
pred3=predict(svm2,newdata=test)

t1=table(test$Species,pred3)#앞으로도 자주 사용, 같은 회귀분석인데 안에가 factor형일 때
diag(t1)#대각선 있는 것 추출
sum(diag(t1))/sum(t1)
#이분산인 경ㅇ
y2=data$y-pred1
data3=cbind(data,y2)
svm_e=svm(y2~x2,data3)

pred4=predict(svm_e,data3)
hat_y=pred1+pred2

points(data3$x2,hat_y,col='pink')#이분산에 따른 오차 반영





