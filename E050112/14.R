# XY플롯팅(plotting)
# plot()함수를 이용하여 만든다.

data()
women

w<-women$weight
w
plot(w)

h<-women$height
plot(h)

par(bg="yellow")

par(fg="red")

plot(h,w,xlab='키', ylab='몸무게', main="여성의 평균 키와 몸무게" 
     ,sub="미국의 70년대 기준")

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="l", lty=6, lwd=4) # type=l(영문자 L)은 그래프의 모양을 선으로 표시

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="p") # type=p는 점으로 표시한다.

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="b") # type=b는 점과 선으로 표시한다.

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="c") # type=c는 앞의 type=c에서 점을 뺀 나머지 선으로 표시한다.

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="o") # type=o는 점위의 선으로 표시한다.

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="h") # type=h는 각 값을 수직선으로 표시한다.

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="s") # type=s는 계단형

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="S") # type=s는 계단형

plot(h,w,xlab='키', ylab='몸무게', 
     main="미국 여성의 평균 키와 몸무게", 
     type="n") # type=n는 표시하지 않는다.










