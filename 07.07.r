rm(list=ls())

#DATA FRAME ,다른 열에 다른 type이 들어갈 수 있는 구조
a3=data.frame(a=1:7,b=11:17,c=letters[1:7])#다른 type의 vector(numeric구조)들이 섞임
str(a3)

library(xlsx)
g3=read.xlsx('g33.xls',sheetIndex=1,start=2,header=T,encoding = 'UTF-8')
g3=g3[-30,]
g4=g3[-30,]#마지막 줄 삭제
View(g4)
#한 집단이 아닌 이표본인 경우 분산에 대한 test먼저 하고 집단 간 차이 검정을 해야 함

var.test(g4)#var.equal=T/F
t.test#paired=T/F

var.test(extra~group,data=sleep)
var.test(extra~group,data=sleep,conf.level = 0.95)#default
var.test(extra~group,data=sleep,conf.level = 0.90)#유의수준 10%
t.test(extra~group,data=sleep,paired = T,var.equal = T)
t.test(x=sleep,y=sleep2,alternative = c("two.sided"),paired = T,var.equal = T)

var.test(x=sleep[1:10,1],y=sleep[11:20],1)
t.test(x=sleep[1:10,1],y=sleep[11:20,1],var.equal = T,paired = F,conf.level=0.9)#var.equal = T:독립

#실제 전후비교를 하려면 paired=T로 설정/1%유의수준
t.test(x=sleep[1:10,1],y=sleep[11:20,1],var.equal = F,paired = T,conf.level=0.99)
#유의수준이 1%이므로 p-value가 0.01보다 작게 나오므로 기각-> 서로 영향이 있음

#시각화가 가능(실시간), excel만큼 
#spotfire 함수가 아닌 클릭으로 가능 //server에서 가져오다 보니 


g4$q1=mean(g4[,2:7])#행 단위로 for loop나 apply가 필
str(g4)


View(g4)
m1=mean(g4[2,4])
na.exclude(m1)
m1=mean(as.numeric(g4[2,2:7]),na.rm = T)
na.omit(m1)

for (i in 1:nrow(g4)){
  m1=mean(as.matrix(g4[2,2:7]),na.rm = T) #as.numeric으로 하면 안 됨
  m2=c(m2,m1)
}
g4$q1=m2
str(g4)
#↓똑같은 것

#Returns a vector or array or list of values 
#obtained by applying a function to margins of an array or matrix.
g4$q1=apply(g4[,2:7],1,FUN=mean,na.rm=T)#행방향으로 29개의 행을 2열부터 7열까지 더한 것의 평균
g4$q2=apply(g4[,8:13],1,FUN=mean,na.rm=T)
g4$q3=apply(g4[,14:19],1,FUN=mean,na.rm=T)
g4$q4=apply(g4[,20:25],1,FUN=mean,na.rm=T)
#각각 전체의 1/4씩
View(g4)

var.test(g4$q2,g4$q3) #//채택하ㅁ로 분산의 차이가 없음
t.test(x=g4$q2,y=g4$q3,var.equal = T)#//평균으로 해 보니 큰 차이가 존재하지 않는다


#'분산 분석'-------분산의 비를 이용해서 집단 간 평균 차이 검정(3개 이상) /
#귀무가설: 평균 간 차이가 없다(대등)-->분산이 됨 ,평균 값은 0으로//독립, 차이가 없다가 귀무가설
#그룹 내 잔차의 제곱, 그룹 간 잔차의 제곱 || 제곱합
#제곱 합 -->  분산 || F검정 통계량
#(그룹 간 분석/ 그룹 내 분석)>F 이면 귀무가설 기각 ,차이가 크다== 집단 간 차이가 있다(사후감정 실시)

library(MASS)
survey()

#물결 모양 우측에 오는 것은 factor단위(구분을 지을 수 있는 것)여야 함 
model1=aov(Pulse~Exer,data=survey)#운동량(Exer)에 따른 pulse의 차이
summary(model1)#분산분석, Exer! :그룹 간 변수, residuals : 그룹(집단) 간 잔차
#pr(>F)이 5%유의수준보다 작으므로 귀무가설 기각, 집단 간 차이가 존재

model2=aov(Sepal.Length~Species,data=iris)
summary(model2)#종에 따라 꽃받침 길이에 차이가 있다

model3=aov(Pulse~Exer+Smoke,data=survey)
summary(model3)

