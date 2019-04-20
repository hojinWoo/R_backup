# var.test를 처리해주는 패키지 

install.packages('car')
library(car)

# 등분산 인지 이분산인지 체크해주는 
data("iris")

leveneTest(Sepal.Length~Species,data = iris) # var.test는 정규분포에 최적화되어있음, 따라서 다른 분포 같은 경우 완벽한 최적화가 아닐 수 있음. 
#  이 검정은 집단간 동분산 인지 아닌지에 대한 검증



# 데이터 출처 http://archive.ics.uci.edu/ml/datasets.html