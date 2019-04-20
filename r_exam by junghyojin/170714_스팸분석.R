
# cf) 베이즈 정리 : 사전의 알고 있는 확률을 통해, 사후 확률을 도출해내는 방식

  ### 나이브 베이즈(Bayes Theorem)를 사용한 분류(사건이 적을때 유용, 결측값이 있어도 가능하다) ###
  
    # 사용 예 : 스팸 분류, 저자 식별 분류, 컴퓨터 네트워크에서 이상 행동, 관찰된 증상을 고려한 질병 진찰 
    # 셋 중에 하나, or 있다 없다 와 같은 경우 유용
    # 있냐, 없냐 즉, '1','0' 으로 표현하여 빈도수를 구함. 

  ## 예제) 나이브 베이즈를 이용한 휴대폰 스팸 제거
    #     "특정 단어"가 포함되어 있는지 를 기준으로 스팸 or 햄으로 분류
    # cf) Corpus(말뭉치) - R에서는 Corpus로 불러올 때, Vector 형태로 변환해서 받아와야한다.

# 1단계 : 불용어(대소문자 잘못기입, 오타 등) 제거 by remove ~ 함수를 통해서 --------------------------------------------------------

# 2단계 : "행렬" 방식으로 데이터 불러오기 DocumentTermMatix() - '행' 기준으로 ----------------------------- 

# ------------------------------------------------------------------------------------------------------------


# 데이터 불러오기
sms_raw=read.csv('sms_spam.csv', stringsAsFactors = F)
View(sms_raw)

# sms 데이터 구조
str(sms_raw)

# sms text열에 해당하는 모든 값들을 소문자로 변경하기
library(stringr)
sms_raw$text=str_to_lower(sms_raw$text) #

# Type 변경(factor)로
sms_raw$type <- factor(sms_raw$type)
table(sms_raw$type)
nlevels(sms_raw$type)

# 변수형 확인
str(sms_raw$type)
table(sms_raw$type)

# 텍스트 마이닝(tm) 패키지를 사용하여 말뭉치 생성
install.packages('tm')
library(tm)
sms_corpus <- Corpus(VectorSource(sms_raw$text)) # cf) Corpus(말뭉치) - R에서는 Corpus로 불러올 때, Vector 형태로 변환해서 받아와야한다.

# sms 말뭉치 확인
print(sms_corpus)
inspect(sms_corpus[1:3]) # 말뭉치를 확인하기 위해서 쓰는 함수

# tm_map() 사용하여 말뭉치 정리
corpus_clean <- tm_map(sms_corpus, tolower) # tolower 함수가 버전에 따라 작동하는게 있고 안 하는게 있다, 따라서 위에서 미리 변경하고 온 것!
corpus_clean <- tm_map(corpus_clean, removeNumbers) # removeNumbers: 숫자 제거 함수 
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords()) # removeWords, stopwords() : 문장의 마침표 제거
corpus_clean <- tm_map(corpus_clean, removePunctuation) # 특수문자 제거
corpus_clean <- tm_map(corpus_clean, stripWhitespace) # 스페이스(띄어쓰기) 여러개 들어간거 지우기(한 개는 제외)
  #corpus는 단위가 문장 전체, corpus는 문장들을 쫘~악 다 모아놓는 작업. 그 후 DocumentTermMatrix를 통해 단어 단위로 자름


# 말뭉치 정리 확인
inspect(sms_corpus[1:3])
inspect(corpus_clean[1:3])

# 문서-용어 희소 매트릭스 생성
sms_dtm <- DocumentTermMatrix(corpus_clean) # 문장이었던 것을 단어로 잘라 줌. 그 후'행' 기준으로 매트릭스 구조로 생성 
sms_dtm # 너무 커서 여기서 보여줄 수는 없지만, 내부적으로 생성은 된다
str(sms_dtm)
# 훈련과 테스트 데이터셋 생성

