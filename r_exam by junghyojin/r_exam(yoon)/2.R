#이미 다운로드 받아서 끌어다가 쓰기만 하면 됨
setwd('C:/r_exam') #경로지정
rm(list=ls()) #environment 부분 지워줌

library(KoNLP)
library(wordcloud)
library(stringr)
library(stringi)

txt = readLines('big.txt', encoding = 'UTF-8')
length(txt)
length(iris) #iris 데이터에서 열 수
ncol(iris) #iris 데이터에서 열 수
nrow(iris) #iris 데이터에서 행 수(몇 줄인지)

##사전작업 : 신조어등록, 분야별 전문용어 등록
#mergeUserDic(data.frame(c("빅데이터" , "ncn"))) 이거는 오류나서 buildUserDic사용
buildDictionary(user_dic = data.frame(c("빅데이터" , "ncn")),  replace_usr_dic = T) #한번하면 주석처리
                                                               #T는 원래 사전에 추가해서 재배열, F는 넣기만

##텍스트 핸들링
gsub
grep
length

#영어 대소문자를 소문자로 통일
txt0 = str_to_lower(txt)
  

#유사단어를 한 단어로 통일(예를들어 사투리)
txt1 = gsub("빅데이타", "빅데이터", txt0)
txt1 = gsub("bigdata", "빅데이터", txt1)
txt1 = gsub("big data", "빅데이터", txt1)


#불필요한 단어들 제거(특수문자 등) 관련된 부분 regular expression
txt1 = gsub("[[:alnum:]]", "", txt1)

txt1 = gsub("[[:digit:]]", "", txt1)
txt1 = gsub("[A-z]", "", txt1)
txt1 = gsub("[[:punct:]]", "", txt1)

#txt1 = gsub("[[:graph:]]", "", txt1) #한글이 사라질 수 있음 -> alnum과 punct 두개를 한번에 뽑음.
txt1 = gsub("[(a(\\d)+)]") #a로 시작하면서 숫자가 연속으로 나오는것. 숫자가 하나는 나와야함 \\d disit의 짧은 표현
#이 기호는 | -> or gsub("[(a(\\d)+)] | 계속해서 or넣어서 만들 수 있음

#스페이스 제거
txt1 = gsub("  ", " ", txt1)

#두개 같은 함수 단어의 개수를 찾아줌
txt2 = txt1[str_length(txt1) > 1] #결과값이 t,f로 나옴
nchar(txt) > 1
 
꽃받침 길이가 6이상인것을 찾고싶을때
iris[iris$Sepal.Length >= 6 , 1:2] 

txt_e = extractNoun(txt2) #명사추출결과는 list 형태로 나옴
txt_t = table(unlist(txt_e)) #리스트를 해지하고 하나의 변수로 보아야함 결과는 각 단어에 대한 빈도수가 나옴
txt_s = sort(txt_t, decreasing = T) #T는 내림차순 F는 오름차순
txt_s1 = txt_s[str_length(names(txt_s))>1] #1글자는 제외하고 싶음

txt_h = head(txt_s1, 5) #가장 빈도가 많은 5개 뽑아냄

barplot(txt_h)#막대그래프 그림

#색상 팔레트 불러오기 colorBrewer palettes -> colors 들어가면 볼 수 있음
pal = brewer.pal(7, "Set1") #색이름 ""안에 넣기

plot() #패키지를 통해서 색을 입힐 수 있음
wordcloud(names(txt_s1), txt_s1, scale = c(5,0.5), col= pal,  min.preq = 2, random.order = F, rot.per = 0.2) 
#scale은 글자크기 min.preq는 최소빈도가 2이상 random.order 글자 순서대로 rot.per 글자회전 scale 최대글자 최소글자
#t는 랜덤 f는 순서대로 빈도수가 큰거부터해서 가운데로해서 시작해서 넣어줌 

ifelse 는 for가 포함되어 있음






