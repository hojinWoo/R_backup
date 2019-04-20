# sample 함수 

sample(1:10, 4)

sample(1:100, 10)

sample(letters, 10, replace = TRUE)

sample(1:10, 5, replace = TRUE)

set.seed(1)

sample(1:10, 5)

set.seed(2)
sample(1:10, 5)

x<-c(1:10)
y<-x

plot(x,y, pch=3, xlab="x축제목", ylab="y축제목")

# par() 함수의 파라미터 여백을 조절하는 인자
# mar(bottom, left, top, right), 
# mgp(축제목여백, 축레이블 여백, 축선)
# tcl 눈금 조절 인자

par(mar=c(5,4,4,2), mgp=c(3,1,0), tcl=-0.5)



# 애니메이션 패키지는 animation
# install.packages("animation")
# library(animation)

# 함수명 <-function(){}
# 함수호출 : 함수명()

# ani.options() : 애니메이션 옵션을 설정하거나 조회함
# ani.options()함수의 인자 : interval - 애니메이션 시간 간격(초) 디폴트값은 1
#             nmax - 애니메이션 프레임을 만들기 위한 반복수, 디폴트값은 50
#             ani.width(프레임의 가로 크기:픽셀)
#             ani.height(프레임의 세로 크기:픽셀)  
#             반환값 : 옵션으로 설정된 매개변수 내용의 리스트


# ani.pause() : 주어진 시간동안 대기하고 현재화면을 지움
# 디폴트값은 ani.pause('interval')

install.packages("animation")
library(animation)

myAni <-function(){
  n = ani.options("nmax")
  x = sample(1:n)
  y = sample(1:n)
  
  for (i in 1:n){
    plot(x[i], y[i], cex=3, col="red", pch=20, 
         lwd=2, ylim=c(0,50), xlim=c(0,50))
    ani.pause()
  }
}

par(mar=c(3,3,1,0.5), mgp = c(1.5, 0.5, 0), tcl=-0.3)
myAni()

#sample(1:50)

plot.new() #새로운 그래픽 프레임 생성
rect(0,0,1,1) # 플롯 영역 내부의 좌표에 사각형을 그린다.

plot(1:10, type="n")
rect(0,0,3,3)

rect(4,6,8,8, col="gold")

rect(6,3,8,4, border="gold", lwd=2, density=10, lty=2)








