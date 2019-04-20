

  ### 나무모형(Tree Models), 의사결정 나무 ### ( 이진트리, y에 해당하는 갯수가 적을때 유용)

# 불순도를 기준으로 나무를 그림
# 불순도 : 분류한 대상이 여러 값을 가지고 있는 정도를 의미

#ex1)
View(iris)
data =iris
set.seed(1000)
ind = sample(1:nrow(data), nrow(data)*0.7, replace = F)

train = data[ind,]
test = data[-ind,]


install.packages('party')
library(party)
c1= ctree(Species~. ,train) # 
c2= ctree(Species~. ,train, controls= ctree_control(maxdepth = 2))
c1
plot(c1) # p-value : 분리해야하는 것인지 아닌지를 구

## plot의 해석
# node의 p = p-value 를 의미함. 
# node2의 불순도는 아주 좋다. node6은 불순도 안 좋음(다른 것에 비해), 그룹으로 묶는 정도가 n=10으로 설정되어있다. 즉 10개 넘어야 그룹으로 묶는 다는 것!
#n=11 데이터 11개 중에 versicolor, virgin의 비율이 저 정도 된다는 의미 & 오류가 존재할 수 있음 (두 가지가 섞여 있기에 즉, 오분류)

plot(c2) # maxdepth = 나무의 깊이 제한

pred2=predict(c1,newdata = test) 
sum(pred2 ==test$Species)/nrow(test) #table 을 만들지 않고 정확도 구하기(table과 다른 방법도 있다~ 는 의미) 

table(test$Species, pred2) #오류가 나는 거 찾기

# ex2)
library(mlbench)
data(Vowel)

nn=nrow(Vowel)
set.seed(100)
ind2= sample(1:nn, nn*0.7, replace = F)
train1 = Vowel[ind2,-1]
test1 =Vowel[-ind2,-1]

str(Vowel)
c3=ctree(Class~., train1)
pred3=predict(c3, newdata = test1)
table(test1$Class, pred3)
sum(test1$Class==pred3)/nrow(test1) # 적중률이 떨어지는 것을 볼수 있다.

plot(c3)


# 정지규칙 

library(MASS)
install.packages("tree")
library(tree)
data(iris)

ir.tr=tree(Species~., train)
summary(ir.tr) #오분류된것도 알려줌
ir.tr # node를 만드는 룰 & *를 통해 끝단 노드를 표시해줌
plot(ir.tr)
text(ir.tr, all = T) # tree에 값 입력


 # 가지치기
ir.tr1=snip.tree(ir.tr, nodes=c(12,7))
plot(ir.tr1)
text(ir.tr1, all = T) # tree에 값 입력

 ### Random Forest ###
# 앙상블 모델 중 하나,  의사결정나무보다 성능이 훨씬 뛰어나다(여러개의 y값이 있어도 ㅇㅋ)

install.packages('randomForest')
library(randomForest)
r1=randomForest(Class~., train1)
r1$predicted
t1=table(train1$Class, r1$predicted)
sum(diag(t1))/ sum(t1)


pred4=predict(r1, newdata = test1)
t2=table(test1$Class, pred4)
sum(diag(t2))/sum(t2)


