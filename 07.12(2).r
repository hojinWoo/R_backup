

teens=read.csv('snsdata.csv')
View(teens)

table(teens$gender,useNA='ifany') #NA 값 존재 여부

summary(teens$age)#summary를 통해서도 확인 가능

#이상치들 NA값으로 묶어버림(정확한 수치를 알 수 없기 때문)
teens$age=ifelse(teens$age>=13&teens$age<20,teens$age,NA)

teens$female=ifelse(teens$gender=="F"&!is.na(teens$gender),1,0)
teens$no_gender=ifelse(is.na(teens$gender),1,0)#성별이 NA로 나와있는 사람들 --알 수 없기에

head(teens,3)

#결측치 처리(존재하지 않는 )
ave_age=ave(teens$age,teens$gradyear,FUN=function(x) mean(x, na.rm=T))

teens$age=ifelse(is.na(teens$age),ave_age,teens$age)
summary(teens$age)

#평균값이 들어가도록 교체
teens&age=ifelse(is.name(teens$age),ave_age,teens$age)
table(teens$age,useNA="ifany")
length(which(teens$age==NA))#더 이상 NA값 존재 X


interests=teens[,5:40]#teens[5:40] 생략하면 무조건 열 번호로 인식하게 됨

#각각 열에 대해 표준화
interests_z=scale(interests)

#clust작업
teen_clusters=kmeans(interests_z,5)
teen_clusters$cluster
table(teen_clusters$cluster)
#각각의 항목의 중심점
teen_clusters$centers


#--------------------------------------------------------------------------
pig.region=read.csv('product_2015_data/pig.region.csv',header=T,fileEncoding = 'UTF-8')
head(pig.region,n=10)

pig.region.monthly.mean=read.csv('product_2015_data/pig.region.monthly.mean.csv',header=T,encoding = 'UTF-8')
head(pig.region.monthly.mean,n=10)

date.item.mean=read.csv('product_2015_data/date.item.mean.csv',header=T,fileEncoding  = 'UTF-8')[,-1]

month.item.mean=read.csv('product_2015_data/month.item.mean.csv',header = T,fileEncoding ='UTF-8')[,-1]
str(date.item.mean)
View(month.item.mean)
library(plyr)
temp=dlply(date.item.mean,.(name),summarise,mean.price)
farm.product=data.frame(쌀=unlist(temp$쌀),
  배추=unlist(temp$배추),
  상추=unlist(temp$상추),
  호박=unlist(temp$호박),
  양파=unlist(temp$양파),
  파프리카=unlist(temp$파프리카),
  참깨=unlist(temp$참깨),
  사과=unlist(temp$사과))
head(farm.product,n=10)

#cor 함수는 한꺼번에 다 표현하려면
#dlply로 나온 출력된 list구조는 안되고(list구조는 쌍으로 2개만 가능)
#matrix구조로 변환해주어야 함(data.frame)

library(TSclust)#tcclust가 clust까지 다 설치함
#diss : 상관계수 방식으로 거리를 구함
#관계성이 높을수록 거리가 가까운 것으로
plot(hclust(diss(farm.product,"COR")),axes = F,ann=F)
methods(plot)#plot들 안데 어떤 것이 있는 지 알 수 있음

#lm으로 비선형회귀를 하는 것을 추천


#목적과 세부목적을 정하고 결과를 도출할 것 (인과관계를 정확하게)
#종합적으로 결과가 나와야 하는데 여기서는 없음 //앞에든 뒤에든 결론이 필
