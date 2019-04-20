
# 엑셀 데이터 읽어오기
rm(list=ls())
library('xlsx')

g3=read.xlsx("g3.xlsx",sheetIndex = 1, startRow = 2,header = T,encoding ='UTF-8') # startRow =2 : 2번째 부터 시작
g4 = g3[-30,]  # 30번째 행 제거 
g5 =na.omit(g4)

## 두 집단 간의 검정, 사전 점검 항목

# var.equal = T/F(이 분산 or 동분산)  , paired = T/F (T 인 경우 : 두 집단의 갯수가 같아야 한다), conf.level =0.9(신뢰구간 설정)  

View(sleep)
sleep # extra의 의미 : 잠을 자는 정도, group =1(약 먹기 전), 2(약을 먹은 후)


var.test(extra ~ group, data = sleep) # 동분산
t.test(extra~group, data = sleep, var.equal = T)
t.test(extra~group, data = sleep, var.equal = T, paired =T)

# 기본 데이터를 바탕으로
data(sleep)
var.test(x=sleep[1:10,1], y=sleep[11:20,1], paired = T)
t.test( x=sleep[1:10,1], y=sleep[11:20,1], var.equal =  T,paired = T, conf.level = 0.99)

sleep1=sleep[1:10,]
sleep1$extra2 = sleep[11:20,1]

var.test(x=sleep1$extra, y=sleep1$extra2, paired = T)
t.test(sleep1$extra, sleep1$extra2, var.equal = T, paired =  T)


var.test(x=sleep[1:10,1], y=sleep[11:20,1])
t.test(x=sleep[1:10,1], y=sleep[11:20,1], var.equal =T, paired = T, conf.level = 0.99)


# 기본 데이터 배열을 바꿔서
rm(list=ls())
sleep1=sleep[1:10,]
sleep1$extra2=sleep[11:20,1]

t.test(extra ~ group, x=sleep1$extra, y=sleep1$extra2, var.equal = T, paired =T, conf.level = 0.99)

t.test( extra ~ group, data = sleep, var.equal = T)#그룹이 등분산이고 쌍이 아닐때
t.test( extra ~ group, data = sleep, var.equal = T , paired=T)#등분산이고 쌍으로 볼때
#1그룹은 수면제 1을 먹고 잠잔시간의 차이 2그룹은 수면제 2를먹고 잠잔시간의 차이

sleep1 = sleep[1:10, ]
sleep1$group2 = sleep[11:20, 1]
sleep1
t.test(x=sleep1$extra, y=sleep1$group2, var.equal = T, paired = T)



#######################################################################################################
# 데이터 핸들링 방법

rm(list = ls())

View(g4)
g4$q1= apply(g4[,2:7], 1 ,FUN =mean) # margin : 처리하는 방향(1= 행방향) # FUN = function // g4의 각행의 2열~7열의 평균 
g4$q2= apply(g4[,8:13], 1 ,FUN =mean)
g4$q3= apply(g4[,14:19], 1 ,FUN =mean)
g4$q4= apply(g4[,20:25], 1 ,FUN =mean, na.rm=T) 


var.test(g4$q2,g4$q3 )
t.test(x=g4$q3, y=g4$q2,var.equal = T, paired = F)

str(g4)
a1=g4$X01시
str(a1)  # 데이터 구조가 vector임


a2=g4[1,2:7]
str(a2) # 데이터 구조가 data frame 임 => mean이 처리할 수 없는 구조임(mean은 vector값만 처리할 수 있음)

a2=as.matrix(g4[1,2:7]) #matrix값으로 변환 => vector 값
str(a2)

## 데이터 프레임
a3=data.frame(a=1:7, b=11:17, c=letters[1:7]) # letters : 대, 소문자 영어
str(a3) # a,b = int // c= Factor 




## apply와 같은 거(for문을 통해서)

m2=c()
for( i in 1:nrow(g4)) {
  m1=mean(g4[i,2:7])
  m2=c(m2, m1)
  
}

g4$q1=m2


### 분산분석: H_0= mu_1 = mu_2 ... = mu_n(귀무가설 : 모든 평균이 같다 // H_1: 모두 같은 것은 아니다. => 어느 집단이 차이가 나는지 알아보자)  
# R에 내장된 함수 : aov(:ANOVA)=> 사후분석


# aov는 기본적으로 ' 등 분산'을  가정하고 시작하는것 

#1. survey 
library('MASS')
data(survey)
View(survey)
model1=aov( Pulse ~  Exer  , data=survey) # aov(formula, data ) formula : X(종속변수)  ~ Y(독립변수)( Y :Factor로 되어있는 것, 즉 그룹화 할 수 있는 데이터 형태가 돼야ㅏ함)
summary(model1) # 분산분석표를 보여줌,  SSE = Sum sq, MSE = Mean sQ, Exer(=p-value)와 같은 역할, Exer > p-value : 채택(집단간 차이가 없다)


#2, iris
data("iris")
View(survey)
model2=aov(Sepal.Length ~ Species, data =iris)
summary(model2)


#3. 

model3 =aov(Pulse~Exer + Smoke, data = survey)  
summary(model3)   # F-value = Exer의 " Mean sq / Residuals "

#4. 영향인자가 Join이 되는 경우

model4 =aov(Pulse~Exer + Smoke + Exer:Smoke, data = survey) # Exer : Smoke : join의미  
summary(model4)

## X1 + X2 + X1,X2 = (X1+X2)^2

## X1 + X2 + X3 +  X1,X2 +X2,X3 + X1,X3 + ~~~~~~~~~~~~~~~~~~  = (X1+X2+X3)^2

model5 =aov(Pulse~Exer + Smoke + Exer*Smoke, data = survey) # Exer * Smoke 
summary(model5)


#x2=x1^2

#y~x1+x2
#y~x1+I(x1^2)


### 사후검정
?TukeyHSD
t1=TukeyHSD(model1,"Exer" )

# Exer의 Freq, None, some 에 해당하는 것들의 집단간 분석 , p adj : 집단간 차이를 알아볼 수 있는 지표 Some-Freq : 는 pvalue보다 작아서 차이가 난다고 할 수 있음
# lwr ,upr : 신뢰구간의 하한, 상한 // diff = 집단 간 pulse 평균의 차이



## reshape2 : 데이터 재구성하기
install.packages('reshape2') # 이걸해야 melt를 쓸 수 있음
library(reshape2)
?melt

# g4중에 q1~q4열만

g5=melt(g4,id=1:25) # id를 제외한 나머지를 하나로 묶어버림 , melt( data  ,  고정할 구역   )
View(g5)
str(g5) #varible = Factor 형식임을 확인


model21=aov( value~variable ,data =g5) # value = 평균값
summary(model21)


# 시간대 별 
g6=melt(g4[,1:25], id=1)
View(g6)
model22=aov( value~variable ,data =g6) # value = 평균값
summary(model22)
t2=TukeyHSD(model22,'variable') # variable 값의 분석
str(t2) # list구조임을 str로 확인할 수 있음

# 매트릭스 형태로 변환하기 
t3=as.matrix(t2$variable)
str(t3)

t3[,4] <0.05
table(t3[,4] <0.05)

table(t3[,4] <0.5)
which(t3[,4] <0.5)

# 이름 찾기
names(t3[which(t3[,4] < 0.5), ]) # names는 열이름 , 우리는 '행' 이름을 해야함
rownames(t3[which(t3[,4] < 0.5), ]) # 행 이름을 찾아줌

## ㄴㄴㅇㄹㄴㄹㄴㅇ##




