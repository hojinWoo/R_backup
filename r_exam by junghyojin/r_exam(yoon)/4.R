x=5
if ( x >6 ) {
  print ('TRUE ')
  print ('hello ')
} else {
  print ('FALSE')
  print ('world' )
}

#내가 지정한 값이 오른쪽안에 들어있는지
x %in% c(1,4,7,5)

#i in c(1,3,5) i가 1,3,5순으로 처리 i in seq(시작값, 종료값, 증감값)
sum = 0
for(i in seq(1,100,3)) {  
  sum = sum + i
  print(sum)
}

#dim은 행과 열의 수를 넣어줌 
s = array(dim=c(1,50))
str(s)
for(i in 1:50 ){
if(iris[i, 1] > 6.5 ) {
  s[1, i] = 1
} else {
  s[1,i] = 0
}
}

#ifelse(조건, 참일경우 값, 거짓일 경우 값)
s1 = ifelse(iris$Sepal.Length > 7, 1, 0)

#무작위로 표본 100개 뽑아서 평균내기
m2 = c()  #combine은 1행 n열의 벡터공간
for(i in 1:100){ 
ind1 = sample(1:150, 10, replace = T)  #복원추출
m1 = mean(ind1)
m2 = c(m1,m2) #순서는 상관없음
}
hist(m2)
mean(m2)
mean(1:150)

#function 안에 그 문안에서 사용할 변수 지정해줌. 숫자면 덧셈 문자면 붙여줌 
add = function(a,b){ 
  add1 = a+b #문자면 paste(a,b)
  return(add1)
}
add(3,5 )

#-이다 아니다 판단 a가 숫자인지판단하기 / == 는 T,F판단
add2 = function(a,b){
if(is.numeric(a)== T) { 
  add = a+b
  return(add)
}else {
  add = paste(a, b, sep = " ") #sep 뒤에 오는 거가 글자사이에 들어감
  return(add)
}
}

add0=add2("a",4) #문자열은 "" 넣어주기
sort()
as.numeric() #-로 바꿔달라(as)
getwd() #현재경로 보여줌

5/3
#나머지
(5%%3 ==0)|(5%%3 ==1)
5%/%3 #몫
  
pi
1:(2*pi)
x = seq(0, 2*pi, 0.01)
y = sin(x) + rnorm(length(x)) #sin 모양으로 x가 분포되어있음
length(y)
plot(x,y)

##데이터 불러오는 방법들 정리

#엑셀에서 ctrl+c로 클립보드 해놓은 상태에서 바로 불러오는 방법
data1 = read.table('clipboard', header = T) 
#엑셀에서 csv로 저장해서 불러오skip은 위에서 몇번째줄 데이터로 안읽고 header로 쓸지
data2 = read.csv('data1.csv') 
str(data2)
names(data2) = c("x1","x2") #복수값을 넣을때는 다 C를 사용 data2의 변수명 바꿈

#library(xlsx)
#startrow는 몇번째 줄부터 불러올건지
data3 = read.xlsx('data1.xlsx', sheetIndex = 1)
data3

#이미지 데이터
iris3
str(iris3) #행, 열, 면이 있는 3차원/3가지 종류의 데이터가 모두 행, 열의 개수가 같은 경우 3차원으로 표현이 가능
iris3[ , ,1] 

iris3[1,1,] #첫번째 면에서 1행 1열값, 두번째 면에서 1행 1열값, 세번째 면에서 1행 1열값

#library(readbitmap)
bmp1 = read.bitmap('img7.bmp')
dim(bmp1) #
jpg1 = read.bitmap('img7.jpg') 
dim(jpg1)
png1 = read.bitmap('img7.png')
dim(png1)
jpg1_m = matrix(jpg1, nrow =1, byrow = T)
png1_m = matrix(png1, nrow = 1, byrow = T)
jpg1_m[1:10]
dim(jpg1_m)#해상도가 높아질수록 변수의 수가 많아진다.
dim(png1_m)

list.dirs #폴더명 리턴
list.files#파일명 리턴

list1 = list.dirs('.', full.names = T) #현재폴더 안에 있는 폴더의 이름을 가져옴 
for(i in 2:length(list1)){
list2 = list.files('.', full.names =T , include.dirs = T)#디렉토리 명을 가져옴 
}
list2

for(i in 2:length(list1)){
  list2 = list.files(list[i], full.names =T , pattern = '.jpg', include.dirs = TRUE)
}





