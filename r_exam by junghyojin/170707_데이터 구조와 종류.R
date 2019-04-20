### 데이터 구조 종류 ###
 
  ## 스칼라 : 하나의 변수 안에 하나 
a=5
a2="a"
 
  ## 벡터 

a3=1:3 # 하나의 변수안에 세 개의 값이 존재(한 행에 여러열 :벡터, 쉼표가 없음

a3[2] #  벡터에서 값 불러오기

#1. matrix 구조 (행과 열의 구조, 내부 데이터 값의 형식이 통일이 되어야함 ex) int )

a4=matrix(1:15,nrow=3)

a5=a4[2,1] #matrix에서 값 가져오기, 단 이때는     
str(a4)


a6=array(dim=c(3,2,3)) # 안에 값은 없지만, 3행, 2열, 3면 의 공간을 만들어 놓음
str(a6)

#2. dataframe 구조 : '열' 별로 다른 데이터 타입을 넣을 수 있다. (matrix와의 차이점) 
a7=data.frame(1:3, rep(1:3), LETTERS[5:7]  ) 
str(a7)
a7$X1.3 # $를 쓰면 속성값을 가져올 수 있음 

# 행과 열이 있는 구조

a9=a7[2] # 행 ,열을 모두 기입안하고 하나만 입력하면 '열'을 가져옴
str(a9) # data.frame 구조임 : '열' 만이라고 생각할 수 있는데 '행'과 '열'이 모두가 있는 거임

a9=as.matrix(a7[2])
str(a9) # data.frame 이 아니라 int형으로 바뀜


a10=as.matrix(a7) # 동일한 데이터 타입으로 전체를 통일
str(a10) # 숫자와 문자가 둘다 있음. 이때는 형태가 문자로 바뀜, 문자로 통일됨( 이때는 숫자들의 값을 비교할 수 없음) 



#3. list구조 : 값에 '변수'가 들어갈 수 있음(변수 안에 변수가 들어갈 수 있음, 가장 넓은 스펙트럼)

a8=list(a=a,a2,a3,a4,a6) # a=a : 앞에 a : 변수명, 뒤에 a:값
 str(a8)
 
 #조건을 열 기준이면 열에 입력, 행이면 행에 입력(데이터 탐색 방향 기준에 따라서)
 # ex) iris[  조건    ,      ]
 
 a10= iris[iris$Sepal.Length>=6.5  ,   ] 
 a11=rownames(iris[iris$Sepal.Length>=6.5  ,   ] ) #여기서는 행 이름이 '번호'로 되어있어서 번호를 가져옴
 a12=rownames(iris[which(
   iris$Sepal.Length>=6.5)  ,   ] )
 
table(iris$Sepal.Length>=6.5)
 
 rownames( ) # 행 이름을 가져와라
 colnames() # =names    열 이름을 가져와라
 
 
 
 
 install.packages('mlbench')
library(mlbench) 
data(Vowel)
View(Vowel) 
 
 # grep함수: grep(    , data  )# i가 들어가 있는냐  *글자 찾는 함수* 
grep('i',Vowel$Class) # i가 들어가 있는 행을 다 찾아줘라 
v1=Vowel[grep('i',Vowel$Class), ]
View(v1) 
 
 
 
 


