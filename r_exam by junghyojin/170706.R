#7-6
rm(list=ls())

#난수생성 및 분포함수
options(digits = 3) #소수점 넷째짜리까지 나옴
set.seed(100) #난수발생시키는 포인트 점을 지정함(정수형으로 지정하며 난수발생전에 해야함)
x1 = rnorm(100, mean =0, sd=3)
plot(x1)
hist(x1)

#막대그래프를 밀도함수로 전환
plot ( density ( rnorm (1000000 , 0, 10) )) #평균 0 표준편차 10이고 랜덤으로 1000000개뽑은 결과를 밀도 형태 보여줌
#안에 면적이 1이되도록 생성

#분위수
mean(x1)
var(x1)
median(x1) #실제보다 약간 왼쪽으로 나타남
quantile(x1, 0.5 )#데이터, 알고싶은 위치 quantile(데이터, 원하는 위치)
quantile(x1, c(0.25, 0.5, 0.75)) #극단치 찾아낼때 많이 활용
quantile(x1,c(0.05,0.95))


#다섯가지 수치 요약(최소, 제 1사분위, 중앙 3사분위, 최대)
fivenum(x1) 
summary(x1) #위에꺼에 평균만 추가

#IQR 사분위 범위 제 3사분위수 - 제1사분위수
IQR(x1)

q1 = quantile (1:10 , c(1/4, 3/4))
str(q1) #벡터이기 때문에 대괄호 하나씩만 넣어줌
q1[2] - q1[1]

#포아송분포 dpois(n, 평균값(λ))
dpois(3,1)

#단순임의추출
sample(1:10, 5) #1:10에서 10만쓰면 자동으로 1~10 또는 데이터 셋을 사용해도 ok
sample (1:10 , 5, replace =TRUE , prob =1:10) #replace : 복원추출, prob : 가중치


#방법1
ind1 = sample(nrow(iris), nrow(iris), replace = F) #비복원 추출 F
A1 = iris[ind1,] #기존의 데이터를 섞는 경우 이런방법 사용
A1
n1 = nrow(iris)
train = A1[1:(n1*0.7), ]
test0 = A1[((n1*0.7)+1) :n1, ] #test 표현하는 두가지 방법
test1 = A1[-(1:(n1*0.7)), ]

#방법2
ind2 = sample(n1, n1*0.7, replace = F)
train1 = iris[ind2, ]
test2 = iris[-ind2, ]

#방법3
ind3 = sample(2, n1, replace = T, prob = c(0.7, 0.3)) #T복원추출
train2 = iris[ind3 == 1, ] #1그룹 가중치가 0.7로 있어서 1에 해당하는 그룹만 뽑아냄
test3 = iris[ind3 == 2, ]
table(ind3)

#층화임의추출
install.packages ('sampling')
library(sampling)
?strata
x <- strata (c("Species"), size =c(3, 3, 3) , method ="srswor", data = iris ) #srswor 비복원 srswr 복원 
x     #결과는 위치값이 나옴 결과값 stratum은 원래 층의 번호
getdata (iris , x) #위치값에 따라서 원래 데이터 가져옴 : "getdata(data, m)" 구조

strata (c("Species"), size =c(3, 1, 1) , method ="srswr", data = iris ) #복원추출에 각 층에서 뽑히는 변수 다르게지정

#rep함수
rep(1:2,3) #앞에있는걸 뒤만큼 반복
rep(c(3,7), times = 3) #여기는 each가 아니라 times = 3으로 들어갔던거
rep(c(3,7), c(3,2)) #결과는 33377
rep(c(3,7), each = 3)
rep(1:10, length.out = 5) #앞에부분 반복 결과가 10이어도 결과 길이는 5개만 보여달라
rep(1:10, length.out = 15)#앞에부분 반복 후 결과가 15보다 작으면 처음부터 다시 반복
rep(1:10, length.out = 15, each = 5) #length.out과 each가 한 함수안에서는 사용불가

rm(list = ls())
iris
iris$Species2 =rep(1:2,75)
iris $ Species2 <- rep (1:2 , 75) #2그룹에는 1과 2가 각각 75개씩 들어가는데 이게 원래 
#species 각각 그룹에(setosa, versicolor, virginica 마다) 1, 2가 들어가서 총 나올 수 있는 그룹의 수는 6개 나오게 된다
strata (c("Species", "Species2"), size =c(2, 2, 2, 2, 2, 2) , method ="srswr", data = iris )
#각 여섯개 그룹마다 2개씩 뽑아서 총 12개의 샘플이 나오게 되고 wr이라서 복원추출이 된다.
?getdata
#위 내용 다시 반복
A2 = iris
A2$Species2 <- rep(1:2, 75)
strata (c("Species", "Species2"), size =c(1,1,1,1,1,1) , method ="srswr", data = A2 )


