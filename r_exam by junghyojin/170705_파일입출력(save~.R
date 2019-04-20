
# 데이터 불러오기
#write(iris'data1.csv') # write는 확장자를 입력하지 않아도 알아서 해줌, 즉 write.csv로 안해도 된다는 것

methods(plot) # methods(plot)의 관계있는 함수의 종류를 모두 보여줌

# save, load : 저장하고 싶은 dataset을  R 파일로 저장 cf) Import Dataset으로 원하는 데이터 형식으로 불러올 수 있다.

x <- 1:5
y <- 6:10
save (x, y, file =" xy.RData ")
load('ab.Rdata')

rm(list=ls())


# dataset 설정(Environment) 및 dataset저장
a1 = iris
a2 =cars

save(a1,a2,file='a.rdata')
load('a.rdata')

  ### rbind: 행 기준, cbind : 열 기준   , 둘 다 모두 강제로 합쳐 버림(변수명, primary키 무시)    ###

x1=matrix(1:15, nrow=5)
x2=matrix(1:15, nrow=5, byrow = T)


y1=rbind(x1,x2) # rbind는 위,아래로 합침, 무조건 matrix 구조

y2=cbind(x1,x2)

x3=c(1,3)

for(i in 1:10) {
  x3 = c(x3,i)
  
}

x3


x4=c(1,2,3); x5=c(5,6,7) # ';' : 한 줄에 여러 개를 입력할 때

rbind(x4,x5) # x4,x5가 벡터값이 자연스레 행 단위로 
cbind(x4,x5)  # x4,x5가 벡터값이 자연스레 열 단위로


### merge (dataframe 구조, key가 있음) ###


xx <- data.frame ( name =c("a", "b", "c"), math =c(1, 2, 3)) # name 이름 할당
yy <- data.frame ( name =c("d", "b", "a"), english =c(4, 5, 6))
 merge (xx,yy) # 입력 순서가 중요 merge(앞,뒤) name에서 겹치지 않으면 그 결과값을 겹치는 것만 보여줌
 merge (xx,yy, all = T) # join 개념, 겹치지 않는 것 까지 모두 다 보여줌 

 
 xx <- data.frame ( name1 =c("a", "b", "c"), math =c(1, 2, 3)) # name 이름 할당
 yy <- data.frame ( name2 =c("d", "b", "a"), english =c(4, 5, 6))
 merge (xx,yy, all = T, by.x='name1', by.y='name2') # Field 명이 name1!=name2 와 같은경우(다를 경우) 이름을 직접 지정해줘야 함
 
  ### subset : 부분 추출(subset을 사용하면 기존에 데이터를 그대로 가져오기 때문에 재설정이 필요) ###
s1=subset(iris,Species == "setosa")
str(s1)

s1$Species = factor(s1$Species)
str(s1)
  
  ### split()은 데이터를 분리하는데 사용된다. 형식은 ‘split(데이터, 분리조건)’이다. ###

s2=split(iris,iris$Species)
str(s2) # list형식으로 됨, 여기서는 종류가 3가지니까 3개

  ###  sort(), order() : sort() - 값을 돌려줌, order() - 인덱스 값(위치 값, ex 행)을 돌려줌###

#1. sort

s3=c(1,5,3,7,9,2)
sort(s3) # 오름차순 정렬
sort(s3, decreasing = T) # 내림차순 정렬


#2. order

order(s3) # 본래 s3의 위치에 값을 보여주



  ### with() : 읽기 전용, within() :### 여러번 쓰고 싶지 않을 경우 with를 이용하여

# ex) print ( mean ( iris $ Sepal.Length ))
#[1] 5 .843333
# print ( mean ( iris $ Sepal.Width ))
#[1] 3 .057333
#위 두 명령은 번거롭게 ‘iris$변수명’의 형태로 코드를 적어야 했다. with를 사용하면 iris내에서 각 필드를 곧바로 접근할 수 있다.

#제5장 데이터 조작 I
# with (iris , {#
#  print ( mean ( #Sepal.Length ))
# print ( mean ( Sepal.Width ))
#  + })
#[1] 5 .843333
#[1] 3 .057333

#2. within : with + 수정가능 

# 데이터 결측 발생시 (삭졔) : na.rm = T
#mean(c(1:5),NA)) # 결측치 때문에 계산 못함
mean( c(1:5, NA), na.rm =T )


# ex)x <- within (x, {
#   val <- ifelse ( is.na (val), median (val , na.rm = TRUE ), val)
#   } : na이면 삭제하고, 아니면 본래값을 넣어라는 의미



## which(), which.max() : 찾은 값 중 가장 큰값, which.min(): 찾은 값중 가장 작은 값 ##

x=c(2,4,6,7,10)
x%%2

which(x%%2 ==0) # 나머지가 0인 것에 위치를 보여줌

x[which(x%%2 ==0) ] # 나머지가 0인 것에 값을 보여줌

which.max(x)

which.min(x)

  ### apply 함수들  : 반복처리 /  중요~~~~~~~~~~~~~~~~~~###

d=matrix(1:9,ncol=3)

# matrix 전체 값을 반환
sum(d)
mean(d)

# '행' 별 or '열' 별로


for(i in 1:nrow(d)) {
print(mean(d[i,]))  
}



?apply
## apply 함수 사용방법 : apply(값, 행 or 열 방향 설정, )

apply(d,1,sum) # 1이 행뱡향, 2가 열방향

#1. lapply() : margin이 없음 , lapply(x= 벡터 or  리스트 ,함수) 단, 결과값은 리스트로 나옴


#2. sapply() : 결과값을 벡터로 반환


#3. tapply() 각 필드별(열)로 값을 구하고 싶은 경우, tapply(  데이터  , 필드  ,함수   )

iris
tapply(iris$Sepal.Length,iris$Species, sum) 
tapply(iris$Sepal.Length,iris$Species, min)

#4. mapply() : mapply(    function(i,s)    ) {  ~~~~~  }: i,s 넘겨주는 인자값(반복)


  ### doBy 패키지### :do By + 조건 : By 뒤에 오는 조건에 따라서 처리하겠다

 install.packages('doBy')
library(doBy)
summaryBy() # summaryBy(  영향을 받는 애  ~ (기준)   영향을 주는 애, data   )
?summaryBy
summary(iris)  # 필드별로 통계치
summaryBy(.~Species, iris) # 그룹별로 통계치,  " . " 의 의미 : 나머지 다
summaryBy(Sepal.Length~Species, iris)
summaryBy(Sepal.Length~Species, iris, Fun = median) # median값을 보여줌


## sample에서 가중치 주기 

sample(1:5, 100  ,replace = T, prob =c(1,3,1,1,1)    )# 더 많이 뽑을 것에 가중치 주기
sample(1:20, 200  ,replace = T, prob =c(1,3,3,rep(1,17))  )

# 빈도수 체크
table(sample(1:20, 200  ,replace = T, prob =c(1,3,3,rep(1,17))  ) )

?sampleBy
sampleBy(Sepal.Length ~ Species ,data=iris, frac =0.1)  #frac =0.1 : 10% 미만 갯수로 나오게 ㅎ
sampleBy(Sepal.Length ~ Species ,data=iris, frac =0.1, systematic = T) # 15개씩 대칭으로 (임의적으로 뽑는게 아님) 

## aggregate를 통한 (=summary와 비슷)


  ### stack과 unstack (중요!)   ###

#1. stack : 흩어져 있는 변수들을 묶는 함수



#2. unstack : stack으로 묶은 것을 다시 풀어주는 함수


 ### melt 함수 : melt() 함수는 인자로 데이터를 구분하는 식별자(id), 측정 대상 변수, 측정치를 받아 데이터를간략하게 표현한다.

 #m <- melt (id =1:4 , french _ fries )
 #head (m)
#time treatment subject rep variable value # : variable, value 빼고 이전에는 식별자, 이 두개는 알아서 합침
#1 1 1 3 1 potato 2.9
#2 1 1 3 2 potato 14 .0
#3 1 1 10 1 potato 11 .0
#4 1 1 10 2 potato 9.9
#5 1 1 15 1 potato 1.2
#6 1 1 15 2 potato 8.8


    ### RMySQL :  db(MySQL)에서 가져오는 방법 ###

#순서 : 접근 - 

install.packages("RMySQL")
library(RMySQL)


# 예시
# con <- dbConnect ( MySQL () , user =" mkseo ", password =" 1234 ", dbname ="
# mkseo ", host ="127 .0.0.1 ")
# dbListTables ( con)


## score 안에 데이터 가져오기
# dbGetQuery(con, "select * from score" )




t.test