#case1. 가공하지 않은원자료 분석
sms_raw_train <- sms_raw[1:4169, ]
sms_raw_test  <- sms_raw[4170:5559, ]

#case2. 학습 알고리즘에 넣기 위해서(나이브 베이즈에)
sms_dtm_train <- sms_dtm[1:4169, ]
sms_dtm_test  <- sms_dtm[4170:5559, ]

#case3. 워드크라우드를 통한 시각화를 위해서
sms_corpus_train <- corpus_clean[1:4169]
sms_corpus_test  <- corpus_clean[4170:5559]

prop.table(table(sms_raw_train$type))
prop.table(table(sms_raw_test$type))

# 단어 클라우드 시각화
library(wordcloud)
# ?wordcloud : 단어, 빈도수, ... 순서로 들어가야 하는데 corpus 자체가 단어, 빈도수 순으로 되어있는 구조라 한 방에 오케이!
wordcloud(sms_corpus_train, min.freq = 30, random.order = FALSE) #  min.freq = 30(빈도수가 30 이상인것만) 이기에 적게 나옴


# 훈련 데이터를 스팸과 햄으로 구분
spam <- subset(sms_raw_train, type == "spam")
ham  <- subset(sms_raw_train, type == "ham")

wordcloud(spam$text, max.words = 40, scale = c(3, 0.5)) #wordcloud는 tm패키지의 도움을 받아서 자동적으로 매트릭스를 생성하여 자동적으로 단어의 빈도수를 구한다. 
wordcloud(ham$text, max.words = 40, scale = c(3, 0.5))

# sms_raw_train 데이터에서 spam에 해당하는 행을 train_spam으로 설정하기
ind=which(sms_raw$type =='spam')
ind <= 4169
train_spam = sms_dtm_train[(ind <= 4169),]
train1_spam=sms_dtm_train[(ind <=4169),]



# 빈번한 단어에 대한 속성 지시자
findFreqTerms(sms_dtm_train, 5) # 빈도수 5개 이상인것 찾기
findFreqTerms(train1_spam, 5)  # 스팸인 것 중에 빈도수가 5개 이상인것 찾기

# 안해 에러떠서~
#sms_dict <- Dictionary(findFreqTerms(sms_dtm_train, 5)) # Dictionary 함수가 사라짐~ , 대신 DocumentTermMatrix함수에서 control을 사용하여 설정하고 싶은 것을 통해 값을 추출할수 있음(Help 창에서 활용하기)
sms_train1 =DocumentTermMatrix(sms_corpus_train, list(dictionary = findFreqTerms(sms_dtm_train, 5)))
sms_test1 =DocumentTermMatrix(sms_corpus_test, list(dictionary = findFreqTerms(sms_dtm_train, 5)))

## 개수를 팩터로 변환
  # 미리 함수 만들어놓기
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
 # x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}

# apply() convert_counts()를 사용한 훈련/테스트 데이터 추출
sms_train1 <- apply(sms_dtm_train, MARGIN = 2, convert_counts) #Margin :1이 행, 2가 열 방향으로 합친다는 의미 
sms_test1  <- apply(sms_dtm_test, MARGIN = 2, convert_counts)
str(sms_dtm_train)


## 3 단계 : 데이터로 모델 훈련 ----
library(e1071)
start_time=Sys.time()
sms_classifier <- naiveBayes(sms_train1, sms_raw_train$type)
end_time = Sys.time()-start_time
sms_classifier


as.integer(as.factor(sms_train1[1,1]))
library(randomForest)
rand1=randomForest(sms_train1, sms_raw_train$type )












## 4 단계 : 모델 성능 평가 ----
sms_test_pred <- predict(sms_classifier, sms_test)

library(gmodels)
CrossTable(sms_test_pred, sms_raw_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

## 5 단계 : 모델 성능 향상 ----
sms_classifier2 <- naiveBayes(sms_train, sms_raw_train$type, laplace = 1)
sms_test_pred2 <- predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_raw_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))












