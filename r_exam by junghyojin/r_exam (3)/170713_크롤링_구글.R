
### 크롤링 ###

install.packages('rvest') # 안에 내용적인 부분을 다루는 패키지
install.packages('httr') # html과 관련되어있는 패키지
library(httr)
library(rvest)

text1=GET("http://terms.naver.com/entry.nhn?docId=1691554&cid=42171&categoryId=42183")
text2=read_html(text1) # html에만 해당하는 것 뽑기

## 원하는 부분만 추출할 수 있도록 하는 단계!
text3=html_nodes(text2,"h3") # 해당 페이지 - 우클릭 - 요소검사 - "h3" 부분에 해당하는 것을 가져옴
text4=html_text(text3) # text 형태 보기
html_text(text4) # 마지막 단계




#https://search.naver.com/search.naver?ie=utf8&where=news&query=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EB%B9%85%ED%8C%8C%EC%9D%B4&sm=tab_pge&sort=0&photo=0&field=0&reporter_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:all&mynews=0&cluster_rank=33&start=1&refresh_start=0
#https://search.naver.com/search.naver?ie=utf8&where=news&query=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EB%B9%85%ED%8C%8C%EC%9D%B4&sm=tab_pge&sort=0&photo=0&field=0&reporter_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:all&mynews=0&cluster_rank=17&start=11&refresh_start=0
#https://search.naver.com/search.naver?ie=utf8&where=news&query=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EB%B9%85%ED%8C%8C%EC%9D%B4&sm=tab_pge&sort=0&photo=0&field=0&reporter_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:all&mynews=0&cluster_rank=50&start=21&refresh_start=0
#https://search.naver.com/search.naver?ie=utf8&where=news&query=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EB%B9%85%ED%8C%8C%EC%9D%B4&sm=tab_pge&sort=0&photo=0&field=0&reporter_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:all&mynews=0&cluster_rank=77&start=31&refresh_start=0

?paste

url = "https://search.naver.com/search.naver?ie=utf8&where=news&query=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EB%B9%85%ED%8C%8C%EC%9D%B4&sm=tab_pge&sort=0&photo=0&field=0&reporter_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:all&mynews=0&cluster_rank=33&start="

#바뀌는 부분만 for 이용

tot = c()

for(i in seq(1, 449, 10)){ # 총 페이지 수가 449페이지 였고, start값이 1에서 부터 10씩 증가했음
  url1 = paste(url, i, "&refresh_start=0") #paste ("a","b","c") : a b c 의 값을 산출함(공백이 한칸씩 있음)
  # print(url1)
  text1=GET(url1) 
  text2 = read_html(text1)#원하는 부분만 끌고옴
  html_text(text2)#원하는 부분 읽음 
  text3 = html_nodes(text2, "dd")#class or id이름 info_wrap로 나온거만 나타남
  text4 = html_text(text3)
  tot = c(tot, text4)
  
}


















