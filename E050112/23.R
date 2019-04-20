# 이미지를 이용한 애니메이션

# png 이미지를 불러오기 위한 패키지를 설치한다.
# 패키지명은 png , install.packages("png")
# library(png)

# 경로설정하기 위한 함수(문자열 합치는 함수)
# paste("경로", "파일명", "확장자", sep="")

# readPNG(source) : PNG포맷의 이미지를 읽어들이는 함수
# 매개변수 source : 읽어올 파일명(경로포함한다.)

# rasterImage()함수 : 화면에 이미지 출력해주는 함수
# 사용법 : rasterImage(image, xleft,ybottom, xright, ytop)
# image : 출력할 이미지 파일명
# xleft, ybottom, xright, ytop : x축왼쪽, y축하단, x축오른쪽, y축상단

# dev.off() : 출력창을 닫는다.


path<-"/home/aaa/Document"
path.user<-"aaa"
path.filename<-"result.jpg"


fullpath <-paste(path, path.user, path.filename)
fullpath

fullpath <-paste(path, path.user, path.filename, sep="")
fullpath

fullpath<-paste(path, path.user, path.filename, sep="/")


install.packages("png")
library(png)


ani.options(interval=0.2) #interval 기본값은 1초

for(i in 1:9){
  img<-paste("~/test/",i,".png",sep="")#파일경로 설정
  img<-readPNG(img)
  
  plot.new() # 새로운 그래픽 프레임 생성
  rect(0,0,0.5,1, col="white") #그래픽 프레임 영역 지정
  
  rasterImage(img, 0,0,0.5,1) #이미지 출력
  
  ani.pause()
}

dev.off() 







