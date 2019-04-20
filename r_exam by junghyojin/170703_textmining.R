
# read(외부 데이터를 읽어 주는 것)


## environment에 있는 값 지우기 
rm(list=ls())
#readLines :  enter 키를 기준으로 읽는 것, 마지막 줄에 enter키를ㄹ 꼭 쳐줘야 함
txt=readLines('big.txt',encoding = 'UTF-8')  # UTF-8은 한글을 가져오기 위해서(깨지는 걸 방지)


  ### 비정형 데이터 ### 1.텍스트 데이터 2.이미지 데이터(동영상 포함) 
str(txt)
txt[10]
list1 = list(sp=1,sp2=c(1,3,5), y=c("A","B"))
list1

# list1[2]의 의미 : 방 2안에 있는 모든 것( 변수와 값을 다 가져와라)
list1[2]  

# list1$sp2 의미 : 방 2안에 있는 모든 것(값을 다 가져와라)
list1$sp2

# list1[[2]] 의미 : 방 2안에 있는 모든 것(값을 다 가져와라) 위에 것과 같음 , 더 편리!
list1[[2]]

## list안에 list가 있는 구조 
list2 = list(x=list1, y=list1)

## 대괄호의 갯수에 따라 불러오는 값이 다르다
str(list2)

# 모든 변수와 값
list2[[1]]

# 2번째 변수와 값
list2[[1]][2]

# 2번째 값만
list2[[1]][[2]]


### list를 하는 이유 : 텍스트 마이닝에서 각각의 방을 만들기 위해서(다른 타입으로는 받아 올 수 없음)

# 각 속성(단어)별 문자의 갯수파악
nchar(txt)

# 글자수가 1개 넘는 것만 찾기
txt0=txt[nchar(txt)>1]
nchar(txt0)

# 패키지 설치(dependecies =T 는 연관된 것 같이 설치하라는 의미)
install.packages('KoNLP',dependencies = T)
library(KoNLP)

#extractNoun 명사 추출해주는 함수
txt_n=extractNoun(txt0)
txt_n

# txt_n의 구조 보기 (list 형식)
str(txt_n)

# unlist 사용하는 이유 : table(빈도 수 파악) 안에 변수안에 변수를 집어넣을 수 없기 때문에 이를 해제
table(unlist(txt_n))

txt_t=table(unlist(txt_n))
txt_t


install.packages('wordcloud')
library(wordcloud)

wordcloud(names(txt_t),txt_t)

# 사전 등록하기()
useSejongDic()
wordcloud(names(txt_t),txt_t)

### 찾아바꾸기 ex) 빅데이터와 빅데이타는 같은 것이기 때문에 이들을 찾아 같은 것으로 만들어야 함 gsub( 찾는 글자, 바꿀글자, 범위)

# bigdata -> 빅데이터
txt1 = gsub("bigdata" ,"빅데이터",txt0) 

# "[A-Z]" : 대문자 A-Z & 소문자까지 모든 영어 다 찾기 ,그 후 아무값도 아닌 것으로 바꾸기
txt1=gsub("[A-z]","",txt1) 

## Help -> gsub -> Regular Expression

txt1=gsub("[[:digit:]]","",txt1)
txt1=gsub("[[:punct:]]","",txt1)


# 스페이스 제거하기
txt1=gsub("  "," ",txt1)


txt_n=extractNoun(txt1)
txt_t=table(unlist(txt_n))
wordcloud(names(txt_t),txt_t)





