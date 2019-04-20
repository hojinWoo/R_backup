##### 복습 #####
# 의사결정나무
# 크롤링방법 설명 > html 각각의 구성요소들을 알아야 웹크롤링 가능
# 크롤링하고자 하는 사이트의 특징 알아야돼
# httr / rvest 패키지 이용 > 크롤링

# 랜덤포레스트 기법이 분류 쪽에서는 좋아
# 이미지 자료의 특징을 알아야지만 거기에 맞게끔 변형가능
# 이미지가 한행/열에 들어가도록
# 열단위로 들어가게 할지, 행단위로 들어가게 할지 > 이미지로 다시 복구해서 볼때 필요
# 기본적으로 이미지가 뒤집에서 들어오는 것 기억 (image 함수)


##### 오늘 #####

# 베이즈 정리를 이용해서 만든 '나이즈 베이즈' 분류기법

# 사후확률 / 조건부확률
# A=A1∪A2∪A3, B=B1∪B2∪B3, Ai⊂Bi
# 사전에 P(Bi|A)을 알고있을 때, P(Ai|B)을 알고 싶어 > 베이즈정리
# 전확률공식 > A 영역 중에 B가 차지하는 순수비율 > P(B)=P(A1∩B)+P(A2∩B)+P(A3∩B)
# 로지스틱회귀랑 원리를 보면 비슷해 (선을 기준으로 포함되거나 안되거나)

# Machine Learning with R.pdf - 4장(p.89)
# 사이즈가 작을 때, '나이즈베이즈' 가 스팸 분류 등에 성능이 좋아 
# 이다/아니다 두가지 or 세가지로 나뉠 때 이용한다고 보면돼


# '나이브 베이즈 알고리즘'의 장단점 (p.97)
# 노이즈, 결측치가 있어도 잘 수행 (결측치에 대해 덜 민감) > 이것 때문에 많이 사용


##### 휴대폰 스팸제거 #####
# 핸드폰 클리너? 개념으로 접근해도 돼
# 아이템-핸드폰으로 들어오는 불필요한 문자들 어떻게 분리할건지를 이론으로 만들어도돼
# 특정 단어가 들어갔는지 여부에 따라 스팸이다/아니다 분리할 예정

# 말뭉치(corpus) : 변수로 만들 단어모음 > 이걸 먼저 지정을 해야돼

# 데이터를 받아올때는 먼저 vector형태로 먼저 불러들인다음 corpus로
# 필요한 구조로 바꿔주는 함수가 有
# > DocumentTermMatrix() / TermDocumentMatrix()
# > Document가 행, Term이 열로 / Term이 행, Document가 열로
# tm_map() : gsub() 역할 / 대문자를 소문자로 바꾸는 등의 과정 수행
# tolower 기법은 tm_map()에서 사용하기 불편하게 바꼈어
# > str_to_lower()을 사용해도돼

# "단어가 그 문서에 있냐/없냐가 중요하다면 1/0로 넣겠다"
# 물론 단어가 나온 횟수가 들어가면 강도를 확인할 수 있어서 더 좋긴해

#####

sms_raw=read.csv('mlr-ko/chapter 4/sms_spam.csv',stringsAsFactors=F,header=T,sep=',')
str(sms_raw)

library(stringr)
sms_raw$text=str_to_lower(sms_raw$text)
# 전부 소문자로

sms_raw$type=factor(sms_raw$type)
str(sms_raw)
# 구조확인 > 아직 대문자가 소문자로 안바뀐 것들이 몇개 있어
table(sms_raw$type)
levels(sms_raw$type)
# level이 세개가 나오면, 1072행이 잘못 들어간것
# > 엑셀열어서 1073행의 'ham'을 지웠다가 다시 입력하고 저장 > 위에서 데이터 다시 불러와

#
install.packages('tm')
library(tm)

sms_corpus=Corpus(VectorSource(sms_raw$text))
# 말뭉치를 만들었어
print(sms_corpus)
# 실제문장은 Content 안에 들어가있어
inspect(sms_corpus[1:3])

# corpus_clean=tm_map(sms_corpus,tolower
# > tolower가 없어졌어 (tm 0.6 이후) / 여기선 돌긴돌았지만, 자주 에러나니까 주의
corpus_clean=tm_map(sms_corpus,content_transformer(tolower)) # tm 0.5 이상일 경우 이렇게 하면돼
corpus_clean=tm_map(corpus_clean,removeNumbers)
corpus_clean=tm_map(corpus_clean,removeWords,stopwords()) # stopwords() > 마침표 제거
corpus_clean=tm_map(corpus_clean,removePunctuation) # 특수문자 제거
inspect(sms_corpus[1:10])
inspect(corpus_clean[1:10])

sms_dtm=DocumentTermMatrix(corpus_clean)
# matrix 구조로 바꿔서 보여줘
sms_dtm
# 사이즈가 너무 커서 열리진않아
# 단어의 수가 7931개의 변수가 만들어져 있다는 얘기
sms_dtm$dimnames

sms_raw_train=sms_raw[1:4169,]
sms_raw_test=sms_raw[4170:5559,]
# 원자료의 특징
sms_dtm_train=sms_dtm[1:4169,]
sms_dtm_test=sms_dtm[4170:5559,]
# 학습 알고리즘에 넣기위해
inspect(sms_dtm_train[1:10,1:5])
#
sms_corpus_train=corpus_clean[1:4169]
sms_corpus_test=corpus_clean[4170:5559]
# 워드클라우드 하기위해

prop.table(table(sms_raw_train$type))
prop.table(table(sms_raw_test$type))
# train하고 test가 비율적으로 ham과 spam이 비슷하게 나와

library(wordcloud)

