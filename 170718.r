#setwd()//working directory 설정

#화면 분할해서 zoom을 통해 확대. 이미지 저장 가
split.screen(c(1,2))#
screen(2)
plot(10:1)
screen(1)
plot(1:10)
close.screen(all=T)

#screen을 2*3열로 나누면 지정된 곳에 screen을 명시하고 그릴 수 있음
split.screen(c(2,3))
screen(3)
plot(1:10)
zoom()
screen(4)
plot(2:5)
screen(5)
close.screen(all=T)

abc=c(260,300,250,280,310)
def=c(180,200,210,190,170)
ghi=c(210,250,260,210,270)

m=par(mfrow=c(1,3))  
plot(abc,type="o")
plot(def,type="s")
plot(ghi,type="p")
  
plot(sin,-pi,pi,lty=2)
par(new=T)#이전그래프 지우지 않고 유지
plot(cos,-pi,pi)

#그래프 pdf파일로 저장
dev.copy(pdf,"sample.pdf")#pdf viewer로 sample.pdf불러올 수 있음
dev.off

plot(ToothGrowth)
x=seq(1,10,0.1)
y=exp(x)
plot(x,y)

data(ToothGrowth)
head(ToothGrowth)

plot(ToothGrowth)
plot(ToothGrowth$len,ToothGrowth$dose)
with(ToothGrowth,plot(ToothGrowth$len,ToothGrowth$dose,main="My First Graph",xlab="Drink Soje",ylab="Use Money"))

#그래프 그리고(산포도)
#1. 데이터 설정
abc=c(260,300,250,280,310)
def=c(180,200,210,190,170)
ghi=c(210,250,260,210,270)
#2. 그래프 그리기
plot(abc,type="o",col="red",ylim = c(0,400),axes=F,ann=F)
#3. x,y축 그리기
axis(1,at=1:5,lab=c("A","B","C","D","E"))
axis(2,ylim=c(0,400))
#4.그래프 이름 부여
title(main="Fruit",col.main="red",font.main=4)     
title(xlab="Day",col.lab="black")
title(ylab="price",col.lab="blue")
#5. 그래프 중첩해서 그리는 경우
lines(def,type="o",pch=21,col="green",lty=2)
lines(ghi,type="o",pch=22,col="blue",lty=2)#pch:0~25
#6. 그래프 범례 넣기
legend(4,400,c("BaseBall","soccerBall","BeachBall"),cex=0.8,col=c("red","green","blue"),pch=21,lty=1:3)

#막대그래프
x=c(1,2,3,4,5,6)
x#데이터 모양 확인
barplot(x,names="매출")
xx=matrix(c(1,2,3,4,5,6),3,2)#2개의 묶음으로 나눔
xx
barplot(xx)
barplot(xx,beside=T,names=c("Korea","America"))#열로 그려진 막대 그래프 레이블 부여
xxx<-matrix(c(1,2,3,4,5,6),2,3)
xxx
barplot(xxx)#행으로 그려짐
barplot(xxx,beside=T)#열로 그려짐
barplot(xxx,beside=T,names=c("Korea","America","Europe"))
#옵션
abc=c(110,300,150,280,310)
barplot(abc,main="Base Ball 판매량",xlab="Season",ylab="판매량",names.arg=c("A","B","C","D","E"),border="blue",density=c(10,30,50,30,10))
#가공
def=c(180,200,210,190,170)
ghi=c(210,150,260,210,70)
B_Type2=matrix(c(abc,def,ghi),5,3)
B_Type2
#볼 타입별, 시즌매출 그래프
barplot(B_Type2,main="Ball Ype별 시즌의 판매량",xlab="Ball Type",ylab="매출",beside=T,names.arg=c("BaseBall","SoccerBall","BeachBall"),border="blue",col=rainbow(5),ylim=(c(0,400)))
#범례 추가
legend(16,400,c("A 시즌","B 시즌","C 시즌","D 시즌","E 시즌"),cex=0.8,fill=rainbow(5))

#시즌별 볼타입 매출 그래프
barplot(t(B_Type2),main="시즌 별 볼타입의 판매량",xlab="Season",ylab="Price",beside=T,names.arg=c("A","B","C","D","E"),border="blue",col=rainbow(3),ylim=(c(0,400)))
#범례 추가
legend(16,400,c("BaseBall","SoccerBall","BeachBall"),cex=0.8,fill=rainbow(5))
#(참고)누적
barplot(t(B_Type2),main="시즌 별 볼타입의 판매량(누적 표시형)",xlab="Season",ylab="매+ 출", names.arg=c("A","B","C","D","E"),border="blue",col=rainbow(3),ylim=(c(0,1000)))
#범례 추가
legend(4.5,1000,c(c),cex=0.8,fill=rainbow(5))



