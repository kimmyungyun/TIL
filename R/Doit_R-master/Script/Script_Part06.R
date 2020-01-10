#### 06-2 ####

## -------------------------------------------------------------------- ##
library(dplyr)
exam <- read.csv("Data/csv_exam.csv")
exam

# exam에서 class가 1인 경우만 추출하여 출력
dplyr::filter(exam, class == 1) #원래는 이렇게 사용해야 하는데 아래처럼도 사용이 가능 
exam %>% filter(class == 1)  
exam[exam$class == 1,]
exam %>% filter(class == 1) %>% filter(math == 50)
# 11번째 줄로 해결이 가능하지만, dplyr 패키지의 함수가 더 빨라서 filter 함수를 쓰는게 더 이득


# 2반인 경우만 추출
#밑의 두 함수의 차이는 인덱스가 유지 되냐 안되냐의 차이가 있다
exam %>% filter(class == 2) # row index 초기화 or 보존이 선택이 가능
exam[exam$class == 2, ] # row index 보존만 가능

# 1반이 아닌 경우
exam %>% filter(class != 1)

# 3반이 아닌 경우
exam %>% filter(class != 3)

# 1반과 3반이 아닌 경우
exam %>% filter(class != 3 & class != 1)
exam %>% filter(!(class %in% c(3, 1)))

# 1반 또는 3반인 경우
exam %>% filter(class == 3 | class == 1)
exam %>% filter((class %in% c(1, 3)))


## -------------------------------------------------------------------- ##
# 수학 점수가 50점을 초과한 경우
math50 <- exam %>% filter(math > 50)

math50 <- exam[exam$math > 50, ]
rownames(math50) <- 1:dim(math50)[1]

# 수학 점수가 50점 미만인 경우
exam %>% filter(math < 50)

# 영어 점수가 80점 이상인 경우
exam %>% filter(english >= 80)

# 영어 점수가 80점 이하인 경우
exam %>% filter(english <= 80)

#####
## [참고] 이제 이것을 함수로 만들어보자.
## - 조건문장을 r code로 변환하는 것이 중요하다.
parse(text="class != 3")
eval(parse(text="2+3"))
eval(parse(text="exam$class"))
a <- eval(parse(text="2+3"))
a

condVec <- c(
  "class != 3",
  "science >= 50 & science <= 80"
)
paste("subdata %>% filter(", condVec[1], ")", sep="")
class(max(exam["english"]))

findValue <- function(data, condVect, subject, ft, search){
  subdata <- data
  for(cond in condVect){
    rCode <- paste("subdata %>% filter(", cond, ")", sep="")
    subdata <- eval(parse(text=rCode))
  }
  subj_stat <- ft(subdata[subject])
  # subdata <- subdata[subdata[,subject]==subj_stat, search]
  rCode <- paste("subdata %>% filter(", subject, " == subj_stat)", sep="")
  subdata <- eval(parse(text=rCode))
  result <- subdata[search]
  
  return(result)
}
exam["english"]
filter("class != 3")
findValue(exam, condVec, "english", max, "id")


findId <- function(data, ifexpVector, subject, ft, search){
  subdata <- data
  for(ifexp in ifexpVector){
    rCode <- paste("subdata <- subdata %>% filter(", ifexp, ")", sep="")
    eval(parse(text=rCode))
  }
  
  rCode <- paste(ft, "(subdata$", subject, ")", sep="")
  stat_sub <- eval(parse(text=rCode))
  rCode <- paste("subdata %>% filter(", subject, " == stat_sub)", sep="")
  subdata <- eval(parse(text=rCode))
  rCode <- paste("subdata$", search, sep="")
  result <- eval(parse(text=rCode))
  
  return(result)
}
ifexpVector = c(
  "science >= 50 & science <= 80",
  "class != 3"
)

findId(exam, ifexpVector, "english", "max", "id")

#########


## 퀴즈
df = as.data.frame(ggplot2::mpg)
less_df <- mean((df %>% filter(displ <= 4))$hwy)
more_df <- mean((df %>% filter(displ >= 5))$hwy)

audi <- mean((df %>% filter(manufacturer == "audi"))$cty)
toyota <- mean((df %>% filter(manufacturer == "toyota"))$cty)

car <- mean((df %>% filter(manufacturer == "ford" | manufacturer == "honda" | manufacturer == "chevrolet"))$hwy)
car <- mean((df %>% filter(manufacturer %in% c("ford", "honda", "chevrolet")))$hwy)

## -------------------------------------------------------------------- ##
# 1반이면서 수학 점수가 50점 이상인 경우
exam %>% filter(class == 1 & math >= 50)
exam %>% filter(class == 1) %>% filter(math >= 50)

# 2반이면서 영어 점수가 80점 이상인 경우
exam %>% filter(class == 2 & english >= 80)
exam[exam$class == 2 & exam$english >= 80,]

## 3개 과목 평균 점수가 75점 이상
exam %>% filter(math + english + science >= (75*3))
exam[rowSums(exam[, 3:5]) >= (75 * 3),]

## -------------------------------------------------------------------- ##
# 수학 점수가 90점 이상이거나 영어 점수가 90점 이상인 경우
exam %>% filter(math >= 90 | english >= 90)

# 영어 점수가 90점 미만이거나 과학점수가 50점 미만인 경우
exam %>% filter(english < 90 | science < 50)


## -------------------------------------------------------------------- ##
# 1, 3, 5 반에 해당되면 추출
exam %>% filter(class == 1 | class == 3 | class == 5)

exam %>% filter(class %in% c(1,3,5))


## -------------------------------------------------------------------- ##
class1 <- exam %>% filter(class == 1)  # class가 1인 행 추출, class1에 할당
class2 <- exam %>% filter(class == 2)  # class가 2인 행 추출, class2에 할당

mean(class1$math)                      # 1반 수학 점수 평균 구하기
mean(class2$math)                      # 2반 수학 점수 평균 구하기


#### 06-3 ####

## -------------------------------------------------------------------- ##
exam %>% select(math)                  # math 추출
exam %>% select(english)               # english 추출
exam %>% select(class, math, english)  # class, math, english 변수 추출
exam %>% select(-math)                 # math 제외
exam %>% select(-math, -english)       # math, english 제외
exam %>% select(c('class', 'math'))
exam %>% select(-c(4, 3)) # 순서에 의한 색인만 가능
exam[c(3, 4)]


## -------------------------------------------------------------------- ##
# class가 1인 행만 추출한 다음 english 추출
exam %>% filter(class == 1) %>% select(english)

exam %>%
  filter(class == 1) %>%  # class가 1인 행 추출
  select(english)         # english 추출

exam %>% 
  select(id, math) %>%    # id, math 추출
  head                    # 앞부분 6행까지 추출

exam %>% 
  select(id, math) %>%  # id, math 추출
  head(10)              # 앞부분 10행까지 추출

## QUiz
#mpg 데이터에서 class와 cty를 추출하여 새로운 데이터를 만든다
new_mpg <- df %>% select(c('class', 'cty'))
names(new_mpg)

# 추출한 데이터를 이용해서 class가 'suv'인 것과 'compact'인 것 중 cty가 높은 것을 알아보시오
new_mpg  %>% filter(class %in% c('suv', 'compact')) %>% 
  group_by(class) %>% summarise(mean_cty = mean(cty))

#### 06-4 ####

## -------------------------------------------------------------------- ##
exam %>% arrange(math)         # math 오름차순 정렬
exam %>% arrange(desc(math))   # math 내림차순 정렬
exam %>% arrange(class, math)  # class 및 math 오름차순 정렬
a <- exam %>% arrange(class, desc(math))
b <- exam %>% arrange(desc(math)) %>% arrange(class)
#위의 a는 math로 정렬하고, class로 정렬하는 것과 같기 때문에 아래랑 같다
all(a == b) #all은 모두다 같아야 하고
any(a == b) # any는 하나만 같아도 된다

sort(exam$math)
math_idx <- sort(exam$math)
math_idx2 <- order(exam$math)

#Quiz
# audi에서 생산한 자동차 중에, 어떤 자동차 모델의 hwy가 높은가
#groupby를 안쓸 경우
audi <- df %>% filter(manufacturer == "audi") %>%
  select(model, hwy)

audimodel <- unique(audi$model)
for(m in audimodel){
  print(mean(audi[audi$model==m,  ]$hwy))
}

df %>% filter(manufacturer == "audi") %>%
  group_by(model) %>%
  summarise(mh = mean(hwy)) %>%
  arrange(desc(mh))


#### 06-5 ####

## -------------------------------------------------------------------- ##
exam %>%
  mutate(total = math + english + science) %>%  # 총합 변수 추가
  head                                          # 일부 추출

exam %>%
  mutate(total = math + english + science,         # 총합 변수 추가
         mean = (math + english + science)/3) %>%  # 총평균 변수 추가
  head                                             # 일부 추출

exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head

exam %>%
  mutate(total = math + english + science) %>%  # 총합 변수 추가
  arrange(total) %>%                            # 총합 변수 기준 정렬
  head                                          # 일부 추출

### mpg 데이터 복사본을 만들고, hwy, cty를 합쳐서 새로운 합산
## 연비 변수를 만들어라
new_df <- as.data.frame(ggplot2::mpg)
new_df <- new_df %>% mutate(sum_year = cty+hwy)
new_df <- new_df %>% mutate(avg_year = sum_year/2)
new_df %>% select(model,avg_year) %>% arrange(desc(avg_year)) %>% head(3)


#### 06-6 ####

## -------------------------------------------------------------------- ##
exam %>% summarise(mean_math = mean(math))  # math 평균 산출

exam %>% 
  group_by(class) %>%                   # class별로 분리
  summarise(mean_math = mean(math))     # math 평균 산출

exam %>% 
  group_by(class) %>%                   # class별로 분리
  summarise(mean_math = mean(math),     # math 평균
            sum_math = sum(math),       # math 합계
            median_math = median(math), # math 중앙값
            n = n())                    # 학생 수

mpg <- ggplot2::mpg
mpg %>%
  group_by(manufacturer, drv) %>%       # 회사별, 구동방식별 분리
  summarise(mean_cty = mean(cty)) %>%   # cty 평균 산출
  head(10)                              # 일부 출력



## -------------------------------------------------------------------- ##
mpg %>%
  group_by(manufacturer) %>%           # 회사별로 분리
  filter(class == "suv") %>%           # suv 추출
  mutate(tot = (cty+hwy)/2) %>%        # 통합 연비 변수 생성
  summarise(mean_tot = mean(tot)) %>%  # 통합 연비 평균 산출
  arrange(desc(mean_tot)) %>%          # 내림차순 정렬
  head(5)                              # 1~5위까지 출력

mpg %>% filter(class == "suv") %>% 
  select(manufacturer, cty, hwy) %>%
  group_by(manufacturer) %>%
  mutate(tot = (cty+hwy)/2) %>%
  summarise(mean_tot = mean(tot)) %>%
  arrange(desc(mean_tot)) %>%
  head(5)

## QUiz
# class 별 cty 평균을 구해보세요
mpg %>% select(class, cty) %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty))

# cty 평균이 높은 순으로 정렬해 출력
mpg %>% select(class, cty) %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty))

# hwy 평균이 가장 높은 회사세곳을 출력
mpg %>% select(manufacturer, hwy) %>%
  group_by(manufacturer) %>%
  summarise(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy)) %>%
  head(3)

#어떤 회사에서 "compact" 차종을 많이 생산하는지 확인하기 위해
# 회사별 차종 수를 정렬하시오
mpg %>% select(manufacturer, class) %>%
  group_by(manufacturer) %>%
  filter(class == "compact") %>%
  summarise(count_class = n()) %>%
  arrange(desc(count_class))
#### 06-7 ####

## -------------------------------------------------------------------- ##
# 중간고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5),           
                    midterm = c(60, 80, 70, 90, 85))

# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5),           
                    final = c(70, 83, 65, 95, 80))

test1  # test1 출력
test2  # test2 출력

total <- left_join(test1, test2, by = "id")  # id 기준으로 합쳐서 total에 할당
total                                        # total 출력


## -------------------------------------------------------------------- ##
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")
exam_new


## -------------------------------------------------------------------- ##
# 학생 1~5번 시험 데이터 생성
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))

# 학생 6~10번 시험 데이터 생성
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

group_a  # group_a 출력
group_b  # group_b 출력

group_all <- bind_rows(group_a, group_b)  # 데이터 합쳐서 group_all에 할당
group_all                                 # group_all 출력

rbind(group_a, group_b)

## fuel 데이터를 만들고, mpg데이터에 price_fl 변수를 추가 하세요
mpg <- as.data.frame(ggplot2::mpg)
fuel <- data.frame(fl = c('c', 'd', 'e', 'p', 'r'),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22))
new_mpg <- left_join(mpg, fuel, class='fl')
new_mpg %>% select(model, fl, price_fl) %>%
  head(5)
## -------------------------------------------------------------------- ##
## 1.조건에 맞는 데이터만 추출하기
exam %>% filter(english >= 80)

# 여러 조건 동시 충족
exam %>% filter(class == 1 & math >= 50)

# 여러 조건 중 하나 이상 충족
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(class %in% c(1,3,5))


## 2.필요한 변수만 추출하기
exam %>% select(math)
exam %>% select(class, math, english)

## 3.함수 조합하기, 일부만 출력하기
exam %>%
  select(id, math) %>%
  head(10)

## 4.순서대로 정렬하기
exam %>% arrange(math)         # 오름차순 정렬
exam %>% arrange(desc(math))   # 내림차순 정렬
exam %>% arrange(class, math)  # 여러 변수 기준 오름차순 정렬

## 5.파생변수 추가하기
exam %>% mutate(total = math + english + science)

# 여러 파생변수 한 번에 추가하기
exam %>%
  mutate(total = math + english + science,
         mean = (math + english + science)/3)

# mutate()에 ifelse() 적용하기
exam %>% mutate(test = ifelse(science >= 60, "pass", "fail"))

# 추가한 변수를 dplyr 코드에 바로 활용하기
exam %>%
  mutate(total = math + english + science) %>%
  arrange(total)


## 6.집단별로 요약하기
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))

# 각 집단별로 다시 집단 나누기
mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty))


## 7.데이터 합치기
# 가로로 합치기
total <- left_join(test1, test2, by = "id")

# 세로로 합치기
group_all <- bind_rows(group_a, group_b)

