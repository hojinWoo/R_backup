
install.packages("")
library=c("plyr","ggplo2","stringr","zoo"
          ,"corrplot","RcolorBrewer")
unlist(lapply(library1, require, character.only=TRUE))

product=read.csv("product_2015_data/product.csv",header = T,fileEncoding = "UTF-8")
code=read.csv("product_2015_data/code.csv",header = T,fileEncoding = "UTF-8")
weather=read.csv("product_2015_data/weather.csv",header = T,fileEncoding = "UTF-8")

summary(product)
str(code)

colnames(product)=c('date','category','item','region','mart','price')

category=subset(code,code$구분코드설명=="품목코드")

colnames(category)=c('code','exp','item','name')

total.pig=product[which(product$item==514),]#돼지고기 소매 가격
head(total.pig,n=10)#앞에서 10개

#조건에 해당하는 것들을 같은 set으로 반영함
region=subset(code,code$구분코드설명=="지역코드")#지역이 어디인지 알기 위해서

colnames(region)=c('code','exp','region','name')

day.pig=merge(total.pig,region,by="region",all=T)#지역으로 묶음
head(day.pig,n=10)
View(day.pig)

#install.packages("plyr")
library(plyr)
total.pig.mean=dlply(ddply(ddply(day.pig,.(date),summarise,name=name,region,region
                                 ,price=price),.(date,name),summarise,mean.price=
                             mean(price)),.(name))
total.pig.mean$수원

library(doBy)
a1=summaryBy(price~date+name,day.pig,FUN=mean)#요약 정리된 table
a2=splitBy(~name,a1)
str(a2)
a2$수원

sort(day.pig,decreasing = T)#vector단위만 정렬,, 부족함

install.packages("dplyr")
library(dplyr)

#정렬할 때 더 강력
aa1=arrange(day.pig,name,desc(date))
head(aa1)

# %in% 해당하는 것 false에 해당하는 값만 추출
day.pig=day.pig[!day.pig$name %in% c("의정부","용인","창원","안동","포항","순천","춘천"),]



# %>% 이전에 작업한 거 받아서 계속 작업
Sys.Date() #연도 or 월만 추출하고 싶을 때
library(timeDate)
library(lubridate)#날짜는 인식이 포맷이 안 맞으면 인식 못

dd1=day.pig$date[1:10]
str(dd1)
dd2=as.Date(dd1)
str(dd2)#date type이 되어야 사친연산 및 알림 등 가
dd7=as.Date(format(dd2,"%Y-%m-01"))#format쓰면 string으로 return돼서 as.Date()써야 함
dd3=gsub('[-]','.',dd1) #이러면 불가
dd3

dd3=as.Date(dd3)

dd4=ymd(dd3)#as.date 안 써도 가능
str(dd4)
dd5=as.Date(gsub('[.]','-',dd3)) #같은 것
dd5=gsub('[.]','-',dd3) %>% as.Date()
year(dd4)
month(dd4)
day(dd4)
year(dd5)


pig.region.daily.mean=ddply(day.pig,
      .(name,region,date),summarise,mean.price=mean(price))
head(pig.region.daily.mean,n=10)

library(stringr)
pig.region.month.mean=ddply(pig.region.daily.mean,.(name,region,month=str_sub(pig.region.daily.mean$date,1,7)),summarise,mean.price=mean(mean.price))
head(pig.region.month.mean,n=10)


pig.region.yearly.mean=ddply(pig.region.daily.mean,.(name,region,year=str_sub(pig.region.daily.mean$date,1,4)),summarise,mean.price=mean(mean.price))
head(pig.region.yearly.mean,n=10)

#datatype이여야 시각화가 가능
library(zoo)
pig.region.month.mean$month=as.Date(as.yearmon(pig.region.month.mean$month,"%Y-%m"))
#as.yearmon() : factor type 데이터 월별 시계열로 변환, '일'이 없다보니 1로 통일
View(pig.region.month.mean)
str(pig.region.month.mean)
library(ggplot2)
#시각
ggplot(pig.region.month.mean,aes(x=month,y=mean.price,colour=name,group=name))+
  geom_line()+theme_bw()+geom_point(size=6,shape=20,alpha=0.5)+ylab("돼지고기 가격")+xlab("")


library(plyr)
#상관계수 그림
temp=plyr::dlply(pig.region.daily.mean,.(name),summarise,mean.price)
summarise((group_by(pig.region.daily.mean,name)),mean.price)

#지역별 변수 작업
pig.region=data.frame(서울=unlist(temp$서울),
                        부산=unlist(temp$부산),
                        대구=unlist(temp$대구),
                        인천=unlist(temp$인천),
                        광주=unlist(temp$광주),
                        대전=unlist(temp$대전),
                        울산=unlist(temp$울산),
                        수원=unlist(temp$수원),
                        청주=unlist(temp$청주),
                        전주=unlist(temp$전주),
                        제주=unlist(temp$제주))
cor_pig=cor(pig.region)
library(corrplot)
library(RColorBrewer)
library(zoo)
corrplot(cor_pig,method="color",type="upper",order="hclust",addCoef.col = "White",
         tl.srt=0,tl.col="black",tl.cex=0.7,col=brewer.pal(n=8,name="PuOr"))

temp1=unlist(temp)
str(temp1)
temp2=as.matrix(temp1)
as.data.frame(temp1)
temp_s=stack(temp)

c_data=data.frame()*length(temp[[1]])
c_data1=data.frame(name=c(),price=c())
#data 누적시키기
for(i in 1:length(temp)){
  c_data1=rep(names(temp[[i]])*length(temp[[i]]))#temp[[1]]에 있는 name 찾아오기
  c_data1$price=temp[[i]]
  c_data=rbind(c_data,c_data1)
}

m1=as.data.frame(matrix(1:15,nrow=3))
m2=stack(m1)

write.csv(pig.region,"product_2015_data/pig.region.csv",fileEncoding = "UTF-8")
write.csv(pig.region.month.mean,"product_2015_data/pig.region.month.mean.csv",fileEncoding = "UTF-8")





