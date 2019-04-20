
# 데이터 탐색 과정 필요 : 이상점 있나/없나, ... 특징 걸러내기 > 이후 분석 진행
# 상관관계 파악 > 집단의 특성 파악 위해 평균, 대표치 구하는 방법 실습
# > 흩어진 정도를 나타내는 대표치 구하기 실습 > ... > 표본으로부터 모집단의 특징 예측이 목적
# > 추정/검정 실시
# 3개 집단 이상에 대한 차이 검정 : 분산분석 이용 < 상호작용(교호작용) 유무에 대한 내용 포함
# 회귀분석까지 강의 진행 후, KICT에 올라온 예제들을 풀어볼 예정

# '상관분석 vs 회귀분석' 차이 ★★
# 관계가 있다/없다 > 상관분석(관계성을 따지는 것이 목적)
# 영향을 미친다 > 회귀분석(인과관계)
# 직선 형태로 인과관계를 찾는 기법 > 선형회귀
# 그 중에서도 X의 개수가 하나인 것은 단순선형회귀 / 두개 이상인 것은 다중선형회귀
# 독립변수 : 영향을 주는 변수(X) / 종속변수 : 영향을 받는 변수(Y)
# 다변량 : Y값을 복수개 예측해야 하는 경우 발생 > matrix 형태 이용

# 회귀분석은 가정 有
# (1) 오차항의 분산은 동일
# (2) 오차항은 상호 독립 > 검증 필요 (D-W 통계량 이용)
# (3) ε_i~N(0,σ^2) > 오차항의 흩어진 정도가 달라지게 되면 모양이 물결을 치게 돼
# > 오차항에도 다시 회귀분석을 하게 돼 or 나눠서 오차항은 따로 비모수 처리(?)
# (4) 독립변수 X는 고정된 값 (관측된 그대로 들어와)
# (5) 독립변수 간 서로서로 독립
# > 독립변수들 사이에 인과관계가 존재하는 경우 발생 (다중공선성) > 실제 값보다 과하게 예측되는 경우 발생
# > VIF 함수 이용해서 다중공선성 유무 파악

# 모수통계 : 제약 하에서 최적의 베타값들을 찾는 방법 < 회귀분석

# 결정계수 : 회귀식에 의해서 설명되어지는 변동량 (ybar와 yhat 간의 기울기로 인해) = SSR/SST
# F-value = MSR/MSE
# β_1hat = S_xy/S_xx
# β_0hat = ybar-β_1hat*xbar
# 오차항의 분산 = sigma(y_i-y_ihat)^2/(n-2)
# "회귀"라는 용어의 등장배경 : 모든 데이터는 중심인 평균으로 모이려는 경향이 있다고 해서
# 위의 과정들은 모두 lm() 함수를 이용해서 구할 예정
# 비선형 회귀 > 회귀식에 x^2 포함
rm(list=ls())
data(cars)
plot(cars) # 항상 먼저 plot을 그려봐서 상관관계가 존재하는지를 파악
cor.test(cars$speed,cars$dist) # 귀무가설(ρ_xy=0) 기각 > 상관관계 존재 (ρ_xy=0.8068949)
# y=wx or y=bx 라고 표현을 해야 돼
model1=lm(dist~speed,data=cars)
str(model1) # list 형태
model1$coefficients
summary(model1)
# 회귀계수 값들이 모두 유의함을 확인 가능
# 맨 아래의 F-statistic & p-value 가 이 모형의 타당성을 보여주는 것
# R-squared을 많이 봐 (회귀식이 설명하는 정도)
# 오차항의 독립성, 이상치의 유무, 회귀식의 선형성 파악 필요!

residuals(model1)
#잔차

plot(model1)#그래프 6개 중 4개를 보여줌
plot(model1,which=4)
plot(model1,which=c(1,3))  

library(car)
durbinWatsonTest(model1$residuals)
#오차의 독립성

predict(model1,newdata=data.frame(speed=c(3,7)))
#3과 7이라는 숫자가 나오는 예측 (단순 선형 회귀)


#비선형회귀(triaing vs test)
n=nrow(iris)
sample(n)
set.seed(200)
ind=sample(1:n,n*0.7,replace=T)
train=iris[ind,]
test=iris[-ind,]

model2=lm(Sepal.Length~Sepal.Width+Petal.Length+Petal.Width,data=train)
summary(model2)
durbinWatsonTest(m$residuals)
vif(model2)#다중공정성이 있다는 것은 독립이 아닌 것이므로 제거해야 한다

summary(model2)
cor(train[,2:4])#상관계수가 가장 높은 것을 제거(하나만 있어도 되기 때문)
#가정이 잘못 된 것.... (모양은 나왔지만)
model4=lm(Sepal.Length~Sepal.Width+
            Petal.Length,data=train)

summary(model4)
vif(model4)
#-------------------------------------------------------------------------
#변수 수가 많으면 변수들 중 어떤 변수 선택이 좋을 지 선택 필요
#arc가 더 작아지는 변수를 선택
library(mlbench)
data("BostonHousing")
str(BostonHousing)
m1=lm(medv ~ .,data=BostonHousing)
summary(m1) #*을 통해 유효한 것 여부를 알 수 있음
m2=step(m1,direction = "both")#필요 없는 변수들을 제거해서 최적의 결과 도출
#기존 AIC값보다 각각의 변수가 ±했을 때
#각각의 잔차의 값이 for loop개념으로 변수가 추가 또는 제거 될 때마다
#AIC값들을 나타냄 --> 최적의 모델,,
#최대 선택 변수 범위 지정 원할 시 lm . → 상수/step함수에 scope추가
summary(m2)#최적의 모델에 대한 것들 볼 수 있음
#변수 수가 줄어든 최적의 모형 찾을 수 있음
m3=step(m1,direction = "backward")

m4=step(lm(medv~1,BostonHousing),direction = "forward",
        scope="~crim+zn+chas+nox+rm+dis+rad+tax+ptratio+b+lstat")

library(car)
outlierTest(m4)
o1=outlierTest(m1)
o1$rstudent #잔차 값
o1$rstudent[1]
o2=as.numeric(names(o1$rstudent))
B2=BostonHousing[-o2,]#이상치를 제외한 값들

install.packages('mixlm')
library(mixlm)

pred1=predict(model2,newdata = test)
pred2=predict(model4,newdata = test)

mse1=mean((test$Sepal.Length-pred1)^2)#잔차의 제곱
rmse1=sqrt(mse1)
mse2=mean((test$Sepal.Length-pred2)^2)#잔차의 제곱
rmse2=sqrt(mse2)

c(mse1,rmse1,mse2,rmse2)

#-----------------------------------------------
#dummy변수
nlevels(train$Species) #개수
levels(train$Species) #이름
#dummy1=lm(Sepal.Length~.,data=train)
dummy1=stats::lm(Sepal.Length~.,data=train)#stat이라는 package에서 사용했다는 뜻
summary(dummy1)#자동적으로 n-1개의 dummy변수 생성
#0.05보다 작은 것을 찾아야 함(크면 의미 없음)

#factor level수준을 지정할 수 있음
factor()#level과 lable을 지정할 수 있음
#level확인하는 방법
cbind(test$Species,as.numeric(test$Species))











