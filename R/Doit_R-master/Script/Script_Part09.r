#### 09-1 ####

## -------------------------------------------------------------------- ##
install.packages("foreign")  # foreign 패키지 설치

library(foreign)             # SPSS 파일 로드
library(dplyr)               # 전처리
library(ggplot2)             # 시각화
library(readxl)              # 엑셀 파일 불러오기

# 데이터 불러오기
raw_welfare <- read.spss(file = "../Data/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)

# 복사본 만들기
welfare <- raw_welfare

head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

welfare <- rename(welfare,
                  sex = h10_g3,            # 성별
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인 상태
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직종 코드
                  code_region = h10_reg7)  # 지역 코드


#### 09-2 ####

## -------------------------------------------------------------------- ##
class(welfare$sex)
table(welfare$sex)

# 이상치 확인
table(welfare$sex)

# 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)

# 결측치 확인
table(is.na(welfare$sex))

# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)


## -------------------------------------------------------------------- ##
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

# 이상치 확인
summary(welfare$income)

# 이상치 결측 처리
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)

# 결측치 확인
table(is.na(welfare$income))


## -------------------------------------------------------------------- ##
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income

ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()


#### 09-3 ####

## -------------------------------------------------------------------- ##
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

# 이상치 확인
summary(welfare$birth)

# 결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))


## -------------------------------------------------------------------- ##
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)


## -------------------------------------------------------------------- ##
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))

head(age_income)

ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

### Quiz
## [20, 60] 응답이 0, 9999 나온 데이터의 비율
## raw_Welfare$p1002_8aq1에서 결측치는 "none"
## 0은 no
## 나머지는 yes로 설정한 후
## 20살에서 60살까지의 연령대에 대해 이에 대한 빈도수를 계산

doing_income <- welfare %>%
  select(income, age) %>%
  filter(age >= 20 & age <= 60) 
  
check_income <- ifelse(doing_income$income %in% c(NA, 0, 9999), "no", "yes")
table(check_income)

# Quiz income의 결측치를 0으로 평가할 때,
# 성별 income의 평균을 비교하라라



#### 09-4 ####

## -------------------------------------------------------------------- ##
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))

table(welfare$ageg)
qplot(welfare$ageg)


## -------------------------------------------------------------------- ##
ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

ageg_income

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()


## -------------------------------------------------------------------- ##
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

#Quiz
# 20대, 30대, 40대, 50대, 60대 이상으로 분류해보시오.
# 10대는 제거
welfare <- welfare %>% 
  mutate(ageg2 = ifelse(age>=60, "60",
                       ifelse(age>=50, "50",
                              ifelse(age>=40, "40",
                                     ifelse(age>=30, "30",
                                            ifelse(age>=20, "20", NA))))))
welfare$age10 <- (welfare$age %/% 10) * 10
table(welfare$age10)
welfare$age10 <- ifelse(welfare$age10 >= 60, 60, welfare$age10)

welfare %>% filter(!is.na(income)) %>%
  group_by(age10) %>%
  summarise(mean_income = mean(income))

grade_income <- welfare %>%
  group_by(ageg2) %>%
  summarise(grade_income = mean(income, na.rm = T))
  
ggplot(data = grade_income, aes(x = ageg2, y = grade_income)) + geom_col()

### 나이 및 성별 월급 차이 분석하기
### 나이 및 성별 월급 평균표를 작성하여 그래프로 표현해보자

welfare_color <- welfare %>% filter(!is.na(income)) %>% #income의 비 결측치를 필터링
  group_by(sex, age) %>% #age, sex로 그룹화
  summarise(mean_income = mean(income)) # income에 대하여 평균을 구하여 생성

ggplot(data = welfare_color, aes(x= age, y = mean_income), color = sex) + geom_line()

#### 09-5 ####

## -------------------------------------------------------------------- ##
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))

sex_income

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))


## -------------------------------------------------------------------- ##
# 성별 연령별 월급 평균표 만들기
sex_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))

head(sex_age)

# 그래프 만들기
ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line()


#### 09-6 ####

## -------------------------------------------------------------------- ##
class(welfare$code_job)
table(welfare$code_job)

library(readxl)
list_job <- read_excel("../Data/Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)
dim(list_job)

welfare <- left_join(welfare, list_job, id = "code_job")

table(welfare$code_job, useNA="ifany") # 각 값에 대한 갯수 측정
table(is.na(welfare$code_job), useNA="ifany")

welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)


## -------------------------------------------------------------------- ##
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

head(job_income)

top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)

top10

ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()


# 하위 10위 추출
bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)

bottom10

# 그래프 만들기
ggplot(data = bottom10, aes(x = reorder(job, -mean_income), 
                            y = mean_income)) +
  geom_col() + 
  coord_flip() + 
  ylim(0, 850)


#### 09-7 ####

