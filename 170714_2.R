##### 월요일 > 신경망 기본원리 / R로 하는 딥러닝기법들


##### 결정 트리를 사용한 위험 은행 대출 확인

# 신용만을 믿을 수 없기 때문에 은행은 대출 체계를 계속적으로 축소중
# 좀 더 정확하게 위험 대출을 확인하기 위해 기계 학습을 활용
# 위험고객을 더 정확하게 파악해내서, 등급별로 대출금액에 차등을 줘

# 결정트리를 금융 업계에서 많이 써 / 제조업체들도 (룰 베이스이기 때문에)

#####
# 독일의 신용 회사에서 데이터를 제공 > 데이터의 단위를 확인해야돼 (유로>원)
# factor 변수들이 많아 > 어떤걸 y로, 어떤걸 x로 쓸지 파악
# checking_balance / saving_balance 속성 - 지원자의 체킹과 세이빙 계좌
# str > DM 단위
# 자산이 큰 체킹과 세이빙 계좌는 채무 불이행 대출이 낮다고 안전한 가정 가능
# 과거의 자료로 했기 때문에, 대출금을 반납을 했다/안했다 y값(결과값)이 있어
# 반납 - no 가 낮추기 위해 예측을 하겠다는거에요
# 결과 봤을때 분류해내는게 동일하다면, 변수의 수가 적은게 더 나아

credit=read.csv('mlr-ko/chapter 5/credit.csv',header=T)
View(credit)
str(credit)

credit=credit[order(runif(1000)),]
# 이미 섞여있는 데이터라 그냥 바로 9:1로 나눠도돼
train=credit[1:900,]
test=credit[901:1000,]

# 1번
install.packages('C50')
library(C50)
# C5.0 알고리즘
# C5.0 / plot.C5.0 / summary.C5.0 / ...

model1=C5.0(x=train[,-17],y=train[,17])
summary(model1)
# Decision tree > 괄호 안에 들어가는 순서가 어떻게 돼있는지 봐
# Attribute usage > 변수들의 상대적인 중요도 (%)
model2=C5.0(x=train[,c(1,2,5,6)],y=train$default)
# train[,c(1,2,5,6)] > checking_balance,months_loan_duration,amount,savings_balance > 너무 길어서 위처럼
summary(model2)
# Decision Tree의 에러율이 더 올라가 (변수를 4개만 써서 그래)
plot(model1)
# error

##
library(party)

model3=ctree(default~.,train)
model3
plot(model3)
cc1=predict(model3,newdata=train)
table(train$default,cc1)
# 거의 일치 > 1000개중 227개 오분류 > 오분류율 20% 정도
cc2=predict(model3,newdata=test)
table(test$default,cc2)
# 오분류율이 꽤 높아 > 100개중 28개 오분류 > 오분류율 30% 정도

# 2번
library(e1071)

model4=naiveBayes(x=train[,-17],y=train[,17])
pred4=predict(model4,newdata=test)
table(test$default,pred4)
# 100개 중 29개 오분류
# 기법별 결과들이 비슷 (크기가 작아서)
# train으로 하면 ctree가 더 좋은결과일거야

# 3번
library(randomForest)

model5=randomForest(x=train[,-17],y=train[,17])
pred5=predict(model5,newdata=test)
table(test$default,pred5)
# 100개 중 22개 오분류

model6=randomForest(x=train[,c(1,2,5,6)],y=train[,17])
pred6=predict(model6,newdata=test)
table(test$default,pred6)
# 100개 중 30개 오분류

# 일반적으로 이진일 경우는 기법별로 성능이 유사 / 다지로 넘어가면 차이나
# mnist 들어가는 순간 차이를 보이게 돼 (?) (어제 한 1/0들어간 자료)
# 다지로 넘어가면 randomForest가 성능이 좋아

library(mlbench)
data(Vowel)
ind=sample(nrow(Vowel),nrow(Vowel)*.7,replace=F)
train=Vowel[ind,]
test=Vowel[-ind,]

# 1번

v1=C5.0(x=train[,-11],y=train[,11])
pred1=predict(v1,test)
tb1=table(test$Class,pred1)
sum(diag(tb1))/sum(tb1)

# 2번

v2=randomForest(Class~.,train)
pred2=predict(v2,test)
tb2=table(test$Class,pred2)
sum(diag(tb2))/sum(tb2)

# 3번

v3=naiveBayes(x=train[,-11],y=train[,11])
pred3=predict(v3,test)
tb3=table(test$Class,pred3)
sum(diag(tb3))/sum(tb3)

# 위의 1~3번을 비교하려면 for roof를 이용해서 자동적으로 table을 그리고, 정확도율까지 구하게해서 비교
df=data.frame(pred1,pred2,pred3)
co2=data.frame()
for(i in 1:3) {
  t1=table(test$Class,df[[i]])
  correct1=sum(diag(t1))/sum(t1)
  co1=cbind(i,correct1)
  co2=rbind(co2,co1)
}
co2[,1]=ifelse(co2[,1]==1,"C5.0",ifelse(co2[,1]==2,"randomForest",ifelse(co2[,1]==3,"naiveBayes","")))
co2
# 다지로 넘어가는 순간 '나이브베이즈'는 정확도율이 훅 떨어져버려 / '랜덤포레스트'가 성능이 훨씬 좋아
# '랜덤포레스트'가 시간은 걸리지만...

# mnist를 돌리면 '랜덤포레스트'는 돌아가고, 다른것들은 돌아가긴 돌아갈텐데 다운되는 경우 발생 (?)

# 나중에 '랜덤포레스트'와 'cnn'을 비교해서 돌려볼 예정 (월요일)

# 머신러닝이 가장 많이 활용되는 분야가 분류쪽

# 주식/경제/물가예측 쪽으로도 많이 활용하려해