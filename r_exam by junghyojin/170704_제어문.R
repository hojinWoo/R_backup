rm(list=ls())

x=5

  ### if문 기본 개념 ###  

if (x > 6) {    
  print ('TRUE')
  print ('hello')
} else {
  print ('FALSE')
  print ('world')
}


  ### for문 기본 개념 ###

# %in% : 왼쪽값이 오른쪽에 있냐, 없냐 
x %in% c(1,4,7,5)


 # 첫번째 i 값에 1이 들어감, 두번째 i값에 3, 세 번째 5
for (i in c(1,3,5)) {
}



sum = 0
 # i에 1~100까지 3씩 커지면서 값을 넣음 1,4,7,10...
for( i in seq(1,100,3)){
  sum = sum + i
  print(sum)
}


s = array(dim=c(1,50))    # 1행 & 50열 dimesion 생성
str(s)

for(i in 1:50  ) {
if(iris[i,1] > 6) {
  s[1,i] = 1
} else {
  s[1,i] = 0
}
}
s


 # ifelse : 더 효율적인 함수 , ifelse(조건,참값, 거짓값)

s1 = ifelse(iris$Sepal.Length> 7, 1,0) # if-else를 통해 7보다 큰값은 1, 아니면 0 
s1


  # 모집단에서 표본 을 뽑아 평균 구하기 

m2=c() # 벡터 형태의 자리만 생성  
for(i in 1:100) {
ind1 = sample(1:150,10,replace = T)
m1=mean(ind1)
m2=c(m2,m1)  ## 중요!!!
}
str(m2)
hist(m2)
mean(m2)

mean(1:150)




  ### 함수 만들기 ###

add = function(a,b){    # 받을 값을 function(a,b) 괄호안에 씀
  add1 = a+b
  return(add1)
}
add(5,3) 


  ## Is, As ##

add2 = function(a,b){
if(is.numeric(a) == T) {
  add = a+b
  return(add)
}else {
  add=paste(a,b,sep = '-') # sep = ' ' 공백 설정
  return(add)
}
}

add0=add2(3,6)
add0

add0=add2("k","sss")
add0


  ## '%' 연산자 ##
  5/3
  
  5%%3    # 나머지 값을 보여즘
  
  5%/%3   # 몫을 보여줌
  
  (5%%3 ==0) | (5%%3 ==1) 
  
  (x>=5) & (x < 10)

pi
1:2*pi # 앞뒤 모두 곱해짐
1:(2*pi) 
x=seq(0,2*pi,0.01)
y=sin(x)+rnorm(length(x)) # rnorm 부분이 정규분포에 대한 
length(y)

plot(x,y)