#점 그래프-------
x=c(1:10)
#점의 모형 22형(사각형), Y축의 label설정
dotchart(x,labels = paste("Test",1:10),pch=22)
??graphics::points#Add points to a plot

#히스토그램--------
b=c(1,2,1,4,3,5,4,5,3,2,5,6,7,2,8,5,9,3,6)
hist(b)

#파이 그래프-------
T_sales=c(210,110,400,550,700,130)
pie(T_sales)
#angle, density, col,labels,radius,clockwise,init.angle//
#예시1(순서를 시계방향대로)
pie(T_sales,init.angle=90,col=rainbow(length(T_sales)),labels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"))
#추가
legend(1,1,c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"),cex=0.8,fill=rainbow(length(T_sales)))
#예시2(비율로 나타내기)
week=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")#자료 정의
ratio=round(T_sales/sum(T_sales)*100,1)
label=paste(week," \n",ratio,"%")
pie(T_sales,init.angle = 90,main="주간 매출 변동",col=rainbow(length(T_sales)),cex=0.8,labels=label)

#3차원 파이 그래프
library(plotrix)
#다양한 그래프 예제
demo(plotrix)

week=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")#자료 정의
ratio=round(T_sales/sum(T_sales)*100,1)
label=paste(week," \n",ratio,"%")
pie3D(T_sales,main="주간 매출 변동",col=rainbow(length(T_sales)),cex=0.8,labels=label)
legend(0.5,1,c("Mond","Tue","Wed","Thu","Fri","Sat"),cex = 0.8,fill=rainbow(length(T_sales)))
#explode
pie3D(T_sales,main="주간 매출 변동",col=rainbow(length(T_sales)),cex=0.8,labels=label,explode=0.05)
#Excersice
x=c(1,-1,-1,1,1)
y=c(1,1,-1,-1,1)

plot(x,y
     ,type="l"#line
     ,axes=F #without axes
     ,xlab=" " #x label
     ,ylab=" ") #y label
title("Rectangle")#그래프 제목 추가

#상자모양 차트-----------------------
abc=c(110,300,150,280,310)
def=c(180,200,210,190,170)
ghi=c(210,150,260,210,70)
boxplot(abc,def,ghi)
boxplot(abc,def,ghi,col=c("Yellow","cyan","green"),names=c("BaseBall","SoccerBall","BeachBall"),horizontal = T)

#그래프 추가 기능들
x=c(1:10)
dotchart(x)
par(new=T)#그래프 위에 다른 그림 그리고 싶은 경우
b=c(1,2,1,4,1,5,6,8,7,6,5,3,4,6,7,8,6)
hist(b)
plot.new()#그림 지우기
plot(-4:4,-4:4,type="n")
points(rnorm(200),rnorm(200),pch="+",col="red")
par(new=T)
points(rnorm(200),rnorm(200),pch="o",col="magenta")

#꺾은선 그래프
x=c(1:10)
y=x*x
plot(x,y,type='n',main="Title")
for(i in 1:5){
  lines(x,(y+i*5),col=i,lty=i)
}
#직선**************************************
library(ggplot2)
data(iris)
head(iris,n=10)
a=qplot(Sepal.Length,Petal.Length,data=iris)#분석 용 회귀 분석 라인 추가
qplot(Sepal.Length,Petal.Length,data=iris,theme(panel.grid.major = element_line(colour = "grey40"),
            panel.grid.minor = element_line(colour = "grey40")))
a+ theme_bw()
panel_grid()
grid(10,10)
a+geom_abline(intercept = -4,slope=1) #절편 0, 기울기 1/y=a+bx
#{plot(seq(1,10,1))abline(a=0,b=1)}

#선분과 화살표, 사각형, 문자열
x=c(1,3,6,8,9)
y=c(12,56,78,32,9)
plot(x,y)

segments(6,78,8,32)#(x,y)의 (3,3)과 (4,4)연결
arrows(3,56,1,12)#(x,y)의 (3,3)과 (1,1)화살표
rect(4,20,6,30,density=3)#(4,20)과 (6,30을 연결하는 사각형

text(4,40,"이것은 샘플입니다",srt=55)#srt : 각도
mtext("상단의 문자열입니다",side=3)#side 1:아래, 2:왼쪽, 3:위쪽, 4:오른쪽
mtext("우측의 문자열입니다",side=4,adj=0.3)#adj : 0dlaus x축에 붙는다

box(lty=2,col="red")#테두리 그리기

axis(1,pos=40,at=0:10,col=2)#x축 추가 y :40에 그리기
axis(2,pos=5,at=10:60)

#산포도//겹치는 것은 꽃잎으로
x=c(1,1,1,2,2,2,2,2,2,3,3,4,5,6)
y=c(2,1,4,2,3,2,2,2,2,2,1,1,1,1)
zz=data.frame(x,y)
sunflowerplot(zz)

#stars//전체적인 윤곽
data(mtcars)#ckdml dusql
stars(mtcars[,1:4])
head(mtcars)

#symbol//3차원 데이터 관계성--직관
xx=c(1,2,3,4,5)
yy=c(2,3,4,5,6)
zz=c(10,5,100,20,10)
symbols(xx,yy,zz)

#pairs//3차원 데이터 관계성--3차원
xx=c(1,2,3,4,5)
yy=c(2,3,4,5,6)
zz=c(10,5,100,20,10)
c=matrix(c(xx,yy,zz),5,3)
c
pairs(c)

#persp//3차원
x1=seq(-3,3,length=50)
x2=seq(-4,4,length=60)
f=function(x1,x2){
  x1^2+x2
}
y=outer(x1,x2,FUN=f)#외적
persp(x1,x2,y)

#coutour
x1=seq(-3,3,length=50)
x2=seq(-4,4,length=60)
f=function(x1,x2){
  x1^2+x2^2
}
y=outer(x1,x2,FUN=f)
y=outer(x1,x2,FUN="+")
contour(x1,x2,y)

#lattice package
data("quakes")
head(quakes)
library(lattice)
mini=min(quakes$depth)
maxi=max(quakes$depth)
r=ceiling((maxi-mini)/8)#depth구간 크기
inf=seq(mini,maxi,r)
quakes$depth.cat=factor(floor((quakes$depth-mini)/r),labels=paste(inf,inf+r,sep="-"))
xyplot(lat~long|depth.cat,data=quakes,main="Fiji earthquakes data")

#cloud 3 dim plot
cloud(mag~lat*long,data=quakes,sub="magnitude with longitude and lattide")

splom(quakes[,1:4])

bwplot(mag~depth.cat,data=quakes,main="깊이 범부에 따른 지진 강도 상자그램")

op=par(mfrow=c(1,2))#1*2의 레이아웃
hist(quakes$mag)
hist(quakes$mag,probability = T,main="histogram with density line")
lines(density(quakes$mag))#두번 째 그래프에 라인 추가
par(op)

library(ggplot2)
head(iris)
qplot(Sepal.Length,Petal.Length,data=iris)
qplot(Sepal.Length,Petal.Length,data=iris,color=Species,size=Petal.Width)
#선의 형태
qplot(Sepal.Length,Petal.Length,data=iris,geom="line",color=Species)
qplot(age,circumference,data=Orange,geom="line",colour=Tree,main="How does ~~")
      

library(graphics)
x=c(100,50,10,17)
company=c("A회사","B회사","C회사","D회사")
pie(x,label=company,init.angle=90,main="s그룹의 자회사별 매출액")
p=round((x/sum(x))*100)#백분율
company=paste(company,p)
company=paste(company,'%')
pie(x,label=company,init.angle=90,main="s그룹의 자회사별 매출액",col=rainbow(length(x)))

#heat.colors : 난색(적색,황색계열)
#terrain.colors : 지구의 지형색
#topo.colors 청색계열
#cm.colors cyan과 핑크계열
pie(rep(1,12),labels = seq(1,12),col=rainbow(12))
pie(rep(1,12),labels = seq(1,12),col=heat.colors(12))
pie(rep(1,12),labels = seq(1,12),col=terrain.colors(12))
pie(rep(1,12),labels = seq(1,12),col=topo.colors(12))
pie(rep(1,12),labels = seq(1,12),col=cm.colors(12),radius = 0.8)

library(plotrix)
demo(plotrix)
demo(graphics)


p <- ggplot(mpg, aes(displ, cty)) + geom_point()
qplot(mtcars$wt, mtcars$mpg)
