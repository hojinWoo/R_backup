
#C5.0 algorithm 

credit=read.csv('credit.csv')
str(credit)

ind =order(runif(1000)) # runif(1000)~1사이의 값 발생
train = credit[ind[1:900],]
test = credit[ind[901:1000],]

install.packages('C50')
library(C50)
model1=C5.0(x=train[,-17], y=train[,17])
model1

pred1=predict(model1,test)
table(test$default,pred1)
summary(model1)


model2=C5.0(x=train[,c(1,2,5,6)],y=train$default)
plot(model1)
summary(model2)

pred2=predict(model2,test)
table(test$default,pred2)


library(party)
model3 = ctree(default~., train)
summary(model3)
plot(model3)
cc1 = predict(model3, train)
table(train$default,cc1)
      
cc2 = predict(model3, test)
table(test$default,cc2)      


library(e1071)
model4=naiveBayes(x=train[,-17], y=train[,17])
pred4=predict(model4, newdata = test)
table(test$default,pred4)      

library(randomForest)
model5=randomForest(x=train[,-17], y=train[,17])
pred5=predict(model5,test)
table(test$default,pred5)      

library(mlbench)
data(Vowel)
str(Vowel)
nn=nrow(Vowel)
ind = sample(1:nn, nn*0.7, replace = F)
train = Vowel[ind,]
test =  Vowel[-ind,] 

v1=C5.0(x=train[,-11], y=train[,11])
v2=naiveBayes(x=train[,-11], y=train[,11])
v3=randomForest(Class~., train)

pred1=predict(v1, test)
pred2=predict(v2, test)
pred3=predict(v3, test)

t1=table(test$Class, pred1)
sum(diag(t1))/sum(t1)

t2=table(test$Class, pred2)
sum(diag(t2))/sum(t2) # 다지로 넘어가는 순간 naiveBayes는 똥망

t3=table(test$Class, pred3)
sum(diag(t3))/sum(t3)



correct1=sum(diag(t1))/sum(t1)
co2 =data.frame()
pred = c("pred1", "pred2", "pred3")
for(i in 1:3) {
  t1=table(test$Class, pred[i])
  correct1=sum(diag(t1))/sum(t1)
  co1 = cbind(i, correct1)
  co2 = rbind(co2, co1)
  }

