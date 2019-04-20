u<-read.csv("E:\\빅데이터강좌\\R\\exam\\E050112\\university.csv", header=TRUE)
u

kor<-get_map("seoul", zoom=11, 
             maptype="watercolor")

#Layer1추가 : 포인트 추가
ggmap(kor,fullpage=TRUE)+geom_point(data=u, 
            aes(x=LON, y=LAT, 
               color=학교명),size=3)

gmap<-ggmap(kor,fullpage=TRUE)+geom_point(data=u, 
            aes(x=LON, y=LAT,
                color=factor(학교명)),size=3)

#Layer2추가 : 텍스트 추가
gmap+geom_text(data=u, 
               aes(x=LON+0.01, y=LAT+0.01,
                   label=학교명),size=2.5)

# 지도저장 ggsave() 

ggsave("E:\\빅데이터강좌\\R\\exam\\E050112\\uni.png") # width, height 지정 가능, 밀도지정가능(예: dpi=1000)

pop<-read.csv("E:\\빅데이터강좌\\R\\exam\\E050112\\population.csv", header=TRUE)
pop

region <- pop$지역명
region
lon<-pop$LON
lat<-pop$LAT
house<-pop$세대수

df<-data.frame(region, lon, lat, house)
df
map1<-get_map(enc2utf8("대구"), 
              zoom=7, maptype="roadmap")
map2<-ggmap(map1,fullpage=TRUE)

#레이어1 추가
map2+geom_point(data=df, 
                aes(x=lon, y=lat, 
                    color=house, size=house))


ggsave("E:\\빅데이터강좌\\R\\exam\\E050112\\pop.png", scale=1, width=10.24, height=7.68)
quakes
df<-head(quakes, 100)
df
cen<-c(mean(df$long), mean(df$lat))
cen
df2<-data.frame(lon=df$long, lat=df$lat)
# ifelse(조건, 조건이 참일경우 값, 조건이 거짓일 경우의 값)
df2$lon<-ifelse(df2$lon>180, -(360-df2$lon), df2$lon)
df2
map<-get_googlemap(center=cen, scale=1,
                   maptype="roadmap", 
                   zoom=3, marker=df2)
map<-get_googlemap(center=cen, scale=1,
                   maptype="roadmap", 
                   zoom=5,marker = df2)
ggmap(map, extent="device")
ggmap(map, fullpage=TRUE)+geom_point(data=df, 
                                     aes(x=long, 
                                       y=lat, size=mag),
                                     alpha=0.5)








