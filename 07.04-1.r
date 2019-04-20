#복습-----------------------------------------------------------------
setwd('C:/r_exam')#내가 원하는 곳을 working directory로 변경한 방법
rm(list=ls())# 우측 환경에 있는 것들 다 지우는 것
# 앞에서 필요한 library 호출 (미리 설치 되어 있는 경우 불러오기만)
library(KoNLP)
library(wordcloud)
library(stringi)
library(stringr)


txt=readLines('big2.txt',encoding = 'UTF-8')
length(txt) #데이터 길이 확인
length(iris)
ncol(iris) #열 개수 확인
nrow(iris)

##사전작업 (신조어 등록, 분야별 전문 용어 등록)---------------------------
#mergeUserDic library는 단독으로 사용 불가 buidDictinary library와 같이 사용
#구버전 mergeUserDic(data.frame(c("빅데이터","ncn"))) #한번 만들고 나면 주석처리
#append가 default가 true -> 따로 추가 안하면 기본이 추가임


buildDictionary(user_dic=data.frame(c("빅데이터","ncn")),replace_usr_dic=T)
#ext_dic : 외부 사전/ user_dic-> 사용자 사전
#replace_usr_dic T:사ㅈ
#새로 등록할 사전은 기존 사전 정보와 구조가 같아야 한ㄷ
##text handling-----------------------------------------

#gsub() #글자 바꿔주기
#grep() 
#str() #string length 

#text mining  handling 순서!!!-----------------
txt0=str_to_lower(txt) #대문자를 모두 소문자로 변경
txt1=gsub("빅데이타","빅데이터",txt0)#유사단어 한 단어로 통일
txt1=gsub("bitdata","빅데이터",txt1)
txt1=gsub("bit data","빅데이터",txt1)
#regular expression
txt1=gsub("[[:alnum:]]","",txt1)#불필요한 단어들 제거(특수문자 등) --영어, 숫자 제거
#txt1=gsub("[[:graph:]]"),"",txt1)이 방법을 사용하는 것보다 alnum과 punct를 따로 하는 것이 좋다
#txt1=gtus("[[:digit:]]","",txt1)
txt1=gsub("[A-z]","",txt1)
txt1=gsub("[[:punct:]]","",txt1) #한글의 경우 이렇게 따로 지우는 것이 저 좋음

#txt1=gsub("[(a(\\d)+)]"),"",txt1)#a로 시작하고 여러 숫자가 들어가는(a만 지우는 경우는 안됨)
#txt1=gsub("[(a(\\d)+)]|()"),"",txt1) #앞에서 괄호를 어떻게 묶느냐에 따라 계속 선택 가
txt1=gsub("  "," ",txt1)#가장 마지막으로 space 제거!

#단어 수가 0이 안되도록 str_length(txt)>1 or nchar(txt)>1 사용(return값은 T/F)
txt2=txt1[str_length(txt1)>1]
#iris[iris$Sepal.Length>=7,1:2] 뽑아내는 과

txt_e=extractNoun(txt2) #명사 추출하는데 output이 list로 만들어짐
txt_t=table(unlist(txt_e)) #그러므로 list들을 unlist를 통해 table로 만들어서 시각화!
#sorting
txt_s=sort(txt_t,decreasing = T) #내림차순 

txt_l=txt_s[str_length(names(txt_s))>1]#숫자에 대한 이름들을 

txt_h=head(txt_l,5)#앞에서 몇 개의 숫자를 볼 수 있는지(default=6)
#시각화 plot(), wordcloud()
barplot(txt_h) #막대그래프

#시각화 색상 바꾸는 것 도와주는 library 존재(rcolorbrewer library//wordcloud시 같이 옴)
#brewer.pal(개수,이름) 최대 12가지 선택 가능
pal=brewer.pal(7,"Set1")
wordcloud(names(txt_l),txt_l,scale=c(5,0.5),min.freq = 2,random.order=FALSE,rot.per = 0.2,col=pal)
#scale 최대, 최소/min.freq : 최대 빈도수
#random.order F인 경우 큰 규모대로 순차적으로 들어감(T인 경우 임의적으로 들어감)
#rot.per :글자들이 회전을 가짐
