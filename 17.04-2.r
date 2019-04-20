#--------------------------------------------------------------------------
#IF,FOR,WHILE
x=5
if(x>6){
  print('True')
  print('hello')
}else{
  print("FALSE")
  print('world')
}
#x가 안에 들어있는 지 판단 가능
x %in% c(1,4,7,5)
#i가 1,3,5 순서대로 들어가며 확인
for(i in c(1,3,5)){
  
}

for(i in 1:9){}
#i를 연속으로 찾기//시작값, 종료값, 증가값
sum=0
for(i in seq(1,100,3)){
  sum=sum+i
  print(sum)
}

i=0
while(i<10){
  print(i)
  i=i+1
}
#if는 for의 개념이 없어서 하나씩 다 넣어줘야 함
#if(iris[1:50,1]>7) --error
#if(iris[1:50,1]>7){
#  result=1
#}  else{
#    result=0
#  }
#} --error

#비교가 되도록 한 개씩 넣기
#s=c()#c를 이용하면 vector형식으로 값을 넣을 수 있음
#array, matrix, vector다 전부 가능
s=array(dim=c(1,50))#1행에 50열
str(s)
for(i in 1:50){
  if(iris[i,1]>5){
    s[i]=1
  }  else{
    s[i]=0
  }
}  
str(s)

#같은 식...5보다 크면(true) 1값 넣고 아니면(false) 0값 넣기
s1=ifelse(iris$Sepal.Length > 5,1,0)
#그래서 ifelse함수 많이 사용
#단어 유무에 따라 뽑아서 할 수 있음

#runif, rnorm 함수 존

#표본 만들기
ind1=sample(1:150.10,replace=T)#1~150 중에서 10개 뽑기(복원)
mean(ind1)#평균

#평균에 대한 평균 구하기 //bootstrap!!
m2=c()#c로 해서 만들면 배열처럼 나타남!!! 잘 이용해야 할 듯
for(i in 1:100){
  ind1=sample(1:150.10,replace=T)
    m1=mean(ind1)
    m2=c(m2,m1)#m2에 m1값을 누적하게 하는 것
}
  
hist(m2) #histogram
mean(m2)
#------------------------------------------------------------
#function
#return 문에는 괄호를()꼭 넣어줘야 함!!!!!!!!!!!!!!!!!!!!!!!!

sum1<-function(a,b){
  add1=paste(a,b)#paste함수 : 문자도 더해줌
  return(add1)
}
sum1('a','w')
sum1(2,3)
#----------------------------------------------------------
testfunc<-function(a,b){
  if (is.numeric(a)==TRUE&is.numeric(b)==TRUE){
    return(a+b)
  }else{
    #a=as.character(a)
    #b=as.character(b)
    #addC=paste(a,b) #string들 합쳐주는 것 // 반대는 split
    addC=paste(a,b,sep='')
    return(addC)
  }
}
testfunc(3,4)
testfunc('a',4)
testfunc()

sort()

5/3
5%%3 #mod 나머지 나옴
5%/%3 #몫만 나옴
pi
1:2*pi
x=seq(0,2*pi,0.01)
#임의의 데이터를 만드는데 오차가 생기도록 만드는 것
y=sin(x)+rnorm(lentth(x))#오차가 들어가도록 난수 발생 N0,1)
y=sin(x)+rnorm(length(x),0,0.1)#rnorm:nomal distribution
plot(x,y)
length(y)


#---------------------------------------------------------
#csv, image 파일 입출력(가설검정 전에 하는 데이터 가져오기)
#불러오기 1.
table1=read.table('clipboard',header=1)
# excel은 클립보드에서 복사한 거 바로 가져오는 거// header(X,Y)가 존재한다는 것 표시

#불러오기 2.(csv파일)
table2=read.csv('data1.csv')#read.fwf :데이터 자릿수 마다 파일 형식 지정가능하게 하는 것

str(table2)
names(table2)=c("x1","x2") #(header) 변수 이름 바꾸기

#불러오기 3.(xlsx파일)
#https://cran.r-project.org/에서 package 중 엑셀(xlsx)에 대해서 읽기 좋게 하는 
#library들이 많이 존재함
library(xlsx)
table3=read.xlsx('data1.xlsx',sheetIndex = 1)#sheet가 1번, header가 1행
#--------------------------------------------------------------------------
#iris3 data index가 ','종별로 끊어져 있음(행,열,면 구조)
#image가 RGB(red, green, blue)순서로에 분포도가 숫자로 들어가 있음
iris3
str(iris3)
#setosa 검색
iris3[,,1]

iris3[1,1,]#각 면에 대한 1행 1열의 정보

#png는 투명이 된다(알파-불투명도) - 그렇기 때문에 면 수가 4면
#jpeg는 투명이 없으므로 3면으로만 나옴

#해상도에 따라 사이즈가 다름
#28*28 픽셀 vs 32*32 픽셀

#image 불러오기--------------------------------------
#공통적인 image package --> 'readbitmap'
library(readbitmap)
#pattern이라는 옵션/////////

bmp1=read.bitmap('img7.bmp') #3차원으로 된 자료임
dim(bmp1) #해상도가 낮을수록 숫자가 작음 // 행, 열, 면 순서대로 나옴
jpg1=read.bitmap('img7.jpg')
dim(jpg1)
png1=read.bitmap('7.png')
dim(png1) #png는 알파값도 있기 때문에 기본적으로 4가 나오는데 크롬으로 했더니 3이 됨

jpg1_m=matrix(jpg1,nrow=1,byrow=T) #행방향으로 matrix만든다
png1_m=matrix(png1,nrow=1,byrow=T)

dim(jpg1_m) #1080*1920*3
dim(png1_m)
jpg1_m[1:10]
#R-bind함수, C-bind함수 기법 // image 읽으면서 누적으로 쌓기

#복수 개 데이터 일관적으로 읽어오게 하기 위해 list로 저장
list1=list.dirs('.',full.names = T) #현재는 마침표로 나타냄/풀 경로를 알려달라는 것
#폴더 명에 대해서 풀 경로를 다 알려달라는 명령어
list1

#경로가 바뀌게 하는 것
for(i in 2:length(list1)){
  list2=list.files('list1[i]',full.names = T,include.dirs = T)#al폴더 안에 있는
}#각 내부 폴더에 대해서 list2에 파일 명들이 for loop로 들어오게 
list2 #파일이 아무것도 없으면 null로 나옴
for(i in 2 : length(list1)){
  list2=list.files('.',full.names = T,pattern='.jpg',include.dirs = TRUE)
}#폴더에 jpg파일만 읽어오게
list2
