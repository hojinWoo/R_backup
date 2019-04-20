# text mining-----------------------------------------------------
#사전 base이다.

rm(list=ls()) #우측에 있는 환경의 global environment들이 다 지워짐 or 빗자루 표시~

txt=readLines('big_test.txt', encoding = 'UTF-8') #line별로 읽어 들여줌(enter기준), 
#working director에 파일 경로가 없는 경우//필요할 경우 다 써야 함

str(txt) #chr형식인지 알 수 있음(charcter)
txt[11] #행과 열의 숫자가 달라도 가능하다. 그 안에 변수로 취급되기 때문에

list1=list(sp=1, sp2=c(1,3,5), y=c("A","B")) #list 생성
list1[2] #list안에 object개념으로 변수 안에 변수를 가지는 기능!!
#그렇기 떄문에 $표시로 나타남/ 그 변수와 값이 다 나타남

list1$sp2 #변수 이름을 통해 값만 나타내는 방법
list1[[2]] #첨자 형태로 불러오는 방법--대괄호를 통해 숫자를 넣어서 값을 불러올 수 있음

#list안에 list 만드는 방법
list2=list(x=list1,y=list1)
str(list2)
list2[1]
list2[[1]]
list2[[1]][2]#변수의 값과 이름을 불러오는 과정
list2[[1]][[2]]#변수의 값을 불러오는 과정

#단어별 문장 구분하기 위한 방법
nchar(txt) #index안에 글자 수 확인 가능
txt0=txt[nchar(txt)>1] #글자수가 1인 것들만
nchar(txt0)

#package 설치

install.packages('KoNLP',dependencies = T)#dependency 설정 시 설치 시 연관된 것들 같이 설치하게 함

library(KoNLP)

txt_n=extractNoun(txt1) #명사만 추출
#str(txt_n)
txt_n=table(unlist(txt_n))#list를 해제 시켜줘야 함! 하나의 변수로 묶기 위해서(list안에 있는 경우 다 각각의 변수로 설정이 되어 있음)

#install.packages('wordcloud')
#library(wordcloud) #화면에 단어 목록을 좋게 보여주는 것
wordcloud(names(txt_n),txt_n) #전처리기 없이 그냥 default로 넣은 것// list로는 넣을 수 없음

#단어를 어떻게 자를 것인지, ex.품사별로도 가능

#사전등록
useSejongDic()

#-------------------------------------------------------------
#https://cran.r-project.org/ 에서 package, 확장팩들 찾을 수 있음(7.3 기준 약 5천)
#nlp : 한국어 자연어 처
#tm: text mining용 
#oracle : oracle을 지원해주는(databasse) 것 찾을 수 있음
#readbeat : 이미지의 package 정보들(bmp, jpeg, png) 다 지원

#더 고급 수준 -> 진행 상황 https://www.r-bloggers.com/에서 더 찾을 수 있음

#명사 추출 이전에 사전에 데이터들을 합쳐줘야 함(데이타 / 데이터) - 한 번 만 사용해도 됨
txt1=gsub("bigdata","빅데이터",txt0) #글자 찾아바꾸는 기능 vs grab: text안에 내가 지정한 특정글자가 있는 지 없는지 true,false
#영어를 바꿀 때는 소문자로 해서 할 것
txt1=gsub('[A-z]','',txt1) #바꾼 곳을 계속 update + 단순 글자가 아닌 특정 패턴을 통해 찾기!!!
#------>영어를 다 지우는 것 (앞 뒤가 "",''통일만 이루어지게 하면 됨)


#숫자를 키워드를 통해 지우는 방법 ('정규표현식')
# 소괄호는 묶음 중 하나라는 뜻, 대괄호는 패턴이라는 뜻
txt1=gsub("[[:digit:]]","",txt1) # 숫자 다 지우기
txt1=gsub("[[:punct:]]","",txt1) # Punctuation characters: ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~.
txt1=gsub("  "," ",txt1) #2개 공백을 1개의 공백으로 // space는 마지막으로 하는 것이 좋












