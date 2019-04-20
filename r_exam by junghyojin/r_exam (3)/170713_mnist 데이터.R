

### mnist data ###
train=read.csv('C:/Users/ajou/Desktop/r_exam/data/short_prac_train.csv')
test=read.csv('C:/Users/ajou/Desktop/r_exam/data/short_prac_test.csv')
str(train)
str(test)
train1 = train
train1$label=factor(train$label)

test1 = test
test1$label=factor(test$label)
str(test1)


r2=randomForest(label ~. ,train1)
pred2=predict(r2, newdata = test1)

t2=table(test1$label,pred2)
sum(diag(t2))/sum(t2)


####### train1 vs train2


train2 = train1
test2 =test1
train2[,-1] = round(train[,-1]/255,0)
test2[,-1] =round(test[,-1]/255,0)

start1=Sys.time()
r3 = randomForest(label~., train2)
interval1 = Sys.time() - start1 # 소요시간
pred3=predict(r3, newdata = test2)
t3=table(test2$label,pred3)
sum(diag(t3))/sum(t3)


### DNA 데이터
data(DNA)
View(DNA)
summary(DNA)
str(DNA)

data =DNA[1:nrow(DNA), ]
data$Class = factor(data$Class)
set.seed(1000)
ind = sample(1:nrow(data), nrow(data)*0.7, replace = F)

train_D = data[ind,]
test_D = data[-ind,]

r3=randomForest(Class ~., train_D)
pred4=predict(r3, newdata = test_D)

t4=table(test_D$Class,pred4)
sum(diag(t4))/sum(t4)








