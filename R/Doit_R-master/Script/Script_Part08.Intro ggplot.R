# ggplot2의 이해
# - Grammer of Graphics
# - 대표적인 2가지 함수 :
#   qplot: quick plot. 빠른 그래픽 함수 
#   ggplot: Grammer of Graphics. 체계적인 그래픽 함수
#   1) 데이터 추가, 2) aesthetic 추가 3) geom(선, 점) 추가 4) 옵션 추가

library(ggplot2)
library(dplyr)
head(iris)
dim(iris)

ggplot(iris, aes(Sepal.Length, Sepal.Width))
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point()

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, 
                 shape=Species, color=Petal.Width, 
                 size=Petal.Length)) + 
  geom_point()

# aes 함수 즉, aesthetic의 구성요소 
# x, y, alpha, color, fill, shape, size
## - color, shape, size : 점, 선에 적용
## - fill : 막대에 적용

# aes에서 명시하지 않은 요소는 geom에서 추가로 aes를 명시할 수 있다.

ggplot(iris) + geom_point(aes(x=Sepal.Length, y=Sepal.Width))
# geom_point에서 설정가능한 aes 요소: x, y, alpha, color, shape, size

b<-ggplot(iris)
b + geom_point(aes(x=Sepal.Length, y=Sepal.Width))
b + geom_point(aes(x=Petal.Length, y=Sepal.Width, shape=Species))
b + geom_bar(aes(Species))
b + geom_bar(aes(Species), stat='count')


### plot의 색 바꾸기 
ggplot(iris, aes(Species, Sepal.Length)) + geom_bar(stat = "identity")
ggplot(iris, aes(Species, Sepal.Length, fill=Species)) + 
  geom_bar(stat = "identity")
## - identity의 의미 이해:
# - identity는 y축 값의 높이를 데이터를 기반으로 정해줄 때 사용해줍니다. 
# - 즉, stat='identity'는 y축의 높이를 데이터의 값으로 하는 
# - bar그래프의 형태로 지정한다는 것입니다.
iris %>% group_by(Species) %>%
  select(Sepal.Length) %>%
  summarise(sum_sl = sum(Sepal.Length))


### plot의 순서 바꾸기
ggplot(iris, aes(Species, Sepal.Length, fill=Species)) + 
  geom_bar(stat = "identity") +
  scale_x_discrete(limits = c("virginica", "versicolor"))


### plot shape
ggplot(iris, aes(Sepal.Length, Sepal.Width, shape=Species)) + 
  geom_point()


### plot size
# theme_update(plot.title = element_text(hjust = 0.5))
ggplot(iris, aes(Sepal.Length, Sepal.Width, 
                 color=Species, size=Petal.Width)) + 
  geom_point() + 
  ggtitle("Sepal.Length vs. Sepal.Width") +
  theme(plot.title = element_text(hjust = 0.5))


## stats 레이어 사용하기
d<-ggplot(iris, aes(Sepal.Length))
d+stat_bin()
d+stat_bin(binwidth = 0.2)
# getwd()
# source("Script/11.1.ggmap.R", encoding="utf-8")
