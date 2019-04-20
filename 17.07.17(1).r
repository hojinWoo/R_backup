data=read.csv('svm.csv',header=T)

str(data)
names(data)=c('X','Y')

plot(data,pch=16)
#lm은 직선형태
#wave모형일 때는 지난 시간은 (튜닝하지 않고 default로 함)
#회귀에 대한 것/분류에 대한 것

model0=lm(Y~X,data)
library(e1071)

model1=svm(Y~X,data)
model2=svm(x=data$X,y=data$Y)

pred1=predict(model1,data)

#str(data$X)#함수 호출 시 어떤 type을 지원하는 지 항상 확인 필요
#as.data.frame(data$X)

rmse=function(error){
  sqrt(mean(error^2))
}

rmse(data$Y-model1$fitted)

points(data$X,model1$fitted,col="red",pch='+')

#데이터의 선형을 확인하고자 할 때 svm을 사

#kernel의 형태에 따라 모양이 다르게 나옴
model1_1=svm(Y~X,data,kernel='linear')
points(data$X,model1_1$fitted,col="blue",pch='*')
abline(model0)

#rbf커널-분류형에서 잘 사용함
#가우시안 함수


# perform a grid search
#범위만큼 svm을 돌림, 10(default)*10*7만큼이 생
tuneResult <- tune(svm, Y ~ X,  data = data,
                   ranges = list(epsilon = seq(0,1,0.1), cost = 2^(2:9))
)#최적화 찾는 방법
tuneResult$best.model#최적화 된 모
print(tuneResult)
# Draw the tuning graph
plot(tuneResult)
2^(2:9)
pred2=predict(tuneResult$best.model,newdata=data)
plot(data,pch='/')
points(data$X,model1$fitted,pch='*',col='blue')
points(data$X,pred2,pch='+',col='pink')#튜닝한 결과 ->기존 error도 줄일 수 있도록 최적화

#각각에 대해 rmse가 가장 작은 것을 찾아야 함

tuneResult1 <- tune(svm, Y ~ X,  data = data,
                   ranges = list(epsilon = seq(0,0.2,0.01), cost = 2^(2:9))
) 

print(tuneResult1)
plot(tuneResult1)

#Y : 6일 차
#X : Y 기준 과거 5일간의 데이터

data1=seq(1,500,2)
d1=data.frame()
d1=array(dim=c((500/6),6))
for(i in 1:(500/6)){
  d1[i,]=data1[i:(i+5)]
}#각각의 dimension을 맞춰줘야 함
d1
x=d1[,1:5]
y=d1[,6]

model3=svm(x=x[1:60,],y=y[1:60])
pred2=predict(model3,newdata=x[61:83,])
cbind(y[61:83],pred2)#튜닝을 하지 않아서 안 맞는 경우가 다반수
model4=svm(x=x[1:60,],y=y[1:60],kernel = 'linear')
pred3=predict(model4,newdata=x[61:83,])
cbind(y[61:83],pred3)

library(mlbench)
library(rpart)
data("Ozone")
View(Ozone)
str(Ozone)#factor변수들을 데이터 형으로 변경할 필요가 있음
O2=na.omit(Ozone)
str(O2)
O2$V1=as.numeric(O2$V1)
O2$V2=as.numeric(O2$V2)
O2$V3=as.numeric(O2$V3)
str(O2)

nn=nrow(O2)
train=O2[1:(nn*0.7),]
test=O2[-(1:(nn*0.7)),]
svm_model=svm(V4~.,train,cost=100,gamma=1e-04)#cost,gamma default는 1
rmse(train$V4-svm_model$fitted)

svm_pred=predict(svm_model,test[-4])
cbind(test$V4,svm_pred)
rmse(test$V4-svm_pred)
#cost를 1000에서 100으로 줄이면 rmse가 줄음
#gamma도 1e-04보다 0.1이 더 좋음 --> 튜닝하기 전인데 0에 가깝게 하는 것이 좋음
#kernel에서 차이가 발생하고 있음

#날씨 데이터 활용(또는 시계열 데이터)
data01=read.csv('data_weather.csv',header=T)
View(data01)
data02=na.omit(data01)
dim(data02)
data03=matrix(as.matrix(data02,nrow = 1,byrow=F))#열방향으로 차례대로 들어가
str(data03)

nn1=length(data03)
dd1=array(dim=c((nn1-6),6))
for(i in 1:(nn1-6)){
  dd1[i,]=data03[i:(i+5)]
}
colnames(dd1)=c('V1','V2','V3','V4','V5','Y')
head(dd1)
View(dd1)

plot(1:length(data03),data03)
svm_data1=svm(Y~.,dd1,cost=100,gamma=0.1)

model5=svm(x=dd1[,1:5],y=dd1[,6])
ind=sample(1:nrow(dd1),10,replace=F)
pred6=predict(model5,newdata=dd1[ind,1:5])

cbind(dd1[ind,6],pred6)

library(nnet)
model6=nnet(x=dd1[,1:5],y=dd1[,6],size=2,lineout=T)
#weight 15=2개의 node로 각각 6개의 선(상수 포함)*2 + output에 연결되는 3개의 선(상수 포함)
#학습 후
predict()#신경망은 PC함수 많이 사용함
model6$wts #각각에 대한 weight
model6$fitted.values #예측

#예제
ir <- rbind(iris3[,,1],iris3[,,2],iris3[,,3])
targets=class.ind(c(rep("s",50),rep("c",50),rep("v",50)))
samp <- c(sample(1:50,25), sample(51:100,25), sample(101:150,25))
ir1 <- nnet(ir[samp,], targets[samp,], size = 2, rang = 0.1,
            decay = 5e-4, maxit = 200)
ir1$fitted.values#각 줄다 각 그룹에 들어갈 확률 중 큰 값이 있는 그룹에 들어
test.cl <- function(true, pred) {
  true <- max.col(true)
  cres <- max.col(pred)
  table(true, cres)
}
test.cl(targets[-samp,], predict(ir1, ir[-samp,]))

library(neuralnet)
setRepositories(addURLs=c(CRANxtras="http://www.stats.ox.ac.uk/pub/RMin"))
library(shiny)


#svm
#y : 수치형 => as.numeric() -> 회귀
#y : 범주형 => as.factor()  -> 분류

library(mlbench)
data("Vowel")
str(Vowel)
data1=Vowel
data1$Class=as.numeric(data1$Class)

model10=svm(Class~.,data=data1[,-1],type='C-classification',kernel='sigmoid')
model10$fitted
levels(Vowel$Class)#factor로 바꾸거나 뒤에 직접적으로 값을 넣어줌으로서 분류형으로 할 수 있음 
t1=table(data1$Class,model10$fitted)
sum(diag(t1))/sum(t1)

model11=svm(Class~.,data=Vowel)
t2=table(data1$Class,model11$fitted)
sum(diag(t2))/sum(t2)
  