# 임의의 주소지를 중심으로 지도를 출력하기

gc<-geocode(enc2utf8('강원도 속초시'))
gc

cen<-as.numeric(gc) #숫자형 모드로 변환
cen
map<-get_googlemap(center=cen, 
                   maptype="roadmap",
                   marker=gc)
ggmap(map, extent="device")

names<-c("1.망상해수욕장", "2.속초해수욕장",
         "3.낙산해수욕장","4.송지호해수욕장",
         "5.하조대해수욕장")

addr<-c("강원도 동해시 망상동 393-16",
        "강원도 속초시 조양동 1464-11",
        "강원도 양양군 강현면 주청리 1",
        "강원도 고성군 죽왕면 8",
        "강원도 양양군 현북면 하광정리 1")

sk<-c("서울","광주")

gc<-geocode(enc2utf8(sk))
gc
gc<-geocode(enc2utf8(addr))
gc

df<-data.frame(name=names, lon=gc$lon, 
               lat=gc$lat)
df
mean(df$lon)

cen<-c(mean(df$lon), mean(df$lat))
cen  
  
map<-get_googlemap(center=cen, 
                   maptype="roadmap",
                   zoom=9, marker=gc)  
  
gmap<-ggmap(map, extent="device")


# ggplot2 패키지에 있는 geom_text()함수를 
# 이용하여 해수욕장의 이름을 출력

# geom_text()함수의 리턴값은 문자가 
# 들어있는 Layer
# geom_text(data, aes, size, label,...)
# data : Layer에 표시될 데이터 , 
#  aes : 위치좌표값(위도, 경도)
# size : 문자크기, 디폴트값은 5, 
# label : 출력될 문자 

gmap+geom_text(data=df,aes(x=lon, y=lat),
               size=3, label=df$name, 
               hjust=-.2, vjust=-1)





df1<-read.csv("E:\\빅데이터강좌\\R\\exam\\E050112\\kang.csv",
              header=TRUE)
df1
df1$address
df1$address<-as.character(df1$address) 
#문자형 mode로 변환
# gc1<-geocode(enc2utf8(df1$address))
cen<-c(mean(df1$longitude),mean(df1$latitude))
map<-get_googlemap(center=cen, maptype="roadmap",
                   zoom=9)

ggmap(map)
ggmap(map)+geom_text(data=df1, 
                     aes(x=longitude, y=latitude),
                     size=3, label=df1$names)


ggmap(map,extent="devide")+
  geom_point(aes(x=df1$longitude, 
                 y=df1$latitude,
                color="red", size=5),
                data=df1, shape=15)
  
  