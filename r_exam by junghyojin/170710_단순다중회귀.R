# 상관분석 : 관계가 있다, 없다의 유무(상관관계로는 독립변수, 종속변수를 알 수 없다. 즉, 회귀식을 도출해낼 수 없다. )

# 회귀분석 : 인과관계가 명확하다(상관관계가 명확한게 아님 ! by 자격증 시험문제)


## 모수통계 : 여러 제약(가정) 하에서 값을 찾는 것을 의미한다. 

  #### 회귀분석 ####

  #기본가정 : 오차항은 평균이 0이며 분산은 시그마 제곱인 정규 분포를 따른다.(=등분산)
    

#1. 단순회귀분석 = y에 영향을 주는 x 인자가 한 개

cars
plot(cars) # 대략적인 관계, 경향성을 보기 위함
cor.test(cars$speed,cars$dist) # 기본적으로 p-value를 체크해줄 것, cor=0.8 양의 상관관계가 있다

#y=bx 형태로

# 관계를 보기 위해서 
model1 = lm( dist ~ speed   ,data = cars)


# list형태로 만들어지게 됨
model1$coefficients # model1의 회귀계수 
# Intercept = 상수항(a) , speed = x의 계수(b)  
  summary(model1) # R-squared = 0.65 : 전체 데이터의 65%를 설명하고 있다.  
  
  # 잔차 검정
residuals(model1) # y_hat - y =residuals 
plot(model1) # 잔차가 위아래로 분포되어있고, 정규분포 형태로 나와야 기존 '가정'(오차항은 평균이 0인 정규분포를 따른다) 이 적합한 것이다. 
# 맨 마지막에 Cook's distance 가 나온다. Outlier를 구분짓는 것. (점선 상단 영역안에 있는 것은 이상치로 판단)

plot(model1, which = 1:6 ) # which = 1:6 의 의미는??

# 오차의 독립성 검정 : 잔차에 대한 "Durbin-Watson" 통계, 상한보다 크면 오차는 서로 독립적, 하한보다 작으면 서로 양의 상관관계 
# 가이드 라인(독립변수 개수 & 해당 상,하한 ) : 1개 (1.65, 1.69), 2개 =(1.63, 1.72), 3개(1.61, 1.74) 4개 =(1.59,1.76), 5개 = (1,57,1.78) # 범위안에 들어가도 OK!, 상한보다 크면 Best 
guideline=c("1개: (1.65,1.60)", "2개: (1.63,1.72)", "3개:(1.61, 1.74)", "4개:(1.59,1.76)", "5개:(1,57,1.78) ")
write(guideline, file='Durbin-Waston_guideline.txt')

install.packages('car')
library(car)
# 오차끼리의 독립성 검정 시 사용하는 함수
durbinWatsonTest(model1$residuals) # 1.67 => 완전한 독립은 아니지만, 범위 안에 들어가기에 상관관계가 크지 않음
str(model1)

# 예측 
predict(model1,newdata = data.frame(speed = c(3,7)))

  ##2. 다중회귀분석 

#case1. 실수형 데이터 

n=nrow(iris)
set.seed(200)
ind = sample(1:n, n*0.7, replace = F) # 105개의 데이터 

train = iris[ind, ]
test = iris[-ind,]


model2=lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width , train)
summary(model2)

plot(model2) # 가정이 맞는지 확인하기 위해 검토
durbinWatsonTest(model2$residuals) #3개(1.61, 1.74) 1.74보다 크기 때문에 완전 독립이라 볼 수 있음


# 다중 공선성(독립변수끼리 독립이 아니다 , 관계가 있다)
vif(model2) # 10보다 크면 다중 공선성에 문제가 있다고 판단한다.(= 독립변수들 간의 독립이 아니다, 연관관계가 있다 )
# 단, 이 때 10이 넘는 것을 모두 제거하면 문제가 발생하기 때문에 하나만 제거!

model3= lm(Sepal.Length ~ Sepal.Width , data= train)
summary(model3)
plot(train$Sepal.Length, train$Sepal.Width)
abline(model3, col='red') # 얘는 왜 안그려지는 거임????



