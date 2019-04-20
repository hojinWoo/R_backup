rm(list=ls())
options(digits = 3) #소수점 이하 4째 자리까지만 생성
#각각에 대해 의미와 무엇을 나타내는 건지 안다면 됨

#1. 난수 생성 및 분포 함수(강제 난수 생성)
#난수 발생 시 선제 조건(point to seed) - 동일한 포인트점
set.seed(100) #난수 발생 전 point점을 동일하게 하기 위해 꼭 사전작업 필
#(↑바로 다음에 만드는 거에만 해당)
x1=rnorm(100,mean=0,sd=3) #평균이0, 분산이 10인 150개의 난수 발생(정규분포)
plot(density(x1))
hist(x1)

plot(density(rnorm(10000,0,10)))
mean(x1)
median(x1) #중앙값이 실제 평균보다 왼쪽에 있음(난수 생성 개수가 작기 때문)

quantile(x1,0.5)#알고 싶은 데이터의 %에 해당하는 위치를 알 수 있음
quantile(x1,c(0.25,0.75))

#poisson distribution
dpois(3,1)#람다가 3

#모수적인 방법 vs 비모수적인 방법
#machine learning 이전에는 모수적인 방법 - 사전 가정을 통해 제약을 걸고 그 안에서 계산하고 error를 최소화 하기 위해 함
#machine learning을 통해 비모수적인 방법을 할 수 있게 됨(순수 data간의 방법을 통해 비교)
#supervice learn vs unsupervice learn
#supervice learn(지도학습) -target 값을 알고 있는 상태에서 가중치 찾기
#unsupervice learn(비지도학습) - 순수 x간의 간격 찾기(제약 X)
#요즘은 한 쪽만 채택하는 것이 아닌 두 가지를 융합해서 사용

#군 집합-y값이 없는 상태에서 x값의 중심점을 찾아서 새로운 data가 얼마나 거리가 떨어져 있는 지 
#(가운데에 항상 평균이 필요, 모두 중심점과 연결하는 것)



q1=quantile(1:10,c(1/4,3/4))
str(q1)
q=q1[2]-q1[1]


#최빈값


sample(1:10,5,replace=T,prob=1:10)#prob는 가중치(1은 1, 2는 2...10은 10의 가중치)

ind1=sample(nrow(iris),nrow(iris),replace = F)
A1=iris[ind1,]
n1=nrow(iris)
train=A1[1:(nrow(iris)*0.7),]
test=A1[((nrow(iris)*0.7)+1):nrow(iris),] #== test=A1[-1:(nrow(iris)*0.7),]
#같은 방법
ind2=sample(n1,n1*0.7,replace=F)
train1=iris[ind2,]#이미 70퍼만 sample이므로 행에는 ind2만 가도 됨
test1=iris[-ind2,]
#다른 방법-150개의 데이터가 각각 1번 방, 2번방에 들어감(가중치 영향 받음)
ind3=sample(2,n1,replace=T,prob=c(0.7,0.3))#각 그룹별로 할 것
train2=iris[ind3==1,]
test2=iris[ind3==2,]

#충화 임의추출(strarified random sampling)
#install.packages("sampling")
library(sampling)
x=strata(c("Species"),size=c(3,3,3),method="srswr",data=iris)#srswor:비복원, srswr:복원
getdata(iris,x)#추출한 거에 대해 알 수 있음

#일관적으로 넣을 때
rep(1,3)#1을 3번 반
rep(c(3,7),c(3,2))#각각에 대해서 해당, 3은 3번 7은 2번 반복
rep(c(3,7),times=3)#== rep(c(3,7),3
rep(c(3,7),each=3)
rep(1:10,length.out=5) #앞의 것 부터 순서대로 길이만큼만(반복 가능)
rep(1:10,length.out=15) #길이가 넘으면 다시 처음부터 

A1=iris
A1$Species2=rep(1:2,75)
strata(c("Species","Species2"),size=c(2,2,2,2,2,2),method="srswr",data=A1)
library(doBy)
sampleBy(~Species+Species2,frac=0.3,data=A1)

#계통추출(systematic sampling)
d1=data.frame()
for(i in seq(sample(1:10,1),150,10)){   # 10만큼의 간격으로 150까지
  d2=iris[i,]
  d1= rbind(d1,d2)#data frame구조는 rbind를 사용
} 
d1


#분할표 -->> 교착표를 만드는 기본적인 방법 (최빈수를 만들기 위해 필요)
#data 특징을 살펴야 함(data frame) or c함수를 통해 공간을 만들어서 넣어야 함

xtabs()
margin.table()
prob.table #list구조로 됨

#확률을 알면 기대도수를 알 수 있
#x=np


#독립성검정!!!(chi-square test) (귀무가설 해설이 절대적!)
#chi square을 통해 구간 안에 들어가면 독립, 안 들어가면 독립이 아님
library(MASS)
data(survey)
xt=xtabs(~Sex+Exer, data=survey)
ch1=chisq.test(xt)
#p-value가 채택되면(0.05보다 크면) 독립인 것(성별과 운동량은 독립이다) - 빈도만으로 결과 도출
#sample수가 작으면 안 좋음

#cf.나중에 활용하고 싶으면 항상 변수로 해 놓을 것


#Fisher's exact Test //sample수가 작아도 보정이 가능
xt=xtabs(~W.Hnd+Clap, data=survey)
chisq.test(xt)
fisher.test(xt)#1e-0.4는 0.05보다 작아서 기각되고 --> 독립이 아니

#McNemar Test // 똑같은 대상에 대해 사건 전후의 경향이 어떻게 되는지









  
  
  
  