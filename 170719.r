#지도 나타내기
### Review ###

# EDA / CDA

# ggplot2, lattice package
# plotrix package

demo(plotrix)

split.screen(c(,))
screen()
close.screen(all=T)

par(mfrow=c(,))

plot(,type="")

dev.copy(pdf,".pdf") # R을 닫고 pdf파일을 열어
dev.off

plot() # 산포도
barplot() # 막대그래프
dotchart() # 점그래프
pie() # 파이그래프
IQR() # 사분위수범위
boxplot() # 상자모양차트

plot.new()

par(new=T)

plot()
segments()
arrows()
rect()
text(,srt=각도)
mtext()

persp() # 3차원
contour()

### 170719 ###

# 구글맵 API 사용하기
# ggmap / ggplot2
# geocode('지역명 또는 주소에 대한 벡터')는 위도와 경도값을 반환
# get_googlemap(center,zoom,scale,maptype)함수는 googlemap객체를 반환
# center : 지도의 중심좌표값
# zoom : 지도의 크기 3~21, 디폴트 크기는 10(도시)
# scale : 1,2,4값을 가져
# 1=(640*640 pixels) 가로와 세로의 크기를 지정
# maptype : roadmap(도로명 표시), hybrid(위성과 도로명), satellite(위성지도), terrain(지형정보기반지도)

#install.packages('ggmap')
#install.packages('ggplot2',dependencies=T)
library(ggplot2)
library(ggmap)
#install.packages("Seoul")
#install.packages('googleway')
library(googleway)

##
gc1=geocode('seoul')
gc1

# 한글을 이용하여 위도와 경도 값을 받고자 할 때
gc2=geocode(enc2utf8("서울"))
gc2

cen1=as.numeric(gc1)
cen1

map1_1=get_googlemap(center=cen1,language="ko-KR",scale=1,color="bw")
ggmap(map1_1,fullpage=T)

map1_2=get_googlemap(center=cen1,scale=1,zoom=7,source='osm')
ggmap(map1_2,fullpage=T)

map1_3=get_googlemap(center=cen1,scale=2,zoom=10,maptype='roadmap')
ggmap(map1_3,fullpage=T)

map1_4=get_googlemap(center=cen1,scale=2,zoom=18,maptype='hybrid')
ggmap(map1_4,fullpage=T)

map1_5=get_googlemap(center=cen1,scale=2,zoom=18,maptype='satellite')
ggmap(map1_5,fullpage=T)

map1_6=get_googlemap(center=cen1,scale=2,zoom=19,maptype='satellite')
ggmap(map1_6,fullpage=T)

##
# ggmap(get_googlemap()에 의해 생성된 객체)
# extent : 출력창에서 지도가 차지하는 영역의 형태를 지정
# normal, device, panel(디폴트)
# 세가지 형태를 지정가능

ggmap(map1_6,extent='panel')

# fullpage=T와 같은 형태
ggmap(map1_6,extent='device')

ggmap(map1_6,extent='normal')

map2=get_map(location='seoul',zoom=14,maptype='watercolor',scale=1)
ggmap(map2,fullpage=T)

##
gc3=geocode(enc2utf8('강원도 속초시'))
gc3
cen3=as.numeric(gc3)
cen3
map3=get_googlemap(center=cen3,maptype='roadmap',marker=gc3)
ggmap(map3,extent='device')

##
sk=c('서울','광주')
gc4=geocode(enc2utf8(sk))
cen4=c(mean(gc4$lon),mean(gc4$lat))
map4=get_googlemap(center=cen4,maptype='roadmap',zoom=9,marker=gc4)
ggmap(map4,extent='device')

names=c('1.망상해수욕장','2.속초해수욕장','3.낙산해수욕장','4.송지호해수욕장','5.하조대해수욕장')
addr=c('강원도 동해시 망상동 393-16','강원도 속초시 조양동 1464-11','강원도 양양군 강현면 주청리 1','강원도 고성군 죽왕면 8','강원도 양양군 현북면 하광정리 1')
gc5=geocode(enc2utf8(addr))
df5=data.frame(name=names,lon=gc5$lon,lat=gc5$lat)
cen5=c(mean(df5$lon),mean(df5$lat))
map5=get_googlemap(center=cen5,maptype='roadmap',zoom=9,marker=gc5)
(gmap5=ggmap(map5,extent='device'))

