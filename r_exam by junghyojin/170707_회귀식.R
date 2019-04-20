rm(list=ls())

cars
plot(cars) # 오른쪽으로 올라가는 경향을 보임

model01=lm(dist~ speed,cars) # Intercept : 상수항,  3.932 = 기울기값 // Y=a+bX
summary(model01)

# 귀무가설 H_0: b=0 , H_1: b!=0

# R-squared : 0.65 = 전체 데이터의 65%에 해당하는 데이터가 선형회귀식에 의해 설명된다. 는 의미 



model01$fitted.values
model01$residuals
model01$coefficients
str(model01$coefficients)
write(model01$coefficients, file='eff2.txt') # eff2.txt로 저장하겠다

# 기존에 있던 plot에 오버랩 하기(abline은 이전에 plot이 찍혀 있어야 한다)

abline(model01, col='red') # 무조건 직선 형태 / 
?abline
speed
pred1=predict(model01,newdata = data.frame(speed = c(10,5,21,22)) ) # 선형식에 값 넣어 산출하기, newdata= data가 data.frame 형태로 들어가야한다.

# error 값이 0에 가까울 수로 좋은 것. 잔차의 제곱이 0에 가까울 수록 좋은 모형
# 1