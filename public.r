#공공data
rm(list=ls())
library(xlsx)

s1=read.xlsx('w_seoul.xlsx',sheetIndex=1,startRow = 2, header=T,encoding = 'UTF-8')
s2=read.xlsx('w_sok.xlsx',sheetIndex=1,startRow = 2, header=T,encoding = 'UTF-8')
s3=read.xlsx('w_suwon.xlsx',sheetIndex=1,startRow = 2, header=T,encoding = 'UTF-8')

gg1=read.table('clipboard',header=T) #복사한 것

var.test(gg1$X06시,gg1$X18시)
t.test(x=gg1$X06시,y=gg1$X18시,var.equal=F,paired=T)#var.equal=F : 이분산, T:공분산
#paired=T로 하면 지역적으로 편차가 일어나는 지도 확인


#순수효과를 보기 위해 오차를 배제해야 함 (paired 사용하는 것-->T검정)


