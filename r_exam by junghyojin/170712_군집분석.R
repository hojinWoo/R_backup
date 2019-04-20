
      ##### 군집 분석 ######
  
  ##1. hcluster(계층적 군집 분석)
      
a=c(1,6)    
b=c(2,4)
c=c(5,7)
d=c(3,5)
e=c(5,2)
f=c(5,1)

c_data = data.frame(a,b,c,d,e,f)
c_data = t(c_data) # t =T (Trans : 행,열 서로 바꾸기)

d=dist(c_data, method = 'euclidean')

# h_cluster 군집분석(계층적 군집분석) method :"single"(가장 짧은거), "complete"(가장 긴거), "average" (= UPGMA), "mcquitty" (= WPGMA), "median" (= WPGMC) or "centroid" 
h1=hclust(d,method ='single' ) # single의 의미 : 그룹(b,d)에서 a 점과 최소거리를 기준으로 분류하겠다 
plot(h1) 
 

  ##2. k-means 군집분석(y값이 아예 없을때, 사전의 중심점을 미리 지정하는 방법, 순수 x 값만을 가지고 분류하는 기법)

# 2-1) iris 

k1=kmeans(iris[,1:4], 3 ) # "3"의 의미 : 군집을 3개로 할 때 kmeans\
################## 최적의 군집 수 찾기 ##################

k0=data.frame()
for( i in 1:6 ) {
  k2=kmeans(iris[,1:4], i,iter.max =1000 ) # iter.max=30 : 30번 돌린다는 의미
  k3=cbind(i,k2$tot.withinss)
  k0=rbind(k0,k3)  
}
plot(k0,type='b') # type옵션 : p= point b=both // # 최적의 k=3 (그래프 해석을 바탕으로)
k0[which.min(k0[,2]),]

k1$centers # 각 군집들의 기준점
k1$cluster 
k1$withinss # 그룹 내부 오차
k1$tot.withinss # 그룹 내부 오차들의 총합

k1$betweenss # 그룹 간 오차

table(iris$Species, k1$cluster)
str(k1$cluster)
clust1 =ifelse(k1$cluster ==2,3, ifelse(k1$cluster ==3,2, k1$cluster))
table(iris$Species, clust1)
table(iris$Species, k1$cluster)


# 2-2) chapter9장에 snsdata를 이용한 분석 

teens=read.csv('Machine Learning with R code/mlr-ko/chapter 9/snsdata.csv') # sep = seperate(구분되어있다)

table(teens$gender, useNA = "ifany") # useNA = "ifany" : 결측치 값을 생략하지 않고 몇개 있는지 보여줘라
summary(teens$age) # na값이 존재하는지 보기 : NA값도 있고 십대의 나이가 3살,106살도 있음 => 이들은 잘못된 데이터임(Outlier)

teens$age = ifelse(teens$age>=13 & teens$age<20, teens$age, NA) # 나이가 13살 이상 20세 미만이면 원래 값, 아니면 NA값으로 입력(이상치 처리), NA는 상수로 인식
#새로운 변수 생성: 없던 변수를 $뒤에쓰면 생성이됨
teens$female =  ifelse(teens$gender =='F', 1,0) # female 이라는 '열'을 만든다. 이 값은 gender값이 F 이면 1, 아니면 0의 값을 입력
teens$no_gender = ifelse(is.na(teens$gender), 1,0) #no_gender라는 '열'을 만든다. gender값이 na이면 1, 아니면 0

table(teens$gender, useNA = "ifany")
table(teens$female, useNA = "ifany")
table(teens$no_gender, useNA = "ifany")

ave_age = ave(teens$age, teens$gradyear, FUN =function(x) mean(x, na.rm = TRUE))
#졸업연도별(gradyear) age데이터가 나누어져서 그 값이 x로 들어가고 그 값을 mean x로 들어가 평균을 구하게 된다.
#na데이터도 들어가서 같이 계산할 수 있도록
#이함수는 값ㅇ 30000개 모두나오며 각 년도별 평균값이 모두나옴

teens$age = ifelse(is.na(teens$age), ave_age, teens$age) #NA값에는 ave_age값을 넣고, 아니면 본래의 값을 넣는다. 
table(teens$age, useNA = "ifany")
length(which(teens$age == 'NA')) 

interests = teens[, 5:40]
interests_z = scale(interests) #scale 자동으로 열단위 처리

teen_clusters = kmeans(interests_z, 5)
table(teen_clusters$cluster)
#centers가 중심점
teen_clusters$centers #각변수마다의 집단에서의 중심점
View(teens)
