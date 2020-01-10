#### 08-2 ####

## -------------------------------------------------------------------- ##
library(ggplot2)

# x축 displ, y축 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))

# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# x축 범위 3~6으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

# x축 범위 3~6, y축 범위 10~30으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) + 
  ylim(10, 30)

##
# mpg 데이터의 cty와 hwy 간에 어떤 관계가 있는지 확인해보자
# x축은 cty, y축은 hwy로 된 산점도를 만들어보자
ggplot(mpg, aes(cty, hwy)) + geom_point()
ggplot(midwest, aes(poptotal, popasian)) + geom_point() + xlim(0, 500000) + ylim(0, 10000)
#### 08-3 ####

## -------------------------------------------------------------------- ##
library(dplyr)

df_mpg <- mpg %>% 
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg

# 데이터를 그대로 적용해도 되는 것은 geom_col 함수
# geom_col은 범주와 값인 2개의 변수가 필요함
# 데이터를 읽어서 빈도를 계산해야한다거나 같은 상황이면 geom_bar 함수를 사용
# 변수 하나만 줘도 별 문제가 없음, 2개를 줘도 되긴 함
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

# reorder 함수를 통해 mean_hwy의 내림차순으로 계산되도록 함
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

ggplot(data = mpg, aes(x = drv)) + geom_bar()

ggplot(data = mpg, aes(x = hwy)) + geom_bar()
ggplot(data = mpg, aes(x = hwy)) + geom_histogram(bins=20)

### QUIZ
# SUV 차종을 대상으로 평균 cty가 높은 회사 다섯곳을 막대 그래프로 
#표현, 막대는 연비가 높은 순으로 정렬
new_mpg <- mpg %>% select(manufacturer, class, cty) %>%
  filter(class=='suv') %>%
  group_by(manufacturer) %>%
  summarise(means_cty = mean(cty)) %>%
  arrange(desc(means_cty))


ggplot(data = new_mpg %>% head(5), aes(x = reorder(manufacturer, -means_cty), y = means_cty)) +
  geom_col()

# 자동차 종류별 빈도를 확인하라
ggplot(data = mpg, aes(x = class)) +
  geom_bar()
#### 08-4 ####

## -------------------------------------------------------------------- ##
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()


#### 08-5 ####

## -------------------------------------------------------------------- ##
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()
boxplot(mpg$hwy ~ mpg$drv) # drv에 따른 hwy 에 대한 boxplot을 그려라 라는 의미로 볼 수 있다

#QUIZ
#class가 compact, subcompact, suv인 자동차의 cty에 따라 상자 그림을 그리시오
new_mpg <- mpg %>% filter(class %in% c("compact", "subcompact", "suv"))
ggplot(data = new_mpg, aes(x = class, y = cty)) + geom_boxplot()

## -------------------------------------------------------------------- ##
## 1.산점도
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# 축 설정 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)


## 2.평균 막대 그래프

# 1단계.평균표 만들기
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

# 2단계.그래프 생성하기, 크기순 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()


## 3.빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()

## 4.선 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

## 5.상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

