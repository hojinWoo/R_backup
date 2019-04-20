
data=iris[1:100,]

levels(data$Species)
table(data$Species)
#level 수 줄일 필요가 있음(사전 작업 필수!!!)
data$Species=factor(data$Species)


#glm(일반화 회귀 모형)
(m=glm(Species~.,data,family=binomial))
#앞에도 괄호하면 저장과 동시 실행된 결과 바로 확인 가능

set.seed(1000)
ind=sample(nrow(data),(nrow(data)*0.7),replace=F)
train=data[ind,]
test=data[-ind,]

(m=glm(Species~.,data=train,family=binomial))
#확률 값
m$fitted.values

train_y=ifelse(m$fitted.values<0.5,1,2)
table(train_y)
table(train$Species)
#확률로 testing
pred=predict(m,newdata=test,type="response")#response : 확류, class : level로 나타
table(pred)

pred1=ifelse(pred<0.5,1,2)
table(pred1)
table(test$Species,pred1)

#다중로지스틱
set.seed(1000)
ind=sample(nrow(iris),(nrow(iris)*0.7),replace=F)
train=iris[ind,]
test=iris[-ind,]

library(nnet)
(m=multinom(Species~.,data=train))
#확률 값
m$fitted.values

m_class=max.col(m$fitted.values)#가장 큰 값이 몇 번째 열인지 확인하려고
table(m_class)
table(train$Species,m_class)


#확률로 testing
pred=predict(m,newdata=test,type="class")#response : 확류, class : level로 나타
table(test$Species,pred)#숫자가 많아질수록 성능이 떨어짐//
#고차원, 필터링 등의 기법이 더 요구됨

#다항인 경우
library(mlbench)#data.frame들이 들어있음(17개의 column으로도 되어있음)
data(Sonar)
summary(Sonar)
View(Sonar)

set.seed(100)
ind=sample(nrow(Sonar),nrow(Sonar)*0.7,replace = F)
train=Sonar[ind,]
test=Sonar[-ind,]
(m=glm(Class~.,data=Sonar,family=binomial))
m$fitted.values
train_y=ifelse(m$fitted.values<0.5,1,2)
table(train_y)
pred=predict(m,newdata=test,type="response")
pred1=ifelse(pred<0.5,1,2)
table(test$Class,pred1)

as.integer(FALSE)#틀린 거 개수

library(party)
c1=ctree(Species~.,train)
plot(c1)#p :p-value
c1=ctree(Species~.,train,controls = ctree_control())

pred2=predict(c1,newdata=test)
sum(pred2==test$Species)/nrow(test)
table(test$Species,pred2)

data(Vowel)
nn=nrow(Vowel)
set.seed(1000)
ind2=sample(nn,nn*0.7,replace=F)
train1=Vowel[ind2,-1]
test1=Vowel[-ind2,-1]  

c2=ctree(Class~.,train1)
pred3=predict(c2,newdata=test1)
table(test1$Class,pred3)
sum(test1$Class==pred3)/nrow(test1)  #변수 수가 많을수록 적중률이 떨어

library(tree)

ir.tr=tree(Class~.,train1)
plot(ir.tr)
text(ir.tr,all=T)

#가지치기, 모형을 바탕으로
ir.tr1=snip.tree(ir.tr)#이것은 그 전 것이랑 같게 나옴/ control 옵션으로 하나씩 지정 가능
plot(prune.misclass(ir.tr))
ir.tr1=prune.misclass(ir.tr,best=14)
plot(ir.tr1)
text(ir.tr1,all=T)

#random forest
library(randomForest)
m=randomForest(Species~.,data=iris)
r1=randomForest(Class~.,data=train1)
r1$predicted
t1=table(train1$Class,r1$predicted)
sum(diag(t1)/sum(t1))#그룹의 개수가 많d은경우 활용
pred4=predict(r1,newdata=test1)
t2=table(test1$Class,pred4)
sum(diag(t2)/sum(t2))  
#Watson도 95~96%의 정확도


#MNIST 작업(축소화 한 거)------------------------
train=read.csv('https://github.com/ozt-ca/tjo.hatenablog.samples/raw/master/r_samples/public_lib/jp/mnist_reproduced/short_prac_train.csv')
test=read.csv('https://github.com/ozt-ca/tjo.hatenablog.samples/raw/master/r_samples/public_lib/jp/mnist_reproduced/short_prac_test.csv')

