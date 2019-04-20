#data format에 따라 알아서 처리
write#확장자에 따라 알아서 해줌
write.xlsx(iris,'data1.xlsx')#파일은 xlsx로 저장하려고 할 때
#rstudio는 우에 'import dataset'을 통해 편하게 불러올 수 있으
#save도 편하게 가능
save(x,y,file="aa.RData")
load("aa.RData") #save하고 load할 때

methods(plot) #plot에 관한 다양한 명령어들


rm(list=ls())

a1=iris
a2=cars

save(a1,a2,file='a.rdata')#workspace에 저장됨
load('a.rdata') #불러와서 우측에 data set이 저장 됨
#나중에 data set을 저장하고 다음에 불러오는 경우들에 편하게 사용할 수 있음

#특성에 맍는 데이터들을 묶어서 관리하기 용이하게 하기 위해서

#이 경우는 강제로 합치는 것(cf)primary key에 맞게 합치는 것은 merge)
#공공데이터들을 다운 받고 구분할 때
#rbind=row
#cbind=colunm
#matrix나 data frame구조에서 자주 사용111111111111

x1=matrix(1:15, nrow=5) #byrow는 default가 false 열 순서대로
x2=matrix(1:15,nrow=5,byrow = T) #행 순서대로 차례대로 넣기

y1=rbind(x1,x2) #열 밑에 추가
y2=cbind(x1,x2) #행을 추가해서 삽입

x3=c(1,3) #c함수는 vector단위!!!!!!!!!!!!!
for(i in 1:10){
  x3=c(x3,i)
}
for(i in 1:10){
  x3=cbind(x3,i)
}
  
x4=c(1,2,3); x5=c(5,6,7)

rbind(x4,x5)
cbind(x4,x5)# 강제로 합칠 때

#merge는 data frame구조들일 때 각각에 대한 열명(picture, variable)을 
#primary key로

#ex, name을 기준으로 merge
data1=data.frame(name1=c("a","b","c"),math=c(1,2,3))
data2=data.frame(name2=c("d","a","f"),english=c(4,5,6))
data3=merge(data1,data2)#primary key가 없으면 전체가 합쳐지
#primary key에서 변수가 중복되는 것만 뒤에 내용이 합쳐짐 // 없는 것들은 자동적으로 없어짐
#DB에서 join하는 경우와 비슷
#primary key가 동일하지 않은 경우는 두 가지에 key를 합쳐주는 작업이 필
data3=merge(data1,data2,by.x='name1',by.y = 'name2')

#전부 보려면
data4=merge(data1,data2,all=T)

iris
str(iris)

#subset : 부분집합 만들기
s1=subset(iris, Species=="setosa") 
str(s1)
#subset은 data에 맞게 재선언 필요
s1$Species = factor(s1$Species) #factor값은 거의 그대로 틀을 갖고 오기 때문에 다시 수정 필요


#split
s2=split(iris,iris$Species)#list형태로 data가 들어감 각각의 group에 나뉘어져 들어감
str(s2)
#s2$Species=factor(s2$species)#list형태라 사용하면 안 됨
#unlist를 해서 하는 것이 현명

#sort는 값을 반환하고, order는 원래 위치의 index를 돌려줌
#행 단위로 움직이는 것이기 때문에 각각의 값의 크기를 알 수 있음(order를 사용할 때)
s3=c(1,5,3,7,9,2)
sort(s3,decreasing=T)#값을 지정시 행단위가 아니라 값에 맞에 움직임//내림차순
order(s3,decreasing=F)#순서대로 정렬하고 각각의 값이 원래 어디 있었는 지 위치를 알려줌

#중복된 것을 계속 쓰기 힘들 때 (상위의 것을 앞에)
#with   : 읽기 전용(수정X) - 
#within : 수정 가능 [ifelse로 수정] //값이 없는(결집체) 것들을 없애거나 할 때
mean(c(1:5,NA))#안에 숫자만 존재해야 계산 가능
mean(c(1:5,NA),na.rm = T)#NA값들을 제거하고 남은 것의 평