##
# ggplot2 패키지에 있는 geom_text()함수를 이용하여 해수욕장의 이름을 출력
# geom_text()함수의 리턴값은 문자가 들어있는 Layer
# geom_text(data,aes,size,label,...)
# data : Layer에 표시될 데이터
# aes : 위치좌표값(위도,경도)
# size : 문자크기, 디폴트값은 5
# label : 출력될 문자
gmap5+geom_text(data=df5,aes(x=lon,y=lat),label=df5$name,size=3,hjust=-.2,vjust=-1)
# hjust / vjust : 글자의 위치조절
gmap5+geom_text(data=df5,aes(x=lon,y=lat),label=df5$name,size=3,hjust=-1,vjust=1)

##
df6=read.csv('kang.csv',header=T)
df6$address=as.character(df6$address)
# gc1=geocode(enc2utf8(df1$address))
cen6=c(mean(df6$longitude),mean(df6$latitude))
map6_1=get_googlemap(center=cen6,maptype='roadmap',zoom=9)
ggmap(map6_1)+geom_text(data=df6,aes(x=df6$longitude,y=df6$latitude),size=3,label=df6$names)
ggmap(map6_1,extent='devide')+geom_point(aes(x=df6$longitude,y=df6$latitude,color='red',size=5),data=df6,shape=15)

##
# 맵에 범례를 표시하기
map6_2=get_googlemap(center=cen6,maptype='roadmap',zoom=9)
(gmap6_2=ggmap(map6_2,fullpage=T,legend='topright'))
gmap5_1+geom_text(data=df5,aes(x=lon,y=lat,color=factor(name)),size=10,label=seq_along(df5$name))
gmap6_2+geom_text(data=df6,aes(x=df6$longitude,y=df6$latitude,color=factor(df6$names)),size=8,label=seq_along(df6$names))

##
data(mtcars)
p=ggplot(mtcars,aes(x=wt,y=mpg,label=rownames(mtcars)))
(p1=p+geom_text(angle=30,size=2,hjust=-.2,vjust=0))
(p2=p+geom_text(angle=70,size=2,hjust=-.2,vjust=0.5))
p1+geom_point(aes(color=cyl))
p2+geom_point(aes(color=cyl))

##
u=read.csv('university.csv',header=T)
kor=get_map('seoul',zoom=11,maptype='watercolor')
(gmap_u1=ggmap(kor,fullpage=T)+geom_point(data=u,aes(x=LON,y=LAT,color=factor(학교명)),size=3))
(gmap_u2=ggmap(kor,fullpage=T)+geom_text(data=u,aes(x=LON+.01,y=LAT+.01,label=학교명),size=2.5))
gmap_u1+geom_text(data=u,aes(x=LON+.01,y=LAT+.01,label=학교명),size=2.5)

ggsave('gmap.png')

##밀집도 표현
pop=read.csv('population.csv',header=T)
region=pop$지역명; lon=pop$LON; lat=pop$LAT; house=pop$세대수

df_pop=data.frame(region,lon,lat,house)
map_pop=get_map(enc2utf8('대구'),zoom=7,maptype='roadmap')
(gmap_pop=ggmap(map_pop,fullpage=T))

# 레이어추가
gmap_pop+geom_point(data=df_pop,aes(x=lon,y=lat,color=house,size=house))
ggsave('pop.png')

##
df_q=head(quakes,100)
cen_q=c(mean(df_q$lon),mean(df_q$lat))
df_q=data.frame(lon=df_q$long,lat=df_q$lat)
df_q$lon=ifelse(df_q$lon>180,-(360-df_q$lon),df_q$lon)
map_q1=get_googlemap(center=cen_q,scale=1,maptype='roadmap',zoom=3,marker=df_q)
map_q2=get_googlemap(center=cen_q,scale=1,maptype='roadmap',zoom=5,marker=df_q)
#잘 안보이면 zoom을 높여서 상세하게 보이면 됨
#alpha를 통해 투명도를 조절할 수 있음
ggmap(map_q1,extent='device')
ggmap(map_q2,fullpage=T)+geom_point(data=df_q,aes(x=lon,y=lat,size=mag),alpha=.5) # 오류

#다른 package
library(treemap)
gnipc=read.csv("GNIPC.csv",fileEncoding = "UTF-8",header=T)
df=gnipc
df$GNIPC=as.numeric(df$GNIPC)#국가별 총 소득
treemap(df,index=c("Economy","code"),vSize = "GNIPC",vColor = "GNIPC",type="value")
treemap(df,index=c("Economy","code"),vSize = "GNIPC",type="index")