seq(sample(1:10,1),150,10)

# 샘플을 기준에 의해 추출하는 방법
library(doBy)
sampleBy( ~ Species + Species2, frac = 0.3, data = A2) # formula = ~ Species + Species2 : 종1 & 종 2에 의해 추출&정렬           frac = 데이터에서 뽑을 비율
sampleBy( ~ Species ,frac = 0.3, data = A2) # frac = 데이터에서 뽑을 비율
#계통추출
d1 = data.frame()#1~10 중 한 숫자를 랜덤으로 선택해 10만큼 간격을 주고 숫자를 뽑는데 150까지
for(i in seq(sample(1:10, 1), 150, 10)){
  d2= iris[i, ] #iris의 행 인덱스에 맞는 숫자를 추출한 데이터가 d2인데
  d1= rbind(d1, d2) #계속해서 행으로 데이터를 쌓고 싶어서 rbind 이용 기존 d2에 d1을 계속 쌓음
} 

d1 = data.frame()#1~10 중 한 숫자를 랜덤으로 선택해 10만큼 간격을 주고 숫자를 뽑는데 150까지
for(i in seq(sample(1:10, 1), nrow(iris), 10)){
  d2= iris[i, ] #iris의 행 인덱스에 맞는 숫자를 추출한 데이터가 d2인데
  d1= rbind(d1, d2) #계속해서 행으로 데이터를 쌓고 싶어서 rbind 이용 기존 d2에 d1을 계속 쌓음
} 

#분할표 : table()이용 몇번 나왔는지
table (c("a", "b", "b", "b", "c", "c", "d"))

d <- data.frame (x=c("1", "2", "2", "1"), y=c("A", "B", "A", "B"), num=c(3, 5, 8, 7))

table(d$x, d$y)
xtabs( ~x+y, data = d) #~뒤에 분류하고 싶은 변수 ~앞에 아무것도 없으면 빈도수 ~앞에 한 변수가 나오면 그 값에 대한 집계
d1 = rbind(d,d)
table(d1$x, d1$y)
xt = xtabs(num ~x+y, data = d1) #여기서는 x,y에 대해서 num에 대한 합계를 나타냄

margin.table(xt) #margin() 이걸하려면 미리 교차테이블이 있어야 가능 그냥 xt는 전체에 대한 합계
margin.table(xt,1)# 1을 넣으면 행방향에 대한 합
margin.table(xt,2)#2를 넣으면 열방향에 대한 합
prop.table(xt) #전체합계에서 각 항목당의 비율
prop.table(xt,1) #행당 합을 1로 계산했을때 비율
prop.table(xt,2) #열당 합을 1로 계산했을때 비율

tot = sum(xt)
p_xt=prop.table(xt)
str(p_xt) #결과값 리스트구조

tot*p_xt[[1]][1] #이렇게 하면 각각 원래 값을 돌릴 수 있

#독립성검정 ho : 독립이다 h1 :독립이 아니다.
library ( MASS )
data ( survey )
View(survey)
xt = xtabs(~Sex + Exer, data = survey)
chi1 = chisq.test(xt) #테스트를 하려면 빈도데이터
chi1
str(chi1)
chi1$statistic #카이스퀘어 통계량 가지고오는 함수

#피셔의 정확검정
xt2= xtabs(~ W.Hnd + Clap, data = survey)
chisq.test(xt2) #카이제곱 값 정확하지 않다고 경고가 뜸
fisher.test(xt2)

#맥니마 검정(전후 변화에 대한 검정)
ho : 독립이다. 전부 변화 차이가 없다 h1 :차이가 있다.

#적합도 검정(데이터가 분포를 따르는지 보기 위해서)
table(survey$W.Hnd)
chisq.test ( table ( survey $ W.Hnd ), p=c(0.3 , 0.7))
#h0:분할표와 같다. 0.3,0.7의 확률이다 h1:아니다 유의수준 0.05에서
#p값이 매우작기 때문에 귀무가설을 기각할 수 있다. 0.0,0.7의 확률이 아니다
t1 = table(survey$W.Hnd)
str(t1) 
t1[1]
t1/sum(t1)

#Shapiro-Wilk Test 표본이 정규분포로부터 추출된 데이터인지 검정하는 방법
#h0: 정규분포다 h1:아니다
shapiro.test ( rnorm (1000) )

#Kolmogorov-Smirnov Test 비모수검정 두 표본이 동일한 분포로 부터 나온건지
ks.test ( rnorm (100) , rnorm (100,5,3) )
h0: 두표본이 동일한 분포이다. h1: 아니다

#QQPlot 자료가 특정분포를 따르는지 검토하기 위해/ 시각적으로 확인
x <- rnorm (1000 , mean =10 , sd =1)
qqnorm (x) #데이터의 분위수를 파악
qqline (x, lty =2)#선스타일 지정(lty 2는 점선)해서 선을 그려줌 그전에 qqplot이 있어야 선을 그리는게 가능
#경향성 확인

