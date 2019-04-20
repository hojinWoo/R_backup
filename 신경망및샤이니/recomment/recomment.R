###################################
# recommenderlab 
###################################

# 추천시스템 패키지를 인스톨한다.
install.packages("recommenderlab")  # <-- recommenderlab이 이미 설치되어 있다면 실행할 필요가 없음

# 패키지를 로딩
library(recommenderlab)

setwd("c:/r_test/recomment")

# 데이터 로딩
data <-read.csv("sample.csv",head=FALSE,sep=",")
#->4,945명의 사용자에 대한 구매데이터

# 데이터형을 realRatingMatrix로 변환
r <- as(data, "realRatingMatrix")

# 머신러닝을 위해 학습데이터선정
# 전체데이터의 90%를 학습데이터로 선정
traningData<- sample(nrow(r),4500)
trainingSet<-r[traningData]

# 행의 총합 5개 이상의 아이템만 선택, 많이 팔리지 않은 아이템을 제외시킴
# rowCounts() : number of ratings per row.

trainingSet<-trainingSet[rowCounts(trainingSet)>5]
t1 <- as(trainingSet,"matrix")

#모델생성
model <- Recommender(trainingSet,method="UBCF",parameter ="Cosine")

#추천을 받을 사용자리스트
recommenderUserList<-r[-traningData]

#추천실시
recommendList<-predict(model,recommenderUserList,n=5)

#추천받은 리스트 보기
as(recommendList,"list")


r1 <-r[rowCounts(r)>5]

scheme <- evaluationScheme(r1,method="split", train=.8,given=6,goodRating=4,k=5)
scheme
# train 은 모델만드는 데이터 비율로서 아래 코드는 이를 80%로, 나머지 20%를 평가셋으로 한 것을 의미
# given 은 사람당 평가하는 아이템 수 
# K는 시뮬레이션 반복횟수

# 추천 알고리즘 지정
algorithms <- list(
  "user-based CF_Cosine" = list(name="UBCF", param=list(method="Cosine")),
  "user-based CF_Pearson" = list(name="UBCF", param=list(method="Pearson"))
)

# 실행 및 결과 표시
results<- evaluate(scheme, algorithms, n=c(1,3,5))
results
avg(results)
plot(results, annotate=TRUE, legend="topleft")
plot(results, "prec/rec", annotate=TRUE, legend="bottomright")

# CF의 User-based 알고리즘을 이용하여 Cosine 유사도를 쓴다.
# nn 은 추천을 구하는 이웃의 숫자
algorithms <- list(
  "user-based CF_c20" = list(name="UBCF", param=list(method="Cosine", nn=10)),
  "user-based CF_c20" = list(name="UBCF", param=list(method="Cosine", nn=20)),
  "user-based CF_c30" = list(name="UBCF", param=list(method="Cosine", nn=30)),
  "user-based CF_c40" = list(name="UBCF", param=list(method="Cosine", nn=40)),
  "user-based CF_c50" = list(name="UBCF", param=list(method="Cosine", nn=50)),
  "user-based CF_c60" = list(name="UBCF", param=list(method="Cosine", nn=60)),
  "user-based CF_c70" = list(name="UBCF", param=list(method="Cosine", nn=70)),
  "user-based CF_c70" = list(name="UBCF", param=list(method="Cosine", nn=80))
)

# 사용자당 생산할 추천아이템 갯수
results<- evaluate(scheme, algorithms, n=c(1,3,5))
results

# 그래프를 그려준다
windows();plot(results, annotate=TRUE, legend="topleft")
#TPR:추천시스템이 추천한 아이템 중 사용자가 실제 선택한 아이템의 비율
#FPR:추천시스템이 추천했는데 사용자가 선택하지 않은 아이템의 비율
windows();plot(results, "prec/rec", annotate=FALSE, legend="bottomright")
avg(results)

# recall과 precision을 추출하고 F값을 계산
recall_c20<-(avg(results)$`user-based CF_c20`)[,"recall"]
precision_c20<-(avg(results)$`user-based CF_c20`)[,"precision"]
F_c20=2*(precision_c20*recall_c20)/(precision_c20+recall_c20)
mean(F_c20)