data()
data("GNI2014")
GNI2014
treemap(GNI2014,index=c("continent","iso3"),vSize="population",vColor = "GNI",type="value")
treemap(GNI2014,index=c("continent","iso3"),vSize="population",type="index")

data(business)
str(business)
business

treemap(business,index=c("NACE1","NACE2","NACE3"),vSize = "turnover",type = "index")
write.csv(business,"business.csv")

treemap(business[business$NACE1=="F - Construction",],index = c("NACE2","NACE3"),vSize = "employees",type = "index")
treemap(business[business$NACE1=="F - Construction",],index = c("NACE2","NACE3"),vSize = "employees",type = "value")


#각각의 그래프 별도로 모아서 보기위해 
#scales를 free로 설정 시 그래프 모아서 보여줌 (의미는 없음)
#ncol=6
g+geom_point(alpha=.3)+facet_wrap(cyl~class,scales = "free",ncol=6)
#nrow=4
g+geom_point(alpha=.3)+facet_wrap(cyl~class,scales = "free",nrow=4)

#bar graph
ggplot(DF,aes(x=bloodtype))+geom_bar()

#add fill factor
ggplot(DF,aes(x=bloodtype,fill=sex))+geom_bar()

#각각의 막대료 표현 시
ggplot(DF,aes(x=bloodtype,fill=sex))+geom_bar(position = "dodge")
#y축이 도수가 아닌 비율로 바뀜
ggplot(DF,aes(x=bloodtype,fill=sex))+geom_bar(position = "identify")
#막대의 넓이 값 바꿈
ggplot(DF,aes(x=bloodtype,fill=sex))+geom_bar(position = "dodge",width=0.3)

#히스토그램
g1=ggplot(diamonds,aes(x=carat))
g1+geom_histogram(binwidth = -.1,fill="orange")
#도수가 아닌 밀도
#hist() 함수에서 prob=T인지 사용
g1+geom_histogram(aes(y=..count..),binwidth = -.1,fill="orange")

#..count..
#데이터 프레임의 변수와 혼동되지 않도록 앞에 '..'을 붙임(예약어)
g1+geom_histogram(aes(y=..ncount..),binwidth = 0.1,fill="orange")
#ncount : 표준화된 도수값
#밀도값
g1+geom_histogram(aes(y=..density..),binwidth = 0.1,fill="orange")

#표준화된 밀도값
g1+geom_histogram(aes(y=..ndensity..),binwidth = 0.1,fill="orange")


#그룹별로 따로 그래프 그리기
#facet_grid()

#color~.라고 정규식 입력함
g1+geom_histogram(binwidth =)

#산점도 그리기
DF=read.csv("R까기소스/example_studentlist.csv")
g1=ggplot(DF,aes(x=weight,y=height))
g1+geom_point()

#level별 color다르게
g1+geom_point(aes(colour=sex),size=7)

#점의 모양 바꾸기
g1+geom_point(aes(colour=sex,shape=sex),size=7)
g1+geom_point(aes(colour=sex,shape=bloodtype),size=7)

#colour에 명목 변수 뿐 아니라 연속형 변수도 가능
g1+geom_point(aes(colour=height,shape=sex),size=7)

#size도 연속형 변수 가능
g1+geom_point(aes(size=height,shape=sex),colour="orange")

#alpha값으로도 가능(투명도)
g1+geom_point(aes(colour=sex,shape=bloodtype),size=7,alpha=0.6)


#산점도 회귀분석과 밀접한 관계
#회귀선은 두 변수의 관계를 함수식으로 나타냄
g1+geom_point(aes(colour=sex,shape=bloodtype),size=7)+geom_smooth(mothod="lm")

#점마다 이름을 넣을 수 있다
g1+geom_point(aes(colour=sex,shape=bloodtype),size=7)+geom_text(aes(label=name))
#점과 이름이 겹쳐서 위치 조절 적용
g1+geom_point(aes(colour=sex,shape=bloodtype),size=7)+geom_text(aes(label=name),vjust=1.1,colour="grey35")
#hjust=>위치 조절
g1+geom_point(aes(colour=sex,shape=bloodtype),size=7)+geom_text(aes(label=name),hjust=0.1,vjust=1.1,colour="grey35")

