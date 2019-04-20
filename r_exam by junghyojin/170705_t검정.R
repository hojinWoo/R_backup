
## 정규분포를 이용한 난수 발생##

  ## 단일인 경우 ##
data1= rnorm(100, mean=180, sd=10) # 정규분포 평균 180, 표준편차 10 인 거에서 데이터 100개 추출


# ?rnorm : rnorm(갯수, mean = a, sd= b  )


#?t.test : t.test(x, y = NULL,alternative = c("two.sided", "less", "greater"),mu = 0, paired = FALSE, var.equal = FALSE,conf.level = 0.95, ...)

## 채택case
t.test(x=data1, mu=180)
# p-value > 0.05보다 크기 때문에 채택(채택역안에 들어옴 ) 즉, 평균은 180이라 할 수 있다(가깝다)

## 기각case
t.test(x=data1, mu=200)

 ## 2개인 경우 ##
data1= rnorm(100, mean=180, sd=10) # 정규분포 평균 180, 표준편차 10 인 거에서 데이터 100개 추출
data2 = rnorm(100,mean = 160, sd=5)

var.test(x=data1,y=data2) # 등 분산 or 이 분산 검정  (이 경우는 표준편차가 다름 -> 이 분산)
# F 분포가 나오는 이유는 분산의 비 ( data1 분산/ data2 분산   =1 인경우 : 같음, 1 초과 or 1미만 : 둘이 다름)
## F >1 & p-value <0.05: 두 분산이 다름( =이분산), var.eqaul = F  라는 값을 두 집단 t검정시 활용 할 수 있음!
t.test(x=data1,y=data2,var.equal = F)
