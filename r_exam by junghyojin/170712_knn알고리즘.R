 

### kNN 최근접 이웃 - by 민코브스키 거리식을 이용하여 (|x_i - x_j|)###
# 이미 알고 있는 군집 분포(clustering)에서 새로운 데이터가 들어왔을 때, 이와 가장 가까운 거리의 군집으로 데이터를 분류

wbcd=read.csv('Machine Learning with R code/mlr-ko/chapter 3/wisc_bc_data.csv', header = T ,stringsAsFactors = F, sep = ',') # sep = seperate(구분되어있다)
View(wbcd)
str(wbcd)


 # 데이터 편집

wbcd = wbcd[,-1]
wbcd$diagnosis = factor(wbcd$diagnosis) # diagnosis의 변수를 factor로 바꾸기
levels(wbcd$diagnosis)
nlevels(wbcd$diagnosis)

# 데이터 표준화( 데이터 단위 맞추기) => scale 함수를 사용하여 

wbcd_n = wbcd
wbcd_n[,-1] =scale(wbcd_n[,-1]) # 1번째 열을 빼고 구하기(factor 형이기 때문에) # scale 각 열에서 열 내부적으로 표준정규화를 시킴
View(wbcd_n)

nn = nrow(wbcd_n) 
train = wbcd_n[1:(nn*0.7),]
test = wbcd_n[((nn*0.7)+1):nn,] #test = wbcd_n[-(1:(nn*0.7)),] #


  ### kNN 알고리즘은 library(class) 안에 있다,  kNN은 '거리'를 찾아서 

install.packages('class')
library(class)
# knn(train, test, cl, k = 1, l = 0, prob = FALSE, use.all = TRUE) # train = y(여기서는 M,B 값 )값을 알고 있는 것(단, 여기서 y값이 들어가면 안된다) test = y값을 모르는 것 / cl에 train의 y값 
pred1=knn(train[,-1], test[,-1], cl=train[,1], k=3) # k= 근방에 있는 개수 찾기
t2 = table(test[,1], pred1)
cor1 = sum(diag(t1))/sum(t1) # kNN의 정확도 보기 /          cf) diag = 대각선


## 최적의 k값 찾기 

out1 = data.frame()
for(i in 1:15) {
  pred1=knn(train[,-1], test[,-1], cl=train[,1], k=i) 
  t1 = table(test[,1], pred1)
  cor1 = sum(diag(t1))/sum(t1)
  out2 = cbind(i, cor1)  
  out1 = rbind(out1, out2) 
  }
  out1  
  
out3 = which.max(out1[,2]) # 최적의 k값 찾기
out1[out3,]


  ### 거리 구하기
  for(i in 1:10 ) {
    c1=1-i
    c=c(c,c1)
  }
# 거리구해주는 함수: dist
