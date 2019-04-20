# attach함수,bty 옵션사용법,
#그래프를 이미지 파일로 저장하기

attach(mtcars)

mpg

vs

am

detach(mtcars)

mtcars$mpg
mtcars$vs


attach(mtcars)

plot(wt, mpg, bty="]")

# bty는 그래프의 상자 모양을 결정한다. 
#아래와 같은 값을 갖을 수 있다.
# default 값은 o 이다.

# bty : l(알파벳) , o(알파벳),7, u, ] 


title("연비와 무게의 상관관계")

x<-(0:20)*pi /10

y = cos(x)

png("myGraph.png", width=400, 
    height=300, pointsize=12)

plot(x,y)

ysin = sin(x)
ysin2 = sin(x)^2


par(mfrow=c(2,2))

plot(x,y, type='p')
plot(ysin, ysin2, type = "l")
plot(x,y, type="b")
plot(x,y, type="p", pch=19, col="red")

dev.off()






