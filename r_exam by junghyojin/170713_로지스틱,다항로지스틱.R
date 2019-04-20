
  ###############  
  #             #  
  #             #
  #   train     #   y = w * f(x)
  #             #
  #             # for loop
  #             #
  ###############
  #             #
  #    test     # 
  #         x_i #  => y_hat
  ###############


  # Z: min (y - y_hat)
    
# 1.로지스틱 회귀 모형

data =iris[1:100,] # 본래 3개 범주여서 2개만 보기위해 100행까지만 추출
levels(data$Species)
table(data$Species) # factor였었기에 아직도 그 형식이 남아있다 , 따라서 재 처리가 필요!


# step1) 데이터 범주 줄이기! (사전 검토시 매우 중요한 과정)
data$Species = factor(data$Species)
levels(data$Species)
table(data$Species) 

# family= binomial, 'binomial' 로 설정해야 로지스틱 회귀로 처리가 된다
# step2)
(m = glm( Species~ ., data = data ,family = 'binomial' ))

# step3) train, test 만들기
set.seed(1000)
ind = sample(1:nrow(data), nrow(data)*0.7, replace = F)

train = data[ind,]
test = data[-ind,]

(m = glm( Species~ ., data = train ,family = 'binomial' ))

m$fitted.values
train_y=ifelse(m$fitted.values>=0.5 , 2, 1) # iris 데이터는 levels가 1,2(단 3은 위에서 제외했음), 따라서 0.5보다 크면 2로 분류, 아닌경우 1로 분류
table(train_y)
table(train$Species, train_y) # 100퍼센트 일치(이로써 만든 모형이 적합함을 알 수 있음, 따라서 test data를 집어넣기 시작하면 됨)

# m모형을 test data를 바탕으로 predict해보기
pred1=predict(m, newdata =test, type = 'response'  ) # type 에서 response : 확률 값, class 인경우(glm에서 안 먹힘, 다른 패키지를 사용해야 함) 계층 값으로 돌려받음(glm은 default값이 response 임


pred2=ifelse(pred1>0.5,2,1)
table(test$Species, pred2)


# 2. 다항로지스틱 회귀 모형--------------

library(nnet)

set.seed(1000)
ind = sample(1:nrow(iris), nrow(iris)*0.7, replace = F)

train = iris[ind,]
test = iris[-ind,]

(m = multinom( Species~ ., data = train ))
m$fitted.values
m_class=max.col(m$fitted.values) # '행'마다 가장 큰 값이 몇번째 열에 있는지 보여줌
table(m_class)
table(train$Species, m_class) # 교차표
pred1=predict(m, newdata =test, type = 'class'  )
table(pred1)
table(test$Species, pred1)

######################################---------------
# 예제) Sonar$Class


library(mlbench)
data(Sonar)
View(Sonar)
str(Sonar)

data=Sonar[1:nrow(data),] # 208행 전체를 data로 불러들여옴
levels(Sonar$Class)
table(Sonar$Class)

set.seed(1000)
ind = sample(1:nrow(data), nrow(data)*0.7, replace = F)

train = data[ind,]
test = data[-ind,]

(m = glm( Class~ ., data = train ,family = 'binomial' ))

m$fitted.values
train_y=ifelse(m$fitted.values>=0.5 , 2, 1) # iris 데이터는 levels가 1,2(단 3은 위에서 제외했음), 따라서 0.5보다 크면 2로 분류, 아닌경우 1로 분류
table(train_y)

pred1=predict(m, newdata =test, type = 'response'  ) 


pred2=ifelse(pred1>0.5,2,1)
k=table(test$Class, pred2)
sum(diag(k))/sum(k)

