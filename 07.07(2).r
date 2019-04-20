#merge해서 두개 연결해서 어떤 분석이 가능한 지 정리하기
#project search 해 나가는 과정
rm(list=ls())

library(xlsx)
data1=read.csv('go_track_tracks.csv',header=T,sep=',',encoding='UTF-8')
View(data1)
data2=read.csv('go_track_trackspoints.csv',header=T,sep=',',encoding='UTF-8')
View(data2)
#gps_data=merge(x=data1,y=data2,by.x=data1$id,by.y=data2$track_id,all=T)

library(data.table)
data1=data.table(data1,key="id")
data2=data.table(data2,key="track_id")
joined.data2.data1.2=data2[data1]
dt=joined.data2.data1.2
var.test(speed~rating,data=dt)
model1=aov(speed~rating,data=dt)
summary(model1)
library(MASS)
#frac

rm(list=ls())

install.packages('ggmap')
install.packages('ggplot2')
install.packages('RgoogleMaps')
library(ggmap)
library(ggplot2)
library(RgoogleMaps)
#ge=geocode('Oc',source='google')
dt2=as.matrix(dt)
class(dt2)
r1=nrow(dt2)
dt$l[5]
#gc=geocode('Seoul')
#cen <- as.numeric(gc)
gc=c(dt$latitude[1],dt$longitude[1])
map.center=c(-10,-30)

for (i in r1){
  ggmap(get_googlemap(center=map.center,scale = 1,maptype = "roadmap",zoom=8), fullpage = TRUE) +
  geom_point(aes(x = dt$latitude, y = dt$longitude, colour = "red" , size= 10),data=dt)
}
cen=c(-10,-30)
ggmap(get_googlemap(center=cen, scale = 1,maptype = "hybrid",zoom=7), fullpage = TRUE)
dt3=data.frame(lon=dt$longitude,lat=dt$latitude)

map=ggmap(get_googlemap(center = c(lon=-37.0, lat=-10.9),zoom=9))
for(i in r1){
  map=map+geom_point(data=dt3,aes(x=lon,y=lat))
}
map2=map+geom_point(data=dt3,aes(x=lon,y=lat))#지도로 나타내기

View(data1)
data3=data1[data1$rating_weather != 0,]#해당하는 모든 열 가져오기
str(data3)
data3$rating_weather=factor(data3$rating_weather)
var.test(rating~rating_weather,data=data3)#등분산임
t.test(rating~rating_weather,data=data3,var.equal=T,paired=F)#paired F는 독립, 

table(data3$rating,data3$rating_weather)
#-------------------------------------------------------------------------------------
cars#break 밟을 때 밀리는 걸이(제동거리)
#상관성이 있어야만 인과관계를 알 수 있고 없으면 만들어야 함(연관성이 있는 것을 가정)
#상관성이 존재해야 회귀분석을 할 수 있음
model01=lm(dist~speed,cars)
plot(cars)
summary(model01)

#회귀분석에서  y=a+bx에서 a(Intercept)값
#제일 중요한 것은 b가 0인지 아닌지
#estimated의 p-value를 통해 (귀무가설이 기각되면 b가 0이 아니므로 가중치가 존재한다는 것-의미가 있음)

model01$coefficients[1] #다양하게 사용 가능
  
write(model01$coefficients,file="eff1.txt")
str(model01$coefficients)
#overlap
abline(model01,col='red',v=10) #이 함수는 직선만 가능,사전에 plot이 있어야 함
pred1=predict(model01,newdata=data.frame(speed=c(10,5,3,21,22)))#예측하기, data.frame으로만 가능
#모형 개발- 데이터 삽입- 검증 // matching율이 높을수록 좋음, error 값이 0에 가까워지도록 
#(엡실론, 잔차의 제곱)이 SE 기준으로 추정함
#(sum(y(i)-y^)^2)/n-1 < MSE / root하면 RMSE가 됨(단위가 더 작아지므로 효과저)
  