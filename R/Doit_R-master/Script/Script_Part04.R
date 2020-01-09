#### 04-2 ####

## ---------------------------------------------------------------------- ##

english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
english

math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
math

# english, math로 데이터 프레임 생성해서 df_midterm에 할당
df_midterm <- data.frame(english, math)
df_midterm
df_midterm[2]
df_midterm["math"]
df_midterm$math
df_midterm[1:2]
### - 행, 열 구분 없이 색인하면, 열을 가져온다
## - 모든 것을 선택하는데, :를 표시해서는 안된다
## - 연속 색인에서 끝 첨자는 포함되어 보여진다


class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm
df_midterm[4] <- class
names(df_midterm)
names(df_midterm)[4] <- "class2"
names(df_midterm)[3:4] <- c("class1", "class2")
df_midterm

mean(df_midterm$english)  # df_midterm의 english로 평균 산출
mean(df_midterm$math)     # df_midterm의 math로 평균 산술
mean(df_midterm[1:4]) # 이거는 사용이 불가능하므로 apply를 사용해야 한다
apply(df_midterm, 2, mean)

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

## 이 밑에 꺼 열 이름이 이상하게 바뀜
df_midterm <- data.frame(english <- c(90, 80, 60, 70),
                         math <- c(50, 60, 100, 20),
                         class <- c(1, 1, 2, 2))
df_midterm

df<- df_midterm

df$math
df[, 2]
df[, "math"]
df[2]
df["math"]
df[5, ] <- c(50, 60, 1)

## 순서와 이름에 의한 색인을 섞어 쓸 수 있다
df[1:3, c('math', 'english')]
df[1:3, c(2, 1)]
df[2, 3]
df[c(1,3, 4), ]
df[c(1, 3, 4), c("english", "class")]

#혼자서 해보기
fruit = data.frame(fruit = c("사과", "딸기", "수박"),
                   price = c(1800, 1500, 3000),
                   amount = c(24, 38, 13)
                   )

fruit
apply(fruit[2:3], 2, mean)
#### 04-3 ####

## -------------------------------------------------------------------- ##
install.packages("readxl")
library(readxl)

getwd()
df_exam <- read_excel("../Data/excel_exam.xlsx")  # 엑셀 파일을 불러와서 df_exam에 할당
df_exam                                   # 출력

mean(df_exam$english)
mean(df_exam$science)

#1. math와 science 만을 선택하는 4가지 방법을 작성
df_exam[c("math", "science")]
df_exam[,c("math", "science")]
df_exam[, c(3, 5)]
df_exam[c(3, 5)]
# 2. math, english, science의 점수 합을 값으로 갖는 sum이라는 열을 생성
df_exam["sum"] = df_exam['math'] + df_exam['english'] + df_exam['science']

#3. sum 이라는 열의 값이 150이상 180 이하인 행만 선택
cond <- 180>=df_exam["sum"] & 150<=df_exam["sum"]
df_exam[cond,]
# 4. 각 반별로 science의 최고점과 최저점인 학생 id를 구하라
classes <- unique(df_exam$class)
for(cls in classes){
  tmp <- df_exam[df_exam$class == cls, c(1,5)]
  tmp <- as.data.frame(tmp)
  min <- min(tmp$science)
  max <- max(tmp$science)
  print(as.character(cls))
  print(tmp[tmp$science == min, 'id'])
  print(tmp[tmp$science == max, 'id'])
}


df_exam_novar <- read_excel("../Data/excel_exam_novar.xlsx")
df_exam_novar

df_exam_novar <- read_excel("../Data/excel_exam_novar.xlsx", col_names = F)
df_exam_novar

# - df_exame_novar에 아래와 같은 컬럼명을 적용하라
names(df_exam_novar) <- c("id", "class", "math", "eng", "sci")
names(df_exam_novar)

# 엑셀 파일의 세 번째 시트에 있는 데이터 불러오기
df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet


## -------------------------------------------------------------------- ##
df_csv_exam <- read.csv("../Data/csv_exam.csv")
df_csv_exam

df_csv_exam <- read.csv("../Data/csv_exam.csv", stringsAsFactors = F)


## -------------------------------------------------------------------- ##
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

write.csv(df_midterm, file = "../Data/df_midterm.csv")


## -------------------------------------------------------------------- ##
save(df_midterm, file = "../Data/df_midterm.rda")

rm(df_midterm)

load("../Data/df_midterm.rda")


## -------------------------------------------------------------------- ##
# 1.변수 만들기, 데이터 프레임 만들기
english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
data.frame(english, math)     # 데이터 프레임 생성

# 2. 외부 데이터 이용하기

# 엑셀 파일
library(readxl)                                 # readxl 패키지 로드
df_exam <- read_excel("excel_exam.xlsx")        # 엑셀 파일 불러오기

# CSV 파일
df_csv_exam <- read.csv("csv_exam.csv")         # CSV 파일 불러오기
write.csv(df_midterm, file = "df_midterm.csv")  # CSV 파일로 저장하기

# Rda 파일
load("df_midterm.rda")                          # Rda 파일 불러오기
save(df_midterm, file = "df_midterm.rda")       # Rda 파일로 저장하기

