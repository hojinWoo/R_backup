# 맵에 범례를 표시하기

map<-get_googlemap(center=cen, 
                   maptype="roadmap", zoom=9)
gmap<-ggmap(map, fullpage=TRUE,
            legend="topright")

gmap+geom_text(data=df, 
               aes(x=lon, y=lat,
                   color=factor(name)), size=10,
                   label=seq_along(df$name))

# ggplot() 데이타를 시각화하는데 사용하는 함수

p<-ggplot(mtcars, aes(x=wt, y=mpg, 
                      label=rownames(mtcars)))
p
p1<-p+geom_text(angle=30, 
                size=2, hjust=-.2, vjust=0)
p1<-p+geom_text(angle=70, 
                size=2, hjust=-.2, vjust=0.5)
p1+geom_point(aes(color=cyl))



