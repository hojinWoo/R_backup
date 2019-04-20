# PCH(plotting character) 심벌

?pch

plot(0:10, 0:10, main="PLOT", sub="Test", 
     xlab="X-Label", ylab="Y-Label", type="n")

par(bg="transparent")

#points()함수 : 점을 그리는 함수

p<-c(9,1)
points(p, pch=1, cex=2)
points(p, pch=2, cex=2)
points(p, pch=3, cex=2)
points(p, pch=23, cex=2)

weight<-women$weight
height<-women$height

plot(height, weight, xlab="키",
     ylab="몸무게", pch=20, cex=1.5, col="blue", bg="yellow")

# 그래프안에 글자를 넣는 방법
# text()함수를 이용한다.


text(65, 150, "글자", col='red')


par(fg="black")

par(bg="orange")


# 그래프안에 선을 넣는 방법
# abline()함수를 이용한다.

abline(h=135, lty=3)

abline(v=62, lty=3)

abline(h=140, v=66, lty=4)

#axis() 함수 사용하기 : 상, 하, 좌, 우에 축 그려주는 함수

# axis(side, at, label, ....) 
# side는 1=bottom, 2=left, 3=top, 4=right 값을 갖는다.

axis(1, at=63, labels=63, col="red")

abline(h=140, v=63, lty=3)

text(64, 142, "(63,140)", col="red")