#교유작용 - 두 집단이 join된 그룹에 대해서도 하고 싶을 때 //==>Exer|Smoke
#분산분석에는 ':'를 사용해야 함 
#회귀분석에서는 '|'를 사용
model3=aov(Pulse~Exer+Smoke+Exer:Smoke,data=survey)
model3=aov(Pulse~Exer*Smoke,data=survey)#같은 표현식
summary(model3)

y~x+x^2#(^2)는 join 된 것//잘못된 표현식
y~x+I(x^2) #==y~x+x2 ,  x2=x^2 //올바른 표현식


#사후검정 (분산 분석된 결과, 변수명이 들어가야 함)
#life.tukey=TukeyHSD(life.aov,"ty",order=T)
tukey1=TukeyHSD(model1,order=T) # 어떤 집단끼리 차이가 있는 지 더 자세히
tukey3=TukeyHSD(model3,order=T)
t3=TukeyHSD(model3,'Smoke') #보고싶은 것 만 볼 때 (filter) 뒤에 쓰면 됨

#reshape2 pakcage -->melt함수 사용 가능
install.packages('reshape2')
library(reshape2)
g5=melt(g4,id=1:25)#앞쪽 ID 고정하고 variable이라는 group에 q1부터 q4를 행으로 넣고
#그 값은 value에 들어감
View(g5)
str(g5)
model21=aov(value~variable,data=g5)
summary(model21)#완전 큰 집단으로 보면 편차가 안 보임

#예제- 시간대별로 차이 보리
View(g3)
g6=melt(g3,id=1)
View(g6)
model22=aov(value~variable,data=g6)
summary(model22)

t2=TukeyHSD(model22,'variable')
str(t2) #앞에 1열의 이름 확인 시에//list구조
aa=t2$variable[,4]#4번째 열에 해당하는 것만 찾을
which(aa<0.05)
t2$variable[aa<0.05,1]

t3=as.matrix(t2$variable)
str(t3)

table(t3[,4]<0.05)
table(t3[,4]<0.5)

which(t3[,4]<0.5) #차이가 존재하는 행번호를 찾을 수 있음
rownames(t3[which(t3[,4]<0.5),]) #해당 조건을 만족하는 행의 이름들을 찾을 수 있음

a=5
a2="a" #scalar
a3=1:3 #하나의 안에 복수개가 배열로 들어가 있음 -- vector
#matrix안에 행 or 열은 vector 구조
a3[2]
str(a3)
#matrix는 vector들이 행과 열로 모여있는데 동일한 data type이여야 함
a4=matrix(1:15,nrow=3)
a5=a4[2,1] #scalar값으로 불러옴
str(a5)
a6=a4[2,]
str(a6)

a7=array(dim=c(3,2,3))
str(a7)
a8=array(2,3)
#data.frame : 행과 열이 있음, 그러나 data type이 다름
a10=data.frame(1:3,rep(1:3),LETTERS[5:7])

a11=a10[2] #data frame구조에서
str(a11)
a11=as.matrix(a10[2])
str(a11)
a12=as.matrix(a10)#3행3열로 들어감, 
str(a12)#동일한 type들이 아님 -> 숫자들이 문자열 type으로 바꿔짐(크다, 작다 개념 X)
#숫자를 사용하려면 numeric으로 바꿔야 하며
#'$'을 통해 각각의 변수 구분 가능


a9=list(a,a2,a3,a4,a6)
aa=unlist(a9)


#iris(data.frame구조)
iris[,c(2,3)]
iris[iris$Sepal.Length>=6.5,] #조건을 만족하는 지 T/F로 return
a13=iris[iris$Sepal.Length>=6.5,]
ab=rownames(iris[which(iris$Sepal.Length>=6.5),])
#data frame은 행 or 열 방향을 선택해서 비교하는 것을 채택해야 함


#machine learning library
install.packages('mlbench')
library(mlbench)
data(Vowel) #data frame구조
View(Vowel)
#소문자 i만 들어간 data추출하기 -->grep 사용, 한 열 안에서 해당 조건의 위치번호--행번호 return
v1=grep('i',Vowel$Class)
V1=Vowel[v1,]

install.packages('car')
library(car) #통계 중 검증과 관련된 부
#분산 분석과 비슷한데 평균이 아닌 분산에 대해 한꺼번에 일관적으로 check(등분산, 이분산 등)
data
leveneTest(Sepal.Length~Species,data=iris)
#귀무가설 : 등분산

#http://archive.ics.uci.edu/ml/index.php data-set
#데이터의 특징을 통해 분석 가능