x1 <- rcauchy (1000)
qqnorm (x1) #norm이 붙어있으면 정규분포가 맞는지 확인/ 결과가 대각선이아니라 일직선상임. 그럼 정규분포 따르지 않음
qqline (x1, lty =2)

#상관계수
#피어슨 상관계수
cor( iris $ Sepal.Width , iris $ Sepal.Length )
cor( iris [ ,1:4])
symnum ( cor( iris [ ,1:4]) )

#스피어만 상관계수 : 두 데이터의 실제값 대신 두 값의 순위를 사용해 상관계수를 비교
x <- c(3, 4, 5, 3, 2, 1, 7, 5)
rank ( sort (x))

#켄달의 순위 상관 계수 : 순서쌍 데이터 순위를 매겨서 각각 다음 순위보다 커지는지 작은지 그 쌍을 비교해서
#같이 커지면 cordant 한쪽만 커지면 discordant를 찾아서 각 개수들의 비교를 통해서 cordant가 많다면 같이 커지고 
#있다는걸을 알 수 있음. 원본데이터를 오름차순인지, 내림차순인지 판단해서 해석을 하면 된다.

#상관계수검정
cor.test (c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5) , method ="pearson")
cor.test (c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5) , method ="spearman")

#추정 및 검정
ss1 = survey[survey$Sex == 'Male' , "Height" ]
m1 = survey[survey$Sex == 'Male' ,  ]
f1 = survey[survey$Sex == 'Feale' ,  ]

ss2 = na.omit(ss1)
mean(ss2)

t.test(x=ss2, mu= 173.5) #h0:평균신장은 173.5이다 h1: h0이아니다
t.test(x=ss2, mu= 178)
#-----------------------------------------------------여자
ss3 = survey[survey$Sex == 'Female' , "Height" ]
length(ss3)
ss4 = na.omit(ss3)

mean(ss4)
t.test(x=ss4, mu=165)

ss5 = na.omit(survey[survey$Sex == 'Female' , "Height" ])
length(ss5)
#----------------------------------------------------------
#두가지 한번에 검정
var.test(x=ss2, y=ss5) h0: 등분산이다. h1: h0이아니다. 
t.test(x=ss2, y=ss5, var.equal = F, paired = F) #paried는 전후 비교나 쌍에 대해서 분석하는것
#h0:남녀간의 키가 동일하다 h1:h0 이 아니다. t.test하기전에 미리 na값을 제거해야함

sleep
var.test( extra ~ group, data = sleep ) #결과 p값 0.7이라서 등분산이다
t.test( extra ~ group, data = sleep, var.equal = T)#그룹이 등분산이고 쌍이 아닐때
t.test( extra ~ group, data = sleep, var.equal = T , paired=T)#등분산이고 쌍으로 볼때
#1그룹은 수면제 1을 먹고 잠잔시간의 차이 2그룹은 수면제 2를먹고 잠잔시간의 차이

sleep1 = sleep[1:10, ]
sleep1$group2 = sleep[11:20, 1]
sleep1
t.test(x=sleep1$extra, y=sleep1$group2, var.equal = T, paired = T)
#h0:차이가 없다, h1: 차이가 있다 수면제 2를먹고 수면시간이 더 늘어났다.

#공공데이터

gg1=read.table('clipboard', header =T )
gg1
#시간대별 1시, 4시 차이비교
var.test(gg1$X01시, gg1$X04시) #p값 0.8로 등분산 전국적으로 시간대별 비슷하다~
t.test(x=gg1$X01시, y=gg1$X04시, var.equal = T, paired = T) #쌍으로 보는게 아니라 시간대별 P값 0.9라서 차이없다
#쌍으로 봐도 지역별 1,4시 차이가 없다

var.test(gg1$X01시, gg1$X07시)
t.test(x=gg1$X01시, y=gg1$X07시, var.equal = T, paired = T)
#-------------------------------------------------------
#공공데이터 기상청데이터
gg1=read.table('clipboard', header =T )
gg1
#시간대별 1시, 4시 차이비교
var.test(gg1$X06시, gg1$X18시) #p값 0.01로 등분산아니다.
t.test(x=gg1$X06시, y=gg1$X18시, var.equal = F, paired = F) 
#지역적인것을 무시하고 진행 P값이 0.01이라서 오전6,오후6 차이ㅇ 
t.test(x=gg1$X06시, y=gg1$X18시, var.equal = F, paired = T) 
#순수 시간대로만 차이가 있다. p값이 0.009라서 귀무가설을 기각함.
#지역별로만 엮어놨으니까 지역별 환경의 격차가 배제되고 그래서 순수 시간대만으로 차이를 검정할 수 있음.


