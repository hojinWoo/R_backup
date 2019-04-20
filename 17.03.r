# iris만 하면 그것에 대한 데이터만 실행
summary(iris)
# $ 표시는 하위 개념
# species는 몇 번이 있는 지 파악
x=table(iris$Species)
#계속 이용하고 싶다면 변수로 처리할 것, 우측에 변수 처리 되고 결과 값이 변수로 넘어감
#중간 처리를 위해 변수가 엄청 많이 처리 '<-' '->' '<<-' : 전역변수로 설정

x1<-1
2->x2

# 스칼라 구조(값이 1개)/ 벡터(값이 복수개)로
# 마치 array처럼 이지만 연속적으로
x3 = 1:10
# 내가 원하는 값으로 행렬 설정 'c'
x4=c(1,5,3,9)
(y4=c(1,4,5,2)) #값과 변수가 같이 보이는 방법

x4[2]

#앞에는 값, 뒤에는 행 or 열 개수
matrix(1:15,nrow=3) #3행 생성(data는 열방향 먼저 채워짐)

matrix(1:15,ncol=3) #3열 생성

#행과 열이 있는 matrix는 data로 처리 됨
x5=matrix(1:15,ncol=3,byrow=T)#data를 행방향으로 바꾸는 것 (T:true-행, F:false-열)

#tensorflow도 matirx구조로 자동적으로 생성되고 처리됨
#matirx[행,렬,면]
x5[3,2]

x5[2:4,3]

x5[c(2,4),3]
#max row max col 가능
#'-'는 지정한 것의 반대 값들
x5[-c(2,4),3]

#matrix는 안의 데이타 구조가 똑같아야 하ㅓㅁ
#그러나 'dataframe'구조는 열마다 다를 수 있음

#str : 안에 있는 내용 서술
str(iris)
#object구조는 $표시(matrix는 안되나 dataframe구조는 가능)

#통계는 전부 dataframe구조임 --data handling 기법 모두 구조가 중요함

#iris data 파악//
#'data frame' 구조/ 객체 : 데이터 개수 /변수 :행의 개수
#factor 범주에서 3개의 단계로 이루어져 있음

#-----------------------------------------통계 적용---------------------------------------------
#이용하기 위해 정보를 취득하는 것
#집계를 통해 대표 수치를 통해 많은 데이터를 다루기에 용이

#숫자 데이터도 있는데 통계는 어떤 집단이 좋고 나쁜 지 비교가 가능하고 파악을 해야 하는 잣대가 필요
#숫자와 문자의 대표인 '대표치'로 비교(중심-평균(산술평균만이 중요한 것이 아니다), 분산 등에 대한 대표치가 다르다)
#중심 구할 시 평균(산술평균만이 중요한 것이 아니다, ex.학점은 산술평균으로만 구하는 것이 아니다, 가중평균을 적용!!!)
#cf. data 이상치가 존재 시 
x1=c(1,2,3,4,5,4,3,6,7,1000)
sum(x1)/length(x1)
mean(x1)

#빅데이터는 이상치 존재 여부를 항상 따져야 한다 --그렇기 때문에 중앙값을 찾는 경우 존재
sort(x1)
median(x1) #중앙값

#대부분 데이터들이 정규분포의 형태를 따르지 않는다.. 한쪽으로 치우친 경우가 다반사
#그렇기 때문에 대표수치를 통해 정규분포가 아닌 경우에 좋고 나쁨 판단 기준이 필요
#

#자료, 통계학, 모집단
#유한모집단, 무한모집단

sample(1:45,6,replace=F) #T:복원추출, F:비복원추출

ind=sample(1:nrow(iris),150,replace=F) #섞은 대로 가져오는 것

A1=iris[ind,] #뽑힌 순서대로 데이터가 섞임

View(iris)# data set 미리보
View(A1)


#sample2
ind1=sample(1:nrow(iris),nrow(iris)*0.7, replace=F)#70% data만 생성 
#(test로 7:3이나 6:4를 많이 사용) 골고루 들어가서 서로 비교가 가능
train=iris[ind1,] # 행으로 나타내려고 뒤에를 비어둠
test=iris[-ind1,]

#-------------------------sampling기법이 엄청 많음(층하추출 등)--------------------------------------------
#(package가 필요한 경우가 많음)


#기술통계학 : 정리 요약해서 수치적인 특성 분석 ex. summary()
#추측통계학 : 표본으로 통계 -> 의사결정(확률의 개념 사용) 모집단으로부터 역으로 추측

summary(iris)
#동일한 성향이 아닐 수록 흩어짐이 퍼져있고, 1분위수와 3분위수가 중앙값 근처에 없는 경우!
#탐색전 상황에서 기술통계학으로 시각적으로 분석이 필요)

#구간별 히스토그램 가능
hist(iris$Petal.Length) #data가 2개의 group으로 설정 가능

#box-plot
boxplot(iris[,1:4]) #cf)행을 생략하면 모든 행에 대해서 나타난다는 것!!!!!
#median이 검은 선, 1사분위~3사분위를 상자로 표현
#분위수 범위(3사-1사)의 간격 1.5배까지는 범위 안으로 인정하고 그 이상을 벗어나면 이상치로 판단!

#대부분 데이터는 기울기와 단위가 중요,, 가중치가 다르기 때문에 
#두가지의 단위가 동일한 지 중요!!(정규화(표준화)가 꼭 필요~~, 가중치의 영향이 아닌 단위의 영향으로 바뀌는 경우가 생기지 않도록)
#R에서는 "scale"을 통해 정규화가 자동적으로 가능해짐

View(iris)
A2=iris
A2[,1:4] = scale(iris[,1:4])#5열은 종을 나타낸 것이므로
View(A2)
#기술통계학이 분석 전에 꼭 필요


#범주형 자료(질적 자료)
str(iris)

nlevels(iris$Species) #level 확인 가능
levels(iris$Species) #어떤 level들이 있는 지 확인


#도수분포표
library(MASS) #package사용하기 위해 필요할 때마다 library or require 사용해서 memory에 올려야 사용 가능
data("survey")#memory loading// mass안에 'survey' data를 가져오는 방
View(survey)
t1=table(survey$Sex, survey$Smoke)#table을 통해 원하는 정보만 볼 수 있음 //
prop.table(t1) #각각의 전체 숫자를 기준으로 total에 대한 확률을 구해줌!!!! (factor가 table로 들어가야 함)//상대도수
prop.table(t1,1) #행의 합이 1이 되도록
prop.table(t1,2) #열의 합이 1이 되도록


#막대그래프
barplot(t1)






#-------------------------------------기술통계학----------------------------------------------

 plot(iris$Petal.Length, iris$Sepal.Length)

(length(iris$Sepal.Length)*0.1/2)
#절사식 함수,, 절사 평
#150개의 데이터
n=round((length(iris$Sepal.Length)*0.1/2),0) #정수형으로 하려면 마지막에 0 추가

#상위 하위를 자른 나머지 데이터 (각각 8개)
x1=sort(iris$Sepal.Length)
x1[(n+1):length(iris$Sepal.Length)-n] # 범위를 제한!!! length를 col로 한 것//data frame구조
str(x1) #전체 데이터

plot(x1)

#종 모양
hist(rnorm(10000, mean=100,sd=1)) #sd : 표준편차

hist(rnorm(10000)) #평균 0(default)


#상관관계
cor(iris[,1:4])
cor.test(iris$Sepal.Length,iris$Petal.Length) #상관관계 판단 (꽃받침의 길이와 꽃잎의 길)