cor(train[,2:4]) # 4개 다하려고 했는데 Petal.Width & Petal.Length 의 상관관계가 너무 높아서 하나 제거
model4= lm(Sepal.Length ~ Sepal.Width + Petal.Length, train) # Petal.Width 제거(상관관계가 높은 거)
summary(model4)




## 변수선택

#1. 단계적 변수 선택

#1-1 전진 선택법 : 모델을 가장 많이 개선시키는 변수를 하나씩 넣는 것 (단, 한 번 집어넣으면 제거하지 못한다 )

#1-2 변수 소거법 : 전체(Full 모형)에서 영향력이 없는 변수를 하나씩 빼가는 방식

#1-3 단계적 방법 : Full 모형에서 시작, 전진 선택법과 변수 소거법을 혼합한 방식


library(mlbench)
data ( BostonHousing )
View(BostonHousing)
m = lm(medv~., data = BostonHousing ) # "~." : 모든 변수들
str(m)
summary(m)
# summary를 통해 필요없는 변수 판단( '*' 없는 거) => 제거하고 싶음 => step 함수 이용


# 단계적 방법
m2= step (m, direction ="both") # AIC = 1589.64 보다 작은 값을 제거(age) -> (indus)제거 -> AIC보다 작은 값이 없을 경우 stop(=최적)
# m2에 최적의 모형이 들어가 있는 것임. 

summary(m)
summary(m2) # 모델 m과 결과값은 비슷하지만, m2가 변수가 더 적음 => 더 good! 


m3= step(lm(medv~1, BostonHousing),direction = "forward",scope = "~ crim + zn + chas + nox + rm + dis + rad + 
    tax + ptratio + b + lstat") # medv ~1 : 영향을 주는 게 상수항 , scope = 집어넣을 변수 


## 이상치(Outlier) 유무 검사 및 제거 ##

outlierTest(model1) #Bonferonni p-value가 0.05보다 작은 경우 outlier라 할 수 있음



o1=outlierTest(m) # 이상치 3개 존재 
o2=as.numeric(names(o1$rstudent))

B2=BostonHousing[-o2,] # 이상치 제거


install.packages('mixlm')
library(mixlm)

pred1=predict(model2, newdata = test)
pred2=predict(model4, newdata = test)

(test$Sepal.Length - pred1)^2 # 잔차의 제곱 

mse1=mean((test$Sepal.Length - pred1)^2)
rmse1= sqrt(mean((test$Sepal.Length - pred1)^2))

mse2=mean((test$Sepal.Length - pred2)^2)
rmse2= sqrt(mean((test$Sepal.Length - pred2)^2))

c(mse1, mse2, rmse1, rmse2) # rmse가 작은 쪽 선택




 ################################################################################

## 더미변수
# y= a + b1*x1 + b2*x2 + b3*x3 + E 
# Factor 형태는 선형(lm )식에 넣을 때 때, 자동적으로 더미변수를 생성시킴. iris$Species에서는 레벨이 세개이다. 따라서 변형될 때 1,2,3 이 되는데 이것이 진짜로 곱해지는 게 아니라 더미변수로 연결이 됨. 
?stats
d1=stats::lm(Sepal.Length ~., train)
summary(d1) # Species1, Species2가 생김

nlevels(train$Species)
levels(train$Species)


cbind(test$Species,as.numeric(test$Species))

d3=lm(Sepal.Length ~., iris)
summary(d3) # p-value <0.05 이면, 기각이기 때문에 앞에 가중치(Estimate)가 붙게 된다는 것이다. 
 
#Sepal.Length = 1.58891 + Sepal.Length * 0.49589 + Petal.Length * 0.8292 + Petal.Width * (-0.31516 ) + { Species(setosa) * 0.58235 + Species(versicolor) * -0.14121 }
#  { Species(setosa) * 0.58235 + Species(versicolor) * -0.14121 } 에서 두 변수는 연속형이 아니라 '1' or '0'의 값을 갖는 더미변수 이다.   
# 총 세개의 회귀식이 나온다. 이는 회귀식을 group에 종류별로 더 세분화 시킨 것이다



 ### 다중회귀분석 ### 









