# 구글맵 API 사용하기

# ggmap : 구글맵 또는 Stamen맵을 
#         정적으로 보여 주는 기능들의 패키지
# ggplot2 : 그래픽 출력을 위한 기능을 제공하는 
#           패키지, 데이터프레임의 다수의
#           데이터를 시각화할 수 있는 풍부한 
#           그래픽 기능을 제공함


# geocode('지역명 또는 주소에 대한 벡터') 는 
# 위도와 경도값을 반환한다.

# get_googlemap(center, zoom, scale, maptype)함수는 
# googlemap객체를 반환한다.
# center : 지도의 중심좌표값
# zoom : 지도의 크기 3~21, 디폴트 크기는 10(도시)
# scale : 1,2,4값을 갖는다. 
# 1=(640*640 pixels) 가로와 세로의 크기를 지정
# maptype : roadmap(도로명 표시), 
#           hybrid(위성과 도로명), 
#           satellite(위성지도),
#           terrain(지형정보기반지도)


install.packages("ggmap")
install.packages("ggplot2", dependencies = TRUE)

library(ggplot2)
library(ggmap)

gc<-geocode('Seoul')
gc

# 한글을 이용하여 위도와 경도 값을 얻고자 할 때
gc<-geocode(enc2utf8("서울")) 
gc

cen<-as.numeric(gc) # 위도와 경도를 숫자 형식으로 변환

cen

map <-get_googlemap(center=cen, 
            language="ko-KR", scale=1, 
            color="bw")
ggmap(map, fullpage=TRUE)



map<-get_googlemap(center=cen,scale=1, 
                   zoom=7, source="osm")
ggmap(map, fullpage=TRUE)

map<-get_googlemap(center=cen,scale=2,
              zoom=10, maptype="roadmap")
ggmap(map, fullpage=TRUE)

map<-get_googlemap(center=cen,scale=2,
                zoom=18, maptype="hybrid")
ggmap(map, fullpage=TRUE)

map<-get_googlemap(center=cen,scale=2,
                zoom=18, maptype="satellite")
ggmap(map, fullpage=TRUE)

map<-get_googlemap(center=cen,scale=2,
              zoom=19, maptype="satellite")
ggmap(map, fullpage=TRUE)

map<-get_googlemap(center=cen,scale=2,
              zoom=15, maptype="terrain")
ggmap(map, fullpage=TRUE)

# ggmap(get_googlemap()에 의해 생성된 객체) : 
# 지도를 출력해주는 함수, 반환값은 ggplot객체
# extent : 출력창에서 지도가 차지하는 영역의 
#          형태를 지정한다.
# normal, device, panel(디폴트) 
# 세가지 형태를 지정할 수 있다.


ggmap(map, extent='panel')

# fullpage=TRUE와 같은 형태
ggmap(map, extent='device') 

ggmap(map, extent='normal')

# get_map()함수
map<-get_map(location="seoul", zoom=14,
         maptype="watercolor", scale=1)

ggmap(map)





