library(plyr)
product=read.csv("product_2015_data/product.csv",header = T,fileEncoding = "UTF-8")
code=read.csv("product_2015_data/code.csv",header = T,fileEncoding = "UTF-8")

colnames(product)=c('date','category','item','region','mary','price')
str(product)
temp=ddply(product,.(item,date),summarise,mean.price=mean(price))
head(temp,n=10)
category=subset(code,code$구분코드설명=="품목코드")
colnames(category)=c('code','exp','item','name')
date.item.mean=merge(temp,category,by="item")
head(date.item.mean,n=10)
View(date.item.mean)
library(stringr)
month.item.mean=ddply(date.item.mean,.(name,item,month=str_sub(as.character.Date(date),1,7)),
                                          summarise,mean.price=mean(mean.price))
                  
head(month.item.mean,n=10)
#항상 data type확인 필요
str(month.item.mean)

temp=dlply(date.item.mean,.(name),summarise,mean.price)
daily.product=data.frame(쌀=unlist(temp$쌀),
                          배추=unlist(temp$배추),
                          상추=unlist(temp$상추),
                          호박=unlist(temp$호박),
                          양파=unlist(temp$양파),
                          파프리카=unlist(temp$파프리카),
                          참깨=unlist(temp$참깨),
                          사과=unlist(temp$사과),
                          돼지고기=unlist(temp$돼지고기),
                          닭고=unlist(temp$닭고기))
#품목들 중 일부 선별


head(daily.product,n=10)

temp=dlply(month.item.mean,.(name),summarise,mean.price)
monthly.product=data.frame(쌀=unlist(temp$쌀),
                            배추=unlist(temp$배추),
                            상추=unlist(temp$상추),
                            호박=unlist(temp$호박),
                            양파=unlist(temp$양파),
                            파프리카=unlist(temp$파프리카),
                            참깨=unlist(temp$참깨),
                            사과=unlist(temp$사과),
                            돼지고기=unlist(temp$돼지고기),
                            닭고=unlist(temp$닭고기))
head(monthly.product)

library(urca)
for (i in 1:9){
  for (j in 1:9){
    if((i+j)<11){
      jc=ca.jo(data.frame(daily.product[,i],daily.product[,i+j]),type="trace",K=2,ecdet="const")
      if(jc@teststat[1]>jc@cval[1]){
        if(jc@V[1,1]*jc@V[2,1]>0){
          cat(colnames(monthly.product)[i],"와",colnames(monthly.product)[i+j], ":음의 관계가 있다.","\n")
        } else {
          cat(colnames(monthly.product)[i],"와",colnames(monthly.product)[i+j], ":양의 관계가 있다.","\n")
        }}}}}
cor(daily.product)
library(corrplot)
p1=2
p2=3
p3=4
ac=c(p1:p3)




