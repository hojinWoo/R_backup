#적합도 검정(Goodness of Fit)//#공공데이터 data handling

#chi square test//분포에서 비율이 맞는 지 검정
t1=table(survey$W.Hnd)
chisq.test(t1,p=c(0.3,0.7)) #3:7의 비율 귀무가설-->기각
str(t1)
t1[1]
t1/sum(t1)


#shaprio-wilk test //데이터가 정규분포가 맞는지 검정
shapiro.test(rnorm(1000))#데이터 크기는 3~5000 사이
#p-value>0.05면 정규분포가 맞는 것


#Kolmogorov-Smirnov Test //비교대상인 누적분포 함수간의 최대 거리를 통계량으로 사용 
#(귀무가설 - '주어진 두 데이터가 동일한 분포로부터 추출된 표본인지)
ks.test(rnorm(100),rnorm(10,10))


#Q-Q plot //자료가 분포를 따르는 지 시각적으로 검토 가능(누적 분포 함수 사용)
#대각선 관계(선형)를 통해 서로의 관계가 어떠한 지 확인 가능
x=rnorm(100,10,1)
qqnorm(x) #//분위수 구하기 - x에 대한 quantiles들.
qqline(x, lty=2) #lty:점선을 그려서 선형의 모양을 띠는 지 확인 가능

x=rcauchy(1000) #정규분포가 아닌 1000개의 데이터
qqnorm(x)
qqline(x,lty=2)


#시험문제 많이 나옴(correlation)

#pearson correlation coefficient****************************
symnum()#숫자와 기호로 나타내줌 가장 큰 것은 B(best)로 나타
#corgram library는 그림으로 나옴
#***********************************************************
#spearman's rank correlation//비선형 데이터, 순위로 바꾸어서 함! 순위 간 관계를 나타날 때 사용
#단위에서 오는 error를 없애기 위해
#matrix로 구성된 것들이 내부적으로 순위를 매긴 후에 사용해야 함 (Hmisc package)
#list로 return 


#kendal's rank correlatino ********************************
#각각 순위 값으로 나타

#correlation test 상관계수의 유의성!!!


ss1=survey[survey$Sex=='Male',"Height"]
f1=survey[survey$Sex=='Male',]
m1=survey[survey$Sex=='Female',]것
mean(ss1)
ss2=na.omit(ss1)#NA값들 제거해 달라는 것 //NA값들이 있으면 계산할 때 안됨
mean(ss2)

t.test(x=ss2,mu=173.5)#남자 키 평균이 173.5cm가 맞는 지
t.test(ss1,ss2)

ww1=survey[survey$Sex=='Female',"Height"]
ww1=na.omit(ww1)
mean(ww1)
t.test(x=ww1,mu=166)

length(ss2)
length(ww1)
#데이터 개수가 다른 두개의 집단, 환경이 동일하게 되도록 맞춰주어야 함
var.test(x=ss2,y=ww1)#채택되면 등분산--T, 기각되면 이분산--F
t.test(x=ss2,y=ww1,var.equal = F,paired = F)#집단 간 차이가 나는 지 볼 때는 순수 집단만 넣음
#전후를 비교할 때는 데이터가 같으므로 'var.equal=T' &'paired=T'를 써야 함

#차이가 양수가 나오면 앞에 데이터가 뒤에 데이터보다 큰 것

#함수에 NA값들이 있을 때 na.rm을 통해 할 ㄱ
f1=survey[survey$Sex=='Male',"Pulse"]
m1=survey[survey$Sex=='Female',]


sleep
var.test(extra~group,data=sleep)
t.test(extra~group,data=sleep,var.equal=T,paired=T)#paied설정하면 각각이 전후를 비교



