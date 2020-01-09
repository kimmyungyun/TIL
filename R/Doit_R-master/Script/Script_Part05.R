#### 05-1 ####

library(ggplot2)
## -------------------------------------------------------------------- ##
exam <- read.csv("../Data/csv_exam.csv")

head(exam)      # 앞에서부터 6행까지 출력
head(exam, 10)  # 앞에서부터 10행까지 출력

tail(exam)      # 뒤에서부터 6행까지 출력
tail(exam, 10)  # 뒤에서부터 10행까지 출력

exam[-10:-1, ]
exam[-c(1:5), ]

View(exam)      # 데이터 뷰어 창에서 exam 데이터 확인
dim(exam)       # 행, 열 출력
str(exam)       # 데이터 속성 확인
summary(exam)   # 요약 통계량 출력


## -------------------------------------------------------------------- ##
# ggplo2의 mpg 데이터를 데이터 프레임 형태로 불러오기
mpg <- as.data.frame(ggplot2::mpg)

head(mpg)     # Raw 데이터 앞부분 확인
tail(mpg)     # Raw 데이터 뒷부분 확인
View(mpg)     # Raw 데이터 뷰어 창에서 확인
dim(mpg)      # 행, 열 출력
str(mpg)      # 데이터 속성 확인
summary(mpg)  # 요약 통계량 출력

df2 <- as.data.frame(table(mpg$model))
names(df2) <- c("model", "freq")
df2
#### 05-2 ####

## -------------------------------------------------------------------- ##
df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

install.packages("dplyr")  # dplyr 설치
library(dplyr)             # dplyr 로드

df_new <- df_raw  # 복사본 생성
df_new            # 출력

# rename(df_name, new_v_name = old_v_name)
df_new <- rename(df_new, v1 = var1, v2 = var2)  # var2를 v2로 수정
df_new

names(df_new) <- c("v1", "v2")
colnames(df_new) <- c("var1", "var2")

#### 05-3 ####

## 혼자 해보기
# 복사본 만들기
mpg <- as.data.frame(ggplot2::mpg)
copy_mpg <- mpg

#cty는 city로, hwy는 highway로 변경
copy_mpg <- rename(copy_mpg, city = cty, highway = hwy)
copy_mpg


## -------------------------------------------------------------------- ##
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2       # var_sum 파생변수 생성
df

df$var_mean <- (df$var1 + df$var2)/2  # var_mean 파생변수 생성
df


## -------------------------------------------------------------------- ##
mpg$total <- (mpg$cty + mpg$hwy)/2  # 통합 연비 변수 생성
head(mpg)
mean(mpg$total)  # 통합 연비 변수 평균


## -------------------------------------------------------------------- ##
summary(mpg$total)  # 요약 통계량 산출
h <- hist(mpg$total)     # 히스토그램 생성

qplot(total, data=mpg)
str(h)

# 20이상이면 pass, 그렇지 않으면 fail 부여
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")

head(mpg, 20)     # 데이터 확인

table(mpg$test)   # 연비 합격 빈도표 생성
prop.table(table(mpg$test)) #연도 합격 비율로 나타내주는 것

library(ggplot2)  # ggplot2 로드

qplot(mpg$test)   # 연비 합격 빈도 막대 그래프 생성


## -------------------------------------------------------------------- ##
# total을 기준으로 A, B, C 등급 부여
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))

head(mpg, 20)     # 데이터 확인


table(mpg$grade)  # 등급 빈도표 생성
qplot(mpg$grade)  # 등급 빈도 막대 그래프 생성

# A, B, C, D 등급 부여
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))


## -------------------------------------------------------------------- ##
# 1.데이터 준비, 패키지 준비
mpg <- as.data.frame(ggplot2::mpg)  # 데이터 불러오기
library(dplyr)                      # dplyr 로드
library(ggplot2)                    # ggplot2 로드

# 2.데이터 파악
head(mpg)     # Raw 데이터 앞부분
tail(mpg)     # Raw 데이터 뒷부분
View(mpg)     # Raw 데이터 뷰어창에서 확인
dim(mpg)      # 차원
str(mpg)      # 속성
summary(mpg)  # 요약 통계량

# 3.변수명 수정
mpg <- rename(mpg, company = manufacturer)

# 4.파생변수 생성
mpg$total <- (mpg$cty + mpg$hwy)/2                   # 변수 조합
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")  # 조건문 활용

# 5.빈도 확인
table(mpg$test)  # 빈도표 출력
prop.table(table(mpg$test))
qplot(mpg$test)  # 막대 그래프 생성

##분석 도전
# midwest 를 데이터 프레임 형태로 불러오세요
mid_df = as.data.frame(ggplot2::midwest)
str(mid_df)
summary(mid_df)

## poptotal -> total, popasian -> asian
mid_df = rename(mid_df, total = poptotal, asian = popasian)

## total, asian 변수를 이용해 '전체 인구 대비 아시아 인구 백분율'
# 파생 변수를 만들고, 히스토그램을 만들어 분포도를 보시오
mid_df['percent'] = (mid_df['asian']/mid_df['total']) * 100
mid_df['percent']
#for (name in naem(mid_df)){
#  midwest$name
#  if(class(midwest[, name]))
#}

hist(mid_df$percent)

#아시아 인구 백분율 전체 평균, 평균 초과하면 large, 작으면 small
mean_val = apply(mid_df['percent'], 2,  mean)

mean_val2 = sum(mid_df$asian) / sum(mid_df$total) * 100
mean_val2

mid_df["check"] = ifelse(mid_df['percent']>mean_val, "large", "small")
mid_df["check"]

# large와 small에 해당하는 지역이 얼마나 되는지 빈도표와 
#빈도 막대 그래프 
table(mid_df["check"])
qplot(mid_df$check)

