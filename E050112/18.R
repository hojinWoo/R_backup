# 히스토그램: hist()함수를 이용하여 출력한다.

data()

Nile

hist(Nile)

#hist(x, breaks, 
#      freq, probability, 
#      main, xlim, ylim, col)

quakes

mag<-quakes$mag
mag
colors<-c("red", "orange", 
          "yellow", "green",
          "blue", "navy", "violet")
hist(mag, main="지진 발생 강도 분포", 
     xlab="지진강도", 
     ylab="발생건수", col=colors,
     breaks=seq(4,6.5,by=0.5))

hist(mag, main='지진발생 강도의 분포', 
     xlab="지진강도",
     ylab="상대도수",
     col=colors,
     breaks=seq(4,6.5,by=0.5),
     freq=FALSE)

fit<-hist(mag, main="지진 발생 강도의 분포",
     xlab="지진강도",
     ylab="상대도수", col=colors,
     breaks="Sturges", freq=FALSE)


#선도표(Line Charts) : lines()함수 

#사용법 lines(x,y, type=)
# 이함수는 함수 자체만으로는 그래프를 생성하지 못하고, plot명령후에 사용할 수 있다.

#type에는 p, l, o(overplotted points와lines), 
#         b,c(비어있는 경우),
#         s,S, h, n(아무것도 출력하지 않음)

x<-c(1:5); y<-x

plot(x,y, type="n")

lines(x,y, type="o") 

par(pch=22, col="red")

par(mfrow=c(2,4))
opts=c("p", "l", "o","b","c","s","S","h")

for(i in 1:length(opts)){
  head = paste("type=",opts[i])
  plot(x,y, type="n", main=head)
  lines(x,y,type=opts[i])
}














