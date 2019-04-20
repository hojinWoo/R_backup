#데이터 전처리(data processing)

#package 설치
#dplyr , hflightdims 
#install.packages(c("dplyr","hflights"))

library(dplyr)
#기본
#filter() #지정한 조건식에 맞는 데이터 추출
#subset(), select() #열의 추출 
#mutate() #열 추가
#transform(), arrange() #정렬
#order(), sort(), summarise() #집계
#(aggregate()에 group_by() 추가 이용 시 그룹별로 다양한 집계 가능)

#미국 휴스턴에서 2011년의 모든 비행기의 이착률 기록
#227496건에 기록에 대해 21개 항목을 수집
library(hflights)
dim(hflights)
##[1] 227486    21
#ex) 데이터의 수가 많기 때문에 tbl_df형식으로 변환해서 사용
hflights_df=tbl_df(hflights)
hflights_df
#tbl_df 이용 시 내용 파악 가능

#filter는 조건에 다라 row추출
#ex) And 기호 사용 시 , 또는 & 연산자 사용
filter(hflights_df,Month ==1, DayofMonth ==1)
#ex) 1,2월 데이터 추출(or연산자)
filter(hflights_df,Month ==1 | Month ==2)

#arrange는 지정한 열 기준으로 작은 값부터 큰 갑의 순(역순 할 시 desc사용)
#ex) 데이터를 ArrDelay, Month, Year순으로 정렬 시 
arrange(hflights_df,ArrDelay,Month,Year)
#ex) Month의 큰 값부터 작은 값으로 정렬 시
arrange(hflights_df,desc(Month))

#select(), mutate()를 이용한 열의 조작으로 column추출 시 
#여러 개 추출 시 콤마(,)로 구분, 인접한 열 추출 시 : 연산자 사용
#제외할 colume은 - 부호 이용
#ex) Year, Month, DayOfWeek 열 추출
select(hflights_df,Year, Month, DayOfWeek)
#ex) Year부터 DayOfWeek까지
select(hflights_df,Year:DayOfWeek)
#ex) Year부터 DayOfWeek를 제외한 나머지 열 추출
select(hflights_df,-(Year:DayOfWeek))

#mutate() 열을 추가하는 경우에 사용 (transform()과 비슷)
#새로 만든 열을 같은 함수 안에서 바로 사용할 수 있는 장점
#ex) 평균 출발 지연시간(에러)이 생기는 경우
mutate(hflights_df,gain=ArrDelay-DepDelay, gain_per_hour=gain/(AirTime/60))

#ex) 평균 출발 지연시간 (sqldf이용 안하는 경우)
summarise(hflights_df,delay=mean(DepDelay,na.rm=TRUE))

#group_by를 이용한 그룹화는 지정한 열별로 그룹화된 결과
#ex) 비행편수 20편 이상, 평균 비행 거리 2000마일 이상 항공사별 평균 연착시간(그림)
planes=group_by(hflights_df,TailNum)
delay<-summarise(planes,count=n(),dist=mean(Distance, na.rm=TRUE,delay=mean(ArrDelay,na.rm=TRUE)))
delay=filter(delay,count>20,dist<200)
library(ggplot2)
ggplot(delay, aes(dist,delay))+geom_point(aes(size=count),alpha=1/2)+geom_smooth()+scale_size_area()