recall_c30<-(avg(results)$`user-based CF_c30`)[,"recall"]
precision_c30<-(avg(results)$`user-based CF_c30`)[,"precision"]
F_c30=2*(precision_c30*recall_c30)/(precision_c30+recall_c30)
mean(F_c30)

recall_c40<-(avg(results)$`user-based CF_c40`)[,"recall"]
precision_c40<-(avg(results)$`user-based CF_c40`)[,"precision"]
F_c40=2*(precision_c40*recall_c40)/(precision_c40+recall_c40)
mean(F_c40)

recall_c50<-(avg(results)$`user-based CF_c50`)[,"recall"]
precision_c50<-(avg(results)$`user-based CF_c50`)[,"precision"]
F_c50=2*(precision_c50*recall_c50)/(precision_c50+recall_c50)
mean(F_c50)

recall_c60<-(avg(results)$`user-based CF_c60`)[,"recall"]
precision_c60<-(avg(results)$`user-based CF_c60`)[,"precision"]
F_c60=2*(precision_c60*recall_c60)/(precision_c60+recall_c60)
mean(F_c60)

recall_c70<-(avg(results)$`user-based CF_c70`)[,"recall"]
precision_c70<-(avg(results)$`user-based CF_c70`)[,"precision"]
F_c70=2*(precision_c70*recall_c70)/(precision_c70+recall_c70)
mean(F_c70)

# column 병합
a<-cbind(
  cbind(recall_c20,precision_c20,F_c20),
  cbind(recall_c30,precision_c30,F_c30),
  cbind(recall_c40,precision_c40,F_c40),
  cbind(recall_c50,precision_c50,F_c50),
  cbind(recall_c60,precision_c60,F_c60),
  cbind(recall_c70,precision_c70,F_c70))

# 화면에 Precision 과 recall을 출력
print(a)

# 화면에 F 값을 출력
windows();plot(seq(20,70,by=10),apply(rbind(F_c20,F_c30,F_c40,F_c50,F_c60,F_c70),1,mean),type='l',xlab="nn",ylab="Average F",lwd=2)



###############################################################################
#ltem_based_CF
rm(list =ls())
# 추천시스템 패키지를 인스톨한다.
install.packages("recommenderlab") # <-- recommenderlab이 이미 설치되어 있다면 실행할 필요가 없음

# 패키지를 로딩
library(recommenderlab)

# 데이터 로딩
data <-read.csv("C:/Users/Administrator/Desktop/RF/sample.csv",head=FALSE,sep=",")

# 데이터형을 realRatingMatrix로 변환
r <- as(data, "realRatingMatrix")

# Jaccard 지표사용을 위해 이산화함
r_b <- binarize(r, minRating=1)

# 행의 총합 5개 이상의 아이템만 선택, 많이 팔리지 않은 아이템을 제외시킴
r_b<-r_b[rowCounts(r_b)>5] 

# 추천의 평가방식을 저장, 
# split은 분할, crosss는 교차검정 
# train 은 모델만드는 데이터 비율로서 아래 코드는 이를 80%로, 나머지 20%를 평가셋으로 한 것을 의미
# given 은 사람당 평가하는 아이템 수 
# K는 시뮬레이션 반복횟수
scheme <- evaluationScheme(r_b,method="split", train=.8,given=6,k=3)
scheme

# 알고리즘 지정: Item-based방식으로 하고 Jaccard 유사도 측정방식 사용 
algorithms <- list(
  "item -based CF" = list(name="IBCF", param=list(method="Jaccard"))
)

# 실행 및 결과 표시
results<- evaluate(scheme, algorithms, n=c(1,3,5))
results
avg(results)
#recall이 user_based_CF보다 낮아서 추천성능이 떨어짐

windows();plot(results, annotate=TRUE, legend="topleft")
windows();plot(results, "prec/rec", annotate=TRUE, legend="bottomright")

#User_based CF가 Item-based CF보다 더 정확함