str(train)
train1=train#data handliing
train1$label=factor(train1$label)
str(train1[1])
test1=test
test1$label=factor(test$label) #table만들기 위한 밑작업

r2=randomForest(label~.,train1)
View(r2)
pred2=predict(r2,newdata=test1)
t2=table(test1$label,pred2)
sum(diag(t2))/sum(t2)

train2=train1
test2=test1
train2[,-1]=round(train2[,-1]/255,0) #1,0으로 들어가는 구조
test2[,-1]=round(test2[,-1]/255,0)
start1=Sys.time()
r3=randomForest(label~.,train2)
interval1=Sys.time()-start1

pred3=predict(r3,newdata=test2)
t3=table(test2$label,pred3)
sum(diag(t3))/sum(t3) # 1,0으로 되어있는 구조는 CNN기법이 더 훌륭함

#Dnn(deep neural network) /
data(DNA)#library (mlbench)
View(DNA)
summary(DNA)
str(DNA)
ind=sample(nrow(DNA),nrow(DNA)*0.7,replace=F)
train=DNA[ind,]
test=DNA[-ind,]
start1=Sys.time()
t1=randomForest(Class~.,train)
interval1=Sys.time()-start1
pred1=predict(t1,newdata=test)
t2=table(test$Class,pred1)
sum(diag(t2))/sum(t2)


library(readbitmap)
img7=read.bitmap('img7.bmp',channel=2)
str(img7)
image(img7)
#------------------------------------------------
im1=as.matrix(train[1,-1])
str(im1)
m1=matrix(im1,nrow=28,byrow=T)#행이 28개가 되도록
str(m1)
image(m1)
#---------------------------------------------------
test5=(img7)
str(test5)
View(test5)

predict(r2,newdata=test5)
matirx(train[1,-1],nrow=28,ncol=28)

#광고성 문자가 스팸인지 아닌지 판단할 수 있는 기법
library(rvest)
library(httr) #크롤링 기법

#httr library에서 get함수를 통해 url자료 안에 있는 것을 그냥 다 가져올 수 있음
text1=GET(url="http://terms.naver.com/entry.nhn?docId=1691554&cid=42171&categoryId=42183")

#rvest library에서 html_을 통해 원하는 것을 추출할 수 있음
text2=html_text(text1)#error... 본문형만 먼저 따로 빼야 함

#read.html이 필요-->XML2 library안에 있음
text2=read_html(text1)#html안에 있는 부분(본문)만 추출함
html_text(text2)#안에 있는 tag들도 삭제

#크롤링 순서
#1. 원하는 주소 get을 통해 가져오기
#2. 본문영역만 필요할 시 read.html을 통해 추출 하고
#3. html_text을 통해 원하는 부분만 읽으면 된다

#원하는 부분만 가져오는 법
text3=html_nodes(text2,"div.info_tmp_wrap")#한 항목만 가져오려면 node, 여러개 가져오려면 nodes
text4=html_text(text3)

text5=html_nodes(text2,"h3")
text6=html_text(text5)

#url="https://search.naver.com/search.naver?where=news&query=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EB%B9%85%ED%8C%8C%EC%9D%B4&ie=utf8&sm=tab_opt&sort=0&photo=0&field=0&reporter_article=&pd=3&ds=2015.01.01&de=2017.07.13&docid=&nso=so%3Ar%2Cp%3Afrom20150101to20170713%2Ca%3Aall&mynews=0&mson=0&refresh_start=0&related=0"
url="https://search.naver.com/search.naver?ie=utf8&where=news&query=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EB%B9%85%ED%8C%8C%EC%9D%B4&sm=tab_pge&sort=0&photo=0&field=0&reporter_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:all&mynews=0$cluster_rank=60%start="
#네이버 뉴스 크롤링 기법
tot=c()
for(i in seq(1,449,10)){
  url1=paste(url,i,"&refresh_start=0") #한 문장이 되도록 결합
  #print(url1)
  Text1=GET(url1)
  Text2=read_html(Text1)
  Text3=html_nodes(Text2,"h2")
  Text4=html_text(Text3)#vector로 추출
  tot=c(tot,Text4)
} 








