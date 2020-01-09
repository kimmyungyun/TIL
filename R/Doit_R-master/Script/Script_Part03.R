#### 03-1 ####

## ---------------------------------------------------------------------- ##
a <- 1  # a에 1 할당
a       # a 출력

b <- 2
b

c <- 3 
c

d <- 3.5
d

a+b

a+b+c

4/b

5*b


## -------------------------------------------------------------------- ##
var1 <- c(1, 2, 5, 7, 8)    # 숫자 다섯 개로 구성된 var1 생성
var1

comp <- c(1, "Abc")
comp

var2 <- c(1:5)              # 1~5까지 연속값으로 var2 생성
var2

var3 <- seq(1, 5)           # 1~5까지 연속값으로 var3 생성
var3

var4 <- seq(1, 10, by = 2)  # 1~10까지 2 간격 연속값으로 var4 생성
var4

var5 <- seq(1, 10, by = 3)  # 1~10까지 3 간격 연속값으로 var5 생성
var5

var1
var1+2

var1
var2
var1+var2


## -------------------------------------------------------------------- ##
str1 <- "a"
str1

str2 <- "text"
str2

str3 <- "Hello World!"
str3

str4 <- c("a", "b", "c")
str4

str5 <- c("Hello!", "World", "is", "good!")
str5

str1+2

########## v1과 v2를 결합
### 1 3 5 0 2 4 6 7
v1 <- c(1, 3, 5, 0)
v2 <- c(2, 4, 6, 7)
q <- c(v1, v2)
q
# - 벡터q를 정렬
de_q <- sort(q)
#- 벡터 q에서 top3의 색인을 순서대로 출력
order(q, decreasing = TRUE)[1:3]
q[order(q, decreasing = TRUE)[1:3]]

# - 벡터 q의 순서를 역순으로 바꿔어라
rev_q <- rev(q)
rev_q
#- 벡터 q에서 짝수만 출력하라
q[q%%2 == 0]
for(i in 1:length(q)){
  if(q[i] %% 2 == 0){
    print(q[i])
  }
}

#- 0부터 10까지의 수중에 짝수만 출력하라
seq(0, 10, by = 2)

#- 벡터 q에서 홀수 위치의 값인 1, 5, 2, 6만 출력하라
q[seq(1, 7, by = 2)]

set.seed(123)
#- 벡터 q에서 랜덤하게 중복을 허용하여 10개의 수를 추출하라
sample(q, 10, replace=TRUE)

#- 벡터 q에서 랜덤하게 중복없이 4개의 수를 추출하라
sample(q, 4)

#- 변수 v1, v2를 삭제하라
rm(v1, v2)
remove(v1)
remove(v2)
rm(list = ls(pattern="v\\d"))

##
str = "I have a mail"
# "I have a mail"을 단어 단위로 쪼개고
s1 <- strsplit(str, " ")
# "a"가 존재하는 단어 색인을 출력하라
grep('a', s1[[1]])
# str5 에서 "o"가 존재하는 성분을 출력하라
grep('o', str5)
grepl('o', str5)


#### 03-2 ####

## -------------------------------------------------------------------- ##
# 변수 만들기
x <- c(1, 2, 3)
x

# 함수 적용하기
mean(x)
max(x)
min(x)

str5
paste(str5, collapse = ",")  # 쉼표를 구분자로 str4의 단어들 하나로 합치기
paste(str5, collapse = " ")
paste(str5, str3, sep=",")

x_mean <- mean(x)
x_mean

str5_paste <- paste(str5, collapse = " ")
str5_paste


#### 03-3 ####

## -------------------------------------------------------------------- ##
install.packages("ggplot2")  # ggplot2 패키지 설치
library(ggplot2)             # ggplot2 패키지 로드

# 여러 문자로 구성된 변수 생성
x <- c("a", "a", "b", "c")
x

y<-c(1, 3, 11, 7, 2, 9, 15, 18)

qplot(x, geom="histogram", bins=3) # Error 발생
hist(y)
qplot(y, geom="histogram", bins = 5)
# 빈도 그래프 출력
qplot(x)

mpg <- mpg
mpg

## -------------------------------------------------------------------- ##
# data에 mpg, x축에 hwy 변수 지정하여 그래프 생성
qplot(data = mpg, x = hwy)
summary(mpg$hwy)
# x축 cty
qplot(data = mpg, x = cty)

# x축 drv, y축 hwy
qplot(data = mpg, x = drv, y = hwy)

# x축 drv, y축 hwy, 선 그래프 형태
qplot(data = mpg, x = drv, y = hwy, geom = "line")

# x축 drv, y축 hwy, 상자 그림 형태
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot")

# x축 drv, y축 hwy, 상자 그림 형태, drv별 색 표현
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

# qplot 함수 매뉴얼 출력
?qplot

example(qplot)

# mpg 데이터를 사용
# - cty와 hwy 간 산점도를 그려라
qplot(data = mpg, x = cty, y = hwy, geom="point")
ggplot(mpg, aes(x = cty, y = hwy)) 
+ geom_point(size = 2) 
+ geom_smooth(method = "lm", se = F)

#- cyl 별 cty와 hwy간 산점도를 그려라
# cyl를 설명 변수로 해서 그림을 그려라
qplot(data = mpg, x = cty, y = hwy, geom="point", facets= ~ cyl)

# - cyl 별 hwy에 대한 boxplot을 그려라
qplot(data = mpg, x = cyl, y = hwy, geom="boxplot", group=cyl)
qplot(data = mpg, x = factor(cyl), y = hwy, geom="boxplot")

#- 제조사별 모델별 바차트를 작성하라
qplot(manufacturer, data = mpg, geom="bar") + coord_flip()
qplot(model, data = mpg, geom="bar") + coord_flip()

manuf_Mod = paste(mpg$manufacturer, mpg$model, sep = ' | ')
qplot(manuf_Mod, geom="bar") + coord_flip()
