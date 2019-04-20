# dotchart함수 사용하기

# dotchart(x, labels=) : x는 숫자 vector, 
#  labels는 각점의 레이블
#  groups 인자를 이용하면 그룹핑을 할 수 있다.


attach(mtcars)
dotchart(mpg, labels=row.names(mtcars),
         main="자동차 모델별 연비",
         xlab="Gallon당 miles",cex=.5)

x<-mtcars[order(mpg),]
x$cyl<-factor(x$cyl)
x$color[x$cyl==4] <-"red"
x$color[x$cyl==6] <-"darkgreen"
x$color[x$cyl==8] <-"blue"

dotchart(x$mpg, labels=row.names(x), 
     cex=.5, groups=x$cyl, 
     main="실린더 갯수에 따른 자동차 모델별 연비",
     xlab="gllen 당 Miles", color=x$color)
detach(mtcars)

par(mfrow=c(1,1))

mtcars

# sort함수 order함수
data()

v1<-c(40,30,50,50,90,40,50)
v1
sort(v1) #오름차순으로 정렬(숫자 자체를 정렬)
sort(v1, decreasing = TRUE) # 내림차순 정렬
order(v1) # 정렬된 색인을 출력
v1[order(v1)] 

# sort() 데이터 프레임에서 사용할 수 없다.

sort(mtcars$mpg)

mtcars[order(mtcars$mpg),]