par(mfrow=c(1,2))
wordcloud(sms_corpus_train,min.freq=30,random.order=F)
# min.freq=30으로 되어있어서 많이 안나와
# 한자가 들어가있어 > 실제 한자가 들어가 있는지 확인을 해봐야겠지
wordcloud(sms_corpus_test,min.freq=30,random.order=F)

spam=subset(sms_raw_train,type=='spam')
ham=subset(sms_raw_train,type=='ham')
# raw 데이터보다는 clean 데이터로 해봐

wordcloud(spam$text,max.words=40,scale=c(3,.5))
# spam$text ↓
# wordcloud가 tm 패키지의 도움을 받아 ↓
# tm처럼 matrix로 만들어서 각각의 단어들이 몇번 들어가있는지 나타내게돼
wordcloud(ham$text,max.words=40,scale=c(3,.5))

# 어떤 단어들이 많은지 확인하고 싶어
findFreqTerms(sms_dtm_train,5)
# 5번 이상 나온 단어들

# ind=sms_raw[sms_raw$type=='spam']
ind=which(sms_raw$type=='spam')
train_spam=corpus_clean[(ind<=4169),]
train1_spam=sms_dtm_train[(ind<=4169),] # 전체 중 3254개의 spam이 존재

findFreqTerms(train1_spam,5) # spam인 것들 중에 5개가 넘는것들 (?)

# ↓ 이 데이터로는 아래의 작업은 하지 않을거야
sms_dict=Dictionary(findFreqTerms()) # Dictionary() 함수가 안먹어
sms_train=DocumentTermMatrix(sms_corpus_train,list(dictionary=))
sms_test=DocumentTermMatrix(sms_corpus_test,list(dictionary=))

?DocumentTermMatrix
# termFreq()를 바로 쓸 수 있어 > Dictionary() 함수를 사용하지 않게 되는거야

convert_counts=function(x) {
  x=ifelse(x>0,1,0)
  x=factor(x,levels=c(0,1),labels=c("No","Yes"))
}
# "단어가 있다/없다로만 평가하겠다" (가중치 제거)

sms_train=apply(sms_dtm_train,MARGIN=2,convert_counts)
sms_test=apply(sms_dtm_test,MARGIN=2,convert_counts)
sms_train[1:3,1:3]
sms_test[1:3,1:3]
# 각각 document 이름들 (?)
str(sms_train)
# Yes/No만 들어간 matrix가 있어

install.packages('e1071')
library(e1071)

start_time=Sys.time()
sms_classifier=naiveBayes(sms_train,sms_raw_train$type)
end_time=Sys.time()-start_time
# matrix가 컸던 것 대비 속도가 빨라
sms_classifier
# 결과들이 각각마다 확률로 나오도록 되어있어
sms_classifier$apriori # 각 type에 대한 갯수들

# 학습이 됐으니 test 적용을 해봐
sms_test_pred=predict(sms_classifier,sms_test)
# error 해결 ↓
# 한자, 깨진 한글이 들어가 있어서 오류발생 (빈도수가 5보단 작아)
sms_train1=DocumentTermMatrix(sms_corpus_train,list(dictionary=findFreqTerms(sms_dtm_train,5)))
sms_test1=DocumentTermMatrix(sms_corpus_test,list(dictionary=findFreqTerms(sms_dtm_train,5)))
# 동일한 단어가 들어가야 하기때문에 sms_test1의 dictionary에도 sms_dtm_train이 맞아
# 열의 수가 1217개로 줄어
sms_train1=apply(sms_train1,MARGIN=2,convert_counts)
sms_test1=apply(sms_test1,MARGIN=2,convert_counts)
sms_classifier1=naiveBayes(sms_train1,sms_raw_train$type)
sms_test_pred1=predict(sms_classifier1,sms_test1)

install.packages('gmodels')
library(gmodels)
CrossTable(sms_test_pred1, sms_raw_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

##### iris 데이터 이용

na1=naiveBayes(Species~.,iris)
pred1=predict(na1,newdata=iris)

table(iris$Species,pred1)

##### 랜덤포레스트

library(randomForest)

sms_train1[1,1]
str(sms_train1)
as.integer(sms_train1[1,1])
# chr형 > integer로 바꾸면 NA가 되버려
as.integer(as.factor(sms_train1[1,1]))
# factor가 되야 0/1이 돼

# 위에서 했던
convert_counts=function(x) {
  x=ifelse(x>0,1,0)
  x=factor(x,levels=c(0,1),labels=c("No","Yes"))
}
# 과정 때문에 그 뒤의 것들이 안됐었어
convert_counts=function(x) {
  x=ifelse(x>0,1,0)
}
# 그냥 그대로 1,0가 들어가도록 해서 다시 하면, 전부 될거야

sms_train=apply(sms_dtm_train,MARGIN=2,convert_counts)
sms_test=apply(sms_dtm_test,MARGIN=2,convert_counts)
sms_train[1:3,1:3]
sms_test[1:3,1:3]
# 각각 document 이름들 (?)
str(sms_train)
# Yes/No만 들어간 matrix가 있어

install.packages('e1071')
library(e1071)

start_time=Sys.time()
sms_classifier=naiveBayes(sms_train,sms_raw_train$type)
end_time=Sys.time()-start_time
# matrix가 컸던 것 대비 속도가 빨라
sms_classifier
# 결과들이 각각마다 확률로 나오도록 되어있어
sms_classifier$apriori # 각 type에 대한 갯수들

# 학습이 됐으니 test 적용을 해봐
sms_test_pred=predict(sms_classifier,sms_test)

CrossTable(sms_test_pred1, sms_raw_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

# 다시
rand1=randomForest(sms_train,sms_raw_train$type)














































