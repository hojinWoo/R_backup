# 이전의 변수들 다 지우고 시작
rm(list=ls())

## 필요한 library 불러오기
library(KoNLP)
library(wordcloud)
# string 과 관련된 함수들str_length, str_match 등등 ( Packages -> stringr ) 
library(stringi)
library(stringr)




txt=readLines('big.txt',encoding = 'UTF-8') # 벡터 형태로 가져옴
txt
length(txt) #(col =1, 따라서 열(row)만 알면 된다)


# data 구조에 따른 사용함수가 다르다. data frame(행렬) 일 경우 열, 과 행 모두 알아야 함. 반면 벡터인 경우 col =1 이기에 length 만(열)으로 그 길이를 알수 있음

length(iris) # data frame 구조이다. 여기서 '열'을 가져옴
ncol(iris)
nrow(iris)

  ## 사전(dictonary)작업 ##
#1.신조어 등록
#2. 분야별 전문용어 등록(append: 추가만 하겠다는 의미)
# mergeUserDic(data.frame(c("빅데이터","ncn"))) # error 발생 -> buildDictionary를 사용하라고 나옴(신 버전에서는 안됨)
buildDictionary(user_dic = data.frame(c("빅데이터","ncn")),replace_usr_dic=T) # replace_usr_dic=T 는 추가해서 사전을 재정의, F는 추가만 

  ## 텍스트 핸들링 ##

txt

#1. 대문자를 소문자로 바꾸는 작업
txt0 = str_to_lower(txt) 
txt0

#2. 유사 단어를 한 단어로 통일 
txt1 = gsub("빅데이타","빅데이터",txt0)
txt1 = gsub("bigdata","빅데이터",txt1)
txt1 = gsub("big data","빅데이터",txt1) 

#3. 불필요한 단어들 제거( 특히, 특수문자)

### graph로 할 경우 한글이 사라지는 경우가 발생한다. 따라서 아래와 같이 세 가지를 입력하는게 좋다
#txt1 = gsub("[[:graph:]]","",txt1)
txt1 = gsub("[[:digit:]]","",txt1) # 
txt1 = gsub("[A-z]","",txt1)
txt1 = gsub("[[:punct:]]","",txt1) # 
#txt1 = gsub("[((a(\\d)+)|())|()]","",txt1) # a로 시작하되 숫자가 1번 이상 나오는 것들 cf) \\D(대소문자 구분 중요):숫자가 아닌 것들 제거

#4. 스페이스 제거  ex) gsub("  "," ",txt): txt파일안에 있는 스페이스 2개를 1개로 변환
txt1=gsub("  "," ",txt1)


txt1


# txt에서 문자의 길이가 1이 넘는 것만 찾아라(T,F 값으로만 나옴)
#str_length(txt) > 1
#nchar(txt) > 1

# txt1에 길이가 1이 넘는 것만 저장
txt2 = txt1[str_length(txt) > 1] 
txt2
txt1

# ifelse



txt_e= extractNoun(txt2) # output -> list 형으로 나옴

txt_t=table(unlist(txt_e)) #  table 안에 넣기 위해서는 list 형을 unlist과정이 필요
txt_s=sort(txt_t,decreasing = T) # sort가 오름차순이기에 내림차순을 하고 싶은 decreasing = T 로 씀

# 한 글자짜리 없애고 싶음
txt_s1=txt_s[str_length(names(txt_s))>1]
txt_h=head(txt_s1,5) # 앞에서부터 빈도 수 높은 5개를 보여줌
#txt_h=tail(txt_s1,5) # 뒤에서 빈도 수 낲은  5개

barplot(txt_h)


# 글자색깔 설정
pal = brewer.pal(7,"Set1")

# random.order = T : txt_s에 입력되어있는 순서대로 입력 
wordcloud(names(txt_s1),txt_s1,scale=c(5,0.5), min.freq = 2, random.order = F, rot.per = 0.3 ,col=pal)

# 행과 열의 위치에 '조건' 걸기
# ex) iris[iris$Sepal.Length>=7  ,  1:2  ] # ex) 길이가 7이상인 행 & 1~2열 


install.packages("wordcloud2")





