wbcd=read.csv('wisc_bc_data.csv',header=T,stringsAsFactors = F,sep=',')
str(wbcd)

#Removing id field which is not required for prediction.
wbcd=wbcd[,-1]
wbcd$diagnosis=factor(wbcd$diagnosis)

#type확인
levels(wbcd$diagnosis)
nlevels(wbcd$diagnosis)#level의 개수

#단위 표준 - normalize or scale업
wbcd_n=wbcd#재활용
wbcd_n[,-1]=scale(wbcd_n[,-1])#첫 factor들은 정규화 작업 필요 없음

#data splitng
nn=nrow(wbcd_n)

train=wbcd_n[1:(nn*0.7),]
test=wbcd_n[-(1:(nn*0.7)),]#(nn*0.7)+1:nn
View(train)
library(class)
pred1=knn(train[,-1],test[,-1],train[,1],k=3)#첫번째 열들(lable)은 제외

#정확도 확인
t1=table(test[,1],pred1)
cor1=sum(diag(t1)/sum(t1))

#최적의 k값 찾기
out1=data.frame()
for(i in 1:24){
  pred1=knn(train[,-1],test[,-1],train[,1],k=i)
  t1=table(test[,1],pred1)
  cor1=sum(diag(t1)/sum(t1))
  out2=cbind(i,cor1)
  out1=rbind(out1,out2)
}
out3=which.max(out1[,2])
out1[out3,]
for(i in 1:10){
  c1=1-i
  c=c(c,c1)
}
#---------------------------------------------------
View(iris3)
train=rbind(iris[1:35,,1],iris[51:85,,2],iris[101:135,,3])
test=rbind(iris[36:50,,1],iris[86:100,,2],iris[136:150,,3])
View(train)
View(test)
fact=factor(c(rep("setosa",35),rep("versicolor",35),rep("virginica",35)))
View(fact)
str(fact)
pred2=knn(train[1:4],test[1:4],cl=fact,k=3)
t2=table(test[,5],pred2)

out1=data.frame()
for(i in 1:13){
  pred2=knn(train[1:4],test[1:4],cl=fact,k=i)
  t2=table(test[,5],pred2)
  cor3=sum(diag(t2)/sum(t2))
  out2=cbind(i,cor3)
  out1=rbind(out1,out2)
}
out3=which.max(out1[,2])

#k-clusting기법 예시
a=c(1,6)
b=c(2,4)
c=c(5,7)
d=c(3,5)
e=c(6,2)
f=c(5,1)
c_data=data.frame(a,b,c,d,e,f)
c_data=t(c_data)#tras
d=dist(c_data,method="euclidean")#거리 공식
h1=hclust(d,method="complete")#계층적군집분석 
plot(h1)#정확한 수는 그래프를 보고 직접 고를 것
#-----------------------------------------------------------------
k1=kmeans(iris[,1:4],3)
k1$cluster

table(iris$Species,k1$cluster)
k1$withinss #각각의 군집에 대한 오차값(분산/흩어짐 정도)

k0=data.frame()
for (i in 1:6){
  k2=kmeans(iris[,1:4],i,iter.max = 100)
  k3=cbind(i,k2$tot.withinss)
  k0=rbind(k0,k3)
}
plot(k0,type='b')#b:점(p)과 선(l) 둘다  
k0[which.min(k0[,2]),]#최소값 위치 찾기 --> 행의 번호//기울기가 완만해지기 전 단계 (3)
  
k1=kmeans(iris[,1:4],3,iter.max = 100)
k1$cluster
table(iris$Species,k1$cluster)
k1$withinss
#숫자들 바꿔주기, 2는 3으로 , 3은 2로 
clust1=ifelse(k1$cluster==3,2,ifelse(k1$cluster==2,3,k1$cluster))
table(iris$Species,clust1)