## -------------------------------------------------------------------- ##
# 남성 직업 빈도 상위 10개 추출
job_male <- welfare %>%
  filter(!is.na(job) & sex == "male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_male


# 여성 직업 빈도 상위 10개 추출
job_female <- welfare %>%
  filter(!is.na(job) & sex == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_female

# 남성 직업 빈도 상위 10개 직업
ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

# 여성 직업 빈도 상위 10개 직업
ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

## Quiz - 연령 등급에서 노년층을 제외하고 
###
## 노년층을 제외한 남성들의 직업 빈도 상위 10개 추출
job_male_no_old <- welfare %>%
  filter(!is.na(job) & sex == "male" & ageg != "old") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_male_no_old

job_female_no_old <- welfare %>%
  filter(!is.na(job) & sex == "female" & ageg != "old") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_female_no_old

# 직업 빈도 상위 10개에 대한 남녀 비율
# install.packages("tidyr")
library(tidyr)
job_rate <- welfare %>%
  filter(!is.na(job)) %>%
  group_by(job, sex) %>%
  summarise(n = n()) %>%
  spread(sex, n) %>%  # 피봇(long data를 wide data로 변환) 작업
  mutate(person = female + male) %>%
  mutate(female = female/person, male = male/person) %>%
  arrange(desc(person)) %>%
  head(10)

job_rate

#월급 상위 30개 직업에 대한 남녀 비율
salary_rate2 <- welfare %>%
  filter((!is.na(job))) %>%
  group_by(job) %>%
  summarise(mean_sal = mean(income, na.rm=T)) %>%
  arrange(desc(mean_sal)) %>%
  head(30)

salary_rate2

salary_rate <- welfare %>%
  filter((!is.na(job)) & (!is.na(income)) &(!is.na(sex))) %>%
  group_by(job, sex) %>%
  summarise(n = n()) %>%
  spread(sex, n)

salary_rate$female <- ifelse(is.na(salary_rate$female), 0, salary_rate$female)
salary_rate$male <- ifelse(is.na(salary_rate$male), 0, salary_rate$male)

salary_rate <- salary_rate %>%
  mutate(person = female + male) %>%
  mutate(female = female/person, male = male/person)

salary_rate

salary_rate3 <- left_join(salary_rate2, salary_rate, id = "job")
salary_rate3
#### 09-8 ####

## -------------------------------------------------------------------- ##
class(welfare$religion)
table(welfare$religion)

# 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")
table(welfare$religion)
qplot(welfare$religion)


## -------------------------------------------------------------------- ##
class(welfare$marriage)
table(welfare$marriage)

# 이혼 여부 변수 만들기
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3, "divorce", NA))

table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)


## -------------------------------------------------------------------- ##
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))

religion_marriage

religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(religion, group_marriage) %>% 
  group_by(religion) %>% 
  mutate(pct = round(n/sum(n)*100, 1))

# 이혼 추출
divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>% 
  select(religion, pct)

divorce

ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()

## 연령대 및 종교 유무에 따른 이혼율 분석



## -------------------------------------------------------------------- ##
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))

ageg_marriage

ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(ageg, group_marriage) %>% 
  group_by(ageg) %>% 
  mutate(pct = round(n/sum(n)*100, 1))

# 초년 제외, 이혼 추출
ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "young" & group_marriage == "divorce") %>% 
  select(ageg, pct)

ageg_divorce

# 그래프 만들기
ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) + geom_col()


## -------------------------------------------------------------------- ##
# 연령대, 종교유무, 결혼상태별 비율표 만들기
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  group_by(ageg, religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))

ageg_religion_marriage

ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  count(ageg, religion, group_marriage) %>%
  group_by(ageg, religion) %>% 
  mutate(pct = round(n/sum(n)*100, 1))

# 연령대 및 종교 유무별 이혼율 표 만들기
df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>% 
  select(ageg, religion, pct)

df_divorce

ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion )) +
  geom_col(position = "dodge")


#### 09-9 ####

## -------------------------------------------------------------------- ##
class(welfare$code_region)
table(welfare$code_region)

# 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))
list_region

# 지역명 변수 추가 
welfare <- left_join(welfare, list_region, id = "code_region")

welfare %>%
  select(code_region, region) %>%
  head


## -------------------------------------------------------------------- ##

region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 2))

head(region_ageg)

region_ageg <- welfare %>%
  count(region, ageg) %>%
  group_by(region) %>% 
  mutate(pct = round(n/sum(n)*100, 2))

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()


## -------------------------------------------------------------------- ##
# 노년층 비율 내림차순 정렬
list_order_old <- region_ageg %>%
  filter(ageg == "old") %>%
  arrange(pct)

list_order_old

# 지역명 순서 변수 만들기
order <- list_order_old$region
order

ggplot(data = region_ageg, aes(x = region,  y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)


class(region_ageg$ageg)
levels(region_ageg$ageg)

region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old", "middle", "young"))
class(region_ageg$ageg)
levels(region_ageg$ageg)

ggplot(data = region_ageg, aes(x = region,  y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)

# Quiz : 직업종별 지역분포를 작성해보자
# 각 직업 코드를 첫 digit을 직업종으로 하자 
# 첫 digit을 의미하는 것은 직업 코드는 01xx ~ 10xx로 하는데 01 ~10으로 바꾸자는 이야기
# 1~10까지의 직업종에 대해 지역별 비율을 구한다
# 7대 지역을 x축으로, 직업종의 비율을 y축으로 bar 차트를 작성한다
welfare$code_job2 <- welfare$code_job %/% 100
welfare$code_job2 <- factor(welfare$code_job2)

region_rate <- welfare %>%
  filter(!is.na(code_job2)) %>%
  group_by(region)


ggplot(data = region_rate, aes(x = region, y = code_job2, fill = code_job2, na.rm=T)) + 
  geom_col()
