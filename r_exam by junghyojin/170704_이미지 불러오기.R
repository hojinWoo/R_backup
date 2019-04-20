iris3

str(iris3) #3차원 구조 (3가지 종류의 데이터가 행,열,면의 개수가 같아야 3차원이 가능)
iris3[,,1]
iris3[1,1,] # 1번째행, 1번째열에 해당하는 모든 면의 값을 볼수 있음

  ### 이미지 불러오기 ###

install.packages('readbitmap')
library(readbitmap)

#1. bmp 읽기
bmp1 = read.bitmap('image7.bmp')
dim(bmp1) # 행, 열, 면수

#2. jpg 읽기
jpg1 = read.bitmap('image7.jpg')
dim(jpg1)

#3. png읽기
png1 = read.bitmap('image7.png')
dim(png1)

## 위의 것들을 matrix로 바꾸기

jpg1_m=matrix(jpg1, nrow=1, byrow = T )
png1_m=matrix(png1, nrow=1, byrow = T )
jpg1_m[1:10]

dim(jpg1_m)
dim(png1_m)



list1=list.dirs('.',full.names = T) # 현재폴더 안에 있는 폴더의 이름을 다 가져오는 것 하위 폴더도 가져옴, '.' 현재경로를 말해주는 부분, 기본적으로 charcter값으로 )
list1

?inclue.dirs


for(i in 2: length(list1)) {
  list2 = list.files('.',full.names = T, include.dirs = T ) # 안
}



for(i in 2: length(list1) ) {
list2 = list.files(list1[i],full.names = T, pattern = '.jpg' ,include.dirs = T ) # 파일명 리턴 : 문자열로 들어가면 된다, './a1' : a1폴더안에 있는~
}


