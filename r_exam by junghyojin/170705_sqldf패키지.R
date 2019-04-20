  ### sqldf 패키지 ###

install.packages("sqldf")
library(sqldf)

sqldf (" select distinct Species from iris ")
sqldf (" select avg ( Sepal.Length ) from iris where Species ='setosa' ") # Sepal.Length의 ". " : 때문에 에러가 발생한다


sqldf (" select avg ( Sepal.Length ) from iris where Species ='setosa' ")

str(iris)
# 변환 (R -> SQL)
names(iris) = c('SL','SW','PL','PW','SP')

# 다시 바꾸
names(iris) = c('Sepal.Length','Sepal.Width','Petal.Length', 'Petal.Width','Species' )
str(iris)


sqldf (" select avg ( SL ) from iris where SP ='setosa' ")

### 데이터 처리 ###
library('MASS')
data("survey")
View(survey)

 #t 검정

model1 = t.test( Height  ~   Sex   ,survey )
model1

# t= t-statistic, df = 자유도
