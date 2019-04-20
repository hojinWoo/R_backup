  ### 데이터 불러오기 ###

#1. 켜놓은 상태 & 블럭설정 해놓은 경우
data1=read.table('clipboard', header = T ) # 'clipboard' 엑셀 블락을 설정해놓았을 때(켜놓은 상태)불러올수 있음 바로! 

#2. csv로 불러오기
data2=read.csv('data1.csv' ) # header가 default 값으로 설정되어있음 , skip =3 을 쓰면 데이터 위에서1~3을 제외하고 가져옴, fill = !blank.lines.skip 빈칸을 지우고 가져옴


str(data2)
names(data2) =c("x1","x2") # 변수명 바꾸기

#3. xlsx로 가져오기 
install.packages('xlsx')
library('xlsx')

data3=read.xlsx('data1.xlsx',sheetIndex=1)
