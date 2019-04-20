summary(iris)
x=table(iris$Species)

x1<-1 #오른쪽 값을 왼쪽으로 넣음
2->x2  #왼쪽 값을 오른쪽으로 넣음

x3 = 1:10
x3
x4 = c(1,5,3,9)
x4[2] #2번째 위치에 해당하는 값을 가져옴

x5 = matrix(1:15, ncol = 3, byrow = T) #byrow에 T는 데이터를 행방향으로 채움
x5[2:4,3] #X5[행,열,면]
x5[C(2,4), 3]
x5[-C(2,4), 3] # -는 내가 지정한 반대
str(iris) #obs행 variable 열 factor는 범주형데이터

x1=c(1,2,3,4,5,4,3,6,7,1000)
sum(x1)/length(x1) #mean 함수와 동일(산술평균)
mean(x1)
((n/2) + ((n/2)+1))/2 #중앙값 찾는 공식
median(x1)

#데이터 샘플링방법1
sample(1:45, 6, replace = F) #T는 복원 F는 비복원 (범위, 개수, 복원 OR 비복원)
ind = sample(1:nrow(iris), 150, replace = F) #iris 데이터 전체다
A1 = iris[ind, ]
View(iris) #미리보기
View(A1) #골고루 섞이게 보여짐

#샘플링2
ind1 = sample(1:nrow(iris), nrow(iris)*0.7, replace = F) #전체데이터에서 70프로를 뽑아냄
train = iris[ind1,]
test =iris[-ind1,]


summary(iris)
#시각화1
hist(iris$Petal.Length) #히스토그램 (여기는 두개의 그룹으로 나타남 왼쪽에는 데이터가 쏠려있고 오른쪽은 정규분포모양)

#시각화2
boxplot(iris[, 1:4]) #행생략되면 모든행을 나타냄 가운데 진한선이 중앙값 
                     #그리고 박스 위아래가 1,3사분위수 3-1 사분위하게되면 사분위범위
                     #위아래 값을 넘어가는 것은 이상값

#표준화 (함수 scale)
View(iris)
A2 = iris
A2[, 1:4] = scale(iris[, 1:4]) #열 1부터 4까지 나오게 행전부다
View(A2)

str(iris) #setosa 1, versicolor 2, virginica 3
nlevels(iris$Species) #몇가지 종류가 있는지 세줌
levels(iris$Species) #종류가 뭐있는지 나타내줌

#패키지 불러와서 자료활용방법
library(MASS) #패키지불러오기
data(survey) #안에 자료불러오기
View(survey)

table(survey$Sex, survey$W.Hnd) #교차표 제작가능
t1 = table(survey$Sex, survey$Smoke) #추가로 각 주변합을 구해서 확률을 구할수 있음 -> 기대도수 기대확률
prop.table(t1, 1) #여기안에는 배열 못넣음 테이블을 따로 변수로 지정해줘서 그 값을 넣어야함
                  #margin 값이 1이면 행의 합이 1이 되도록 2면 열의 합이 1이 되도록
                  #table(테이블, margin값 넣기)
prop.table(t1, 2) #열의 합이 1
barplot(t1) #막대그래프 이거랑은 다르게 꺾은선그래프는 추세를 나타냄

plot(iris$Petal.Length, iris$Sepal.Length) #산점도 x마다 y마다 상위 5프로 하위 5프로를 잘라내고 나머지로 평균구함
                                          #전체 데이터에서 위치상 잘라내는게아니라 각 데이터마다 잘라냄
                                           #하나의 선으로 만드는게 아니라 분위수마다 여러개의 분포를 찾아낼 수 있음

#절사평균구하는 방법
n = round((length(iris$Sepal.Length)*0.1)/2,0) 

x1 = sort(iris$Sepal.Length)[(n+1):(length(iris$Sepal.Length)-n)] #sort는 오름차순으로 정렬 그리고 대괄호부분은 
                                                    #앞에서 9번째부터 뒤에서 8번째까지 나타남 이게 백터라서 length
                                                    #여기서 length 대신 ncol써도 상관없음. 괄호 잘 닫아주기
x1
str(x1)

n1 = round((length(iris$Petal.Length)*0.1)/2,0)
y1 = sort(iris$Petal.Length)[(n1+1):(length(iris$Petal.Length)-n1)]
y1
plot(y1,x1)

#정규분포발생시키는 함수 밑의 조건으로 데이터 1000개 발생
hist(rnorm(100000, mean = 100, sd= 3)) #데이터 개수 많아질수록 정규분포에 가까워짐
hist(rnorm(100000)) #이게 표준정규분포

cor(iris[,1:4])#상관계수 구하는 함수
cor.test(iris$Sepal.Length, iris$Petal.Length) #두 변수간 상관관계가 있는지 없는지







