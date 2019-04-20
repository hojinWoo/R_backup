
myAni1<-function(){

 for(i in 10:0){
  
  plot.new()
  rect(0,0,1,1, col="gold")
  
  s = i-1
  
  text(0.5,0.5, i, cex=s, col=rgb(1,0,1,1))
  
  ani.pause()
 }

}

myAni1()

set.seed(1000)
runif(5,1,2) #1~2사이의 난수 5개를 생성

sample(1:4, 5)

rnorm(5)


myAni2<-function(){
  while(TRUE){
    y<-runif(5)
    barplot(y,ylim=c(0,1), col=rainbow(5))
    ani.pause()
  }
}

myAni2()







