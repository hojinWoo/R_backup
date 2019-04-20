# Treemap : treemap 패키지를 설치

install.packages("treemap")
library(treemap)

gnipc<-read.csv("E:\\빅데이터강좌\\R\\exam
                \\E050112\\GNIPC.csv", header=TRUE)
df<-data.frame(gnipc)
df
df$GNIPC<-as.numeric(df$GNIPC)
treemap(df, index=c("Economy", "code"), vSize="GNIPC", 
        vColor="GNIPC", type="value")
treemap(df, index=c("Economy", "code"), vSize="GNIPC", 
        type="index")

data()

data(GNI2014)
GNI2014
treemap(GNI2014, index=c("continent","iso3"), 
        vSize="population",
        vColor="GNI", type="value")
treemap(GNI2014, index=c("continent","iso3"), 
        vSize="population",
        type="index")

#####################################################
data(business)
str(business)

business
treemap(business, index=c("NACE1", "NACE2", "NACE3"), 
        vSize="turnover", type="index")
write.csv(business, "~/test/business.csv")

treemap(business[business$NACE1=="F - Construction",],
        index=c("NACE2","NACE3"), vSize="employees",
        type="index")
treemap(business[business$NACE1=="F - Construction",],
        index=c("NACE2","NACE3"), vSize="employees",
        type="value")
treemap(business[business$NACE1=="F - Construction",],
        index=c("NACE2","NACE3"), vColor="employees",
        vSize="employees", 
        type="value")
treemap(business[business$NACE1=="F - Construction",],
        index=c("NACE2","NACE3"), vColor="turnover",
        vSize="employees", 
        type="value")
treemap(business[business$NACE1=="F - Construction",],
        index=c("NACE2","NACE3"), 
        vColor="employees.prev",vSize="employees", 
        type="comp")
treemap(business,index=c("NACE1","NACE2","NACE3"), 
        vSize="turnover", type="depth")


# transform함수

height<-c(175,159,166,189,171,173,179,165,180,170)
weight<-c(62,55,59,75,61,64,63,65,70,60)
hwdf<-data.frame(height, weight)
hwdf

#bmi지수공식(몸무게/(키/100)^2) 키단위는 미터이다.

bmi<-hwdf$weight/(hwdf$height/100)^2
bmi
hwdf$bmi<-bmi
hwdf

#transform()함수 사용예 : transform(dataframe,new변수 = 수식)

hwdf<-transform(hwdf, bmi2=weight/(height/100)^2)


business<-transform(business, 
                    available=factor(!is.na(turnover)),
                    y=1)
treemap(business, index=c("NACE1", "NACE2"), vSize="y", 
        vColor="available", type="categorical")

nlevels(business$NACE1)
rainbow(21)

business$color<-topo.colors(nlevels(business$NACE1))[business$NACE1]
business
treemap(business, index=c("NACE1", "NACE2"), vSize="employees",
        vColor="color", type="color")