#attach, detach

#which 조건 중 찾아낸 값들을 찾아냄 (최대값, 최소값)

#apply
d=matrix(1:9,nco=3)
for(i in 1:nrow(d)){
  print(mean(d[i,]))
}
  
apply(d,1,sum)
#group별로 처리
tapply(iris$Sepal.Length, iris$Species,min)

#doBy package 항상 뒤에 by가 붙음
#by 뒤에 따라서(그룹 or 조건) 앞에 것을 함 

#install.packages('doBY')
library(doBy)
#?summaryBy
summary(iris)#field별로
summaryBy(Sepal.Length~Species,iris,FUN = median)#field별로/fun은 어떤 집계를 낼 것인지

#cf. 정규표현식을 연습하는 것 중 가장 좋은 방법은 카카오톡 데이터를 사용하는 것


#sampleBy 가중치를 줄 수 있음
sample(1:5,100,replace=T)
sample(1:20,200,replace=T,prob=c(1,3,3,rep(1,17)))
#2와 3이 가중치가 크게 나옴 1은 1만큼, 2와 3은 3만큼 그 다음은 1만큼 가중치
?sampleBy #앞에 나온 formula를 group 별로 factor
sampleBy(~Sepal.Length,data=iris, frac=0.1)#비대칭적 (전체 조각의 10%)
#앞에 것을 기준으로 
aa=sampleBy(~species,data=iris, frac=0.1,systematic = T)#대칭적으로
str(aa)#소문자 대문자가 왜 차이있지???????????????????????Length vs length
#것---------------->구분이 없고 오작동이 난 듯/ ~뒤에 나오는 것이 기준!
#stack보다 melt를 더 자주 사용
iris


#sql 
install.packages('sqldf')
library(sqldf)
sqldf("select distinct Species from iris")
sqldf("select avg(Sepal.Length) from iris where Species='setosa'")
#마침표로 구분하면 SQl에서는 인식이 안됨.
names(iris)=c('Sepal.Length','Sepal.width','Petal.Length','Petal.width','Species' )# 그래서 변수명들의 이름들을 바꿈

sqldf("select avg() from iris where SP='setosa'")

#---------------------------------------------------------
library('MASS')
data("survey")
View(survey)
#집단 간 차이 검정 -t검정 사용//
#분산 분석-ANOVA기법
#함수 관계식 -선형관계식 linear modeling
#분석 시에 나오는 다양한 수치들에서 어떻게 검증이 된 것 인지 추정과 검정 단계 필요
#NA 데이터는 지우고 집단 간 비교

#t-test, 두개의 집단을 물결모양식처럼 사용, 그룹 변수는 factor로 
model1=t.test(Height~Sex,survey)
#귀무가설, 대립가설, 가설검


rm(list=ls())
data1=rnorm(100,mean=180,sd=10)#정규분포의 형태로 난수 생

?t.test
# t.test(,alternative=,paired=, conf.level=)
# alternative 옵션은 양측검정(기본값)or단측검정 선택
# paired 옵션은 쌍을 이루는 데이터 (ex) 한 사람의 전/후 데이터 > 양이 동일해야 해
# conf.level=0.95 가 기본값 (신뢰수준)

t.test(x=data1,mu=180) # p-value > alpha=0.05 이므로 귀무가설 채택 / "평균이 180이다."

# xbar로부터 mu가 어느 범위에 속하는지 역추적 가능

t.test(x=data1,mu=200) # p-value < alpha=0.05 이므로 귀무가설 기각 / "평균이 200이 아니다."

data2=rnorm(100,mean=160,sd=5) # data1과 data2는 이분산

var.test(x=data1,y=data2) # 두 데이터가 등분산인지 이분산인지 먼저 검정
# 분산의 비는 F-분포를 따라 > 위의 검정 결과를 보면, F-값이 나온 것을 볼 수 있어
# 분산이 동일하다면 F-값이 1이 나와
t.test(x=data1,y=data2,var.equal=F)





