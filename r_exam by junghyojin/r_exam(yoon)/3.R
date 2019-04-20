rm(list = ls() ) #지우고 싶을 때 environment에 데이터 지워짐 빗자루같은거 눌러도됨 
txt = readLines('big.txt', encoding = 'UTF-8') #복수라인 읽어줌 엔터기준으로 구분 원래데이터 마지막 줄 뒤에 엔터

str(txt)#txt데이터가 chr로 되어있음
txt[13]
list1 = list(sp = 1, sp2 = c(1,3,5), y=c("A","B"))

list1[1] #첫번째 변수명과 그 값
list1[2] 
list1$sp2 #sp2의 값만 나타남
list1[[2]]#두번째 변수에 대한 그 값

list2 = list(x = list1, y = list1) #list안에 list넣기
str(list2)
list2[[1]][2] #첫번째 list안의 두번째 list를 가져옴
list2[[1]][[2]]#첫번째 list안의 두번째 list의 값만 가져옴 대괄호 2개 사용

nchar(txt) #여기서 0,1은 비어있는 칸 
txt0 = txt[nchar(txt)>1] #1초과인거만 뽑아냄
nchar(txt0)

#단어마다 추출을 해야함 textmining은 영어전용 패키지  KoNLP한글전용
#텍스트 마이닝은 사전베이스로 진행됨
#install.packages('KoNLP', dependencies = T)
library(KoNLP)

#useSejongDic() #세종단어사전 다운로드
#빅데이터와 빅데이타와 같은 같은단어인데 다르게 인식되어 빈도수가 다르게 나올수 있음
#이과정은 명사 추출 이전에 해야함
#찾아바꾸기 기능 : gsub
txt1 = gsub("bigdata","빅데이터" , txt0) #bigdata를 빅데이터로 바꿔줌
txt1 = gsub("[A-z]", "" ,txt1) #대괄호 안에있는 모든걸 찾아라(영어를 모두 찾아라)
txt1 = gsub("[[:digit:]]", "", txt1) #대괄호는 패턴을 나타냄
txt1 = gsub("[[:punct:]]", "", txt1) #punct는 특수문자 digit는 숫자
txt1 = gsub("  ", " ", txt1)

txt_n = extractNoun(txt1) #명사추출
str(txt_n) #어떤형태인지
txt_t = table(unlist(txt_n)) #빈도구하기 위해서 변수안에 변수는 안들어가서 리스트를 해제해줌

#워드클라우드 진행
#install.packages('wordcloud') #모양지정이 워드클라우드2
#library(wordcloud)

wordcloud(names(txt_t), txt_t) #txt t 안에있는 이름을 가져옴


