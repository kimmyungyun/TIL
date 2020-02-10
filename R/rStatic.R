######## 교재: http://r4pda.co.kr/pdf/r4pda_2014_03_02.pdf

## 대표값과 산포(변동성)
x <- runif(50, 1, 100)#랜덤하게 50개의 숫자 생성, 최소 = 1, 최댓값- 100
x
hist(x)
y <- c(x, 1000)
y
   mean(x)
mean(y)
median(x)
median(y)
sd(x)
sd(y)
range(x)
range(y)
IQR(x)
IQR(y)

boxplot(x)
boxplot(y)

install.packages('fBasics')
library(fBasics)
skewness(x) #왜도, +-1 정도까지가 굿, +-3정도면은 나쁘지 않음 그걸 넘으면 이상치를 제거 해야함
skewness(y)

pexp(500, 0.002) #lamda is rate
# - 추가학습: skewness와 boxcox 변환


## 2.0 다양한 분포함수
# binorm : 이항분포
# f: f분포
# geom: 기하분포
# hyper: 초기하분포
# nbinorm: 음이항분포
# pois: 프와송 분포
# t: t분포
# unif: 균등분포
# chisq 카이제곱분포
set.seed(123)

## 분포함수 : norm에 대해
# dnorm(x, mean = 0, sd = 1, log = FALSE): density
# pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE): probablilty
## - lower.tail = T: return P(x<q)    |   lower.tail = F: return P(x>q)
## - log.p = F: return Prob           |   log.p = T: return log(Prob)
# qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE): quantile
# rnorm(n, mean = 0, sd = 1): random generation n samples

# 평균이 0이고 표준편차가 1인 정규분포에서 100개의 난수 생성.
rnorm(100, 0, 1)

plot(density(rnorm(1000000, 9, 10)))

# 평균이 0이고 표준편차가 1인 정규분포로부터:
pnorm(1) #시그마가 1인 것 까지의 pdf
pnorm(1, lower.tail = F) # 시그마 1부터 오른쪽 끝까지를 구한다 위에꺼는 왼쪽부터 시그마 1까지

pnorm(1, log.p = T)
exp(pnorm(1, log.p = T))

pnorm(1) - pnorm(-1)
pnorm(1.67) - pnorm(-1.67)
pnorm(1.96) - pnorm(-1.96)

pnorm(2)
pnorm(2) - pnorm(-2)

pnorm(3) - pnorm(-3)
pnorm(6) - pnorm(-6)

##- 소수점 k 자리까지의 정밀도를 1  ~ 22까지 표현가능하다. 기본값은 7.
specify_decimal <- function(x, k) trimws(format(round(x, k), nsmall=k))
specify_decimal(pnorm(6) - pnorm(-6), 10)


# density로 부터 두 값에 대한 분포확률(우도) 예측하기.
dnorm(1.1, 1.15, 1)*dnorm(1.2, 1.15, 1)
# 평균 0.9, 분산 1인 정규분포에서 1.1과 1.2가 관측될 확률
dnorm(1.1, 0.9, 1)*dnorm(1.2, 0.9, 1) 


# 누적 확률이 0.9가 되는 x값을 찾아라.
q = qnorm(.9, 9, 10)
pnorm(q, 9, 10)
z = (qnorm(.9, 9, 10) - 9)/10
z
qnorm(.9, 0, 1)

(cps <- 1:9 / 10)
qs = qnorm(cps, 9, 10)
zs = (qs - 9)/10
pnorm(zs, 0, 1)

# N(9, 10) 분포에서 신뢰구간이 0.9가 되는 x를 찾아라.
tmp <- qnorm(0.05, 9, 10)
pnorm(9+9-tmp, 9, 10)
q = 18-tmp
z = (q-9)/10
pnorm(z, 0, 1)


## 프와송 분포: f(n, lambda)의 이해
# - 단위시간(단위공간)당 사건 발생 건수가 lambda일 때,
# - 단위시간 내, n번의 사건이 발생할 확률
dpois(1, 1.5) + ppois(0, 1.5)
ppois(1, 1.5)
ppois(3, 1.5)
qpois(0.9, 1.5)

dpois(3, 3)
dpois(3, 1)


# 단위시간당 1건 발생확률에서 0 ~ 5건까지 발생확률에 대한 누적합
sum = 0
for (i in 0:5){
  sum = sum + dpois(i, 1)
}
sum

# - 누적분포함수로 구하면:
ppois(5, 1)


## 이항분포
# - tv리모콘 문제: 채널 50에서 6번 눌렀을 때 채널 50.
# - 6C3 (1/2)^6
6*5*4/(3*2)*(0.5^6)
dbinom(3, 6, 0.5)


## 2.1 기초통계량
mean(1:10)
sd(1:10)
var(1:10)
# - 분산의 정의로부터: Var(x) = 1/(N-1) * sum[(x - mean(x))^2]
sum( (1:10 - mean(1:10))^2 ) / (10-1)


## 2.2 summay
# - 알고 보면 쉽게:
x <- 1:10
summary(x)
# - 알고 보면 쉽지 않다:
str(boxplot(x))
boxplot(x)$stats # data로부터 

# - 왜 다를까?
c(min(x), quantile(x, 1/4), median(x), quantile(x, 3/4), max(x))

IQR(x)
quantile(x, c(1/4, 3/4))
qt <- quantile(x, c(1/4, 3/4), names = F)
qt[2] - qt[1]


## 2.3 명목형 변수에 대한 최빈값(mode)
x <- factor(c("a", "b", "c", "c", "c", "d", "d"))
x
table(x) # named vecotr
str(table(x))
which.max(table(x))
str(which.max(table(x))) # named vector: https://rpubs.com/sowmya21jan/338762

names(table(x))[which.max(table(x))]

summary(x)
str(summary(x))


### 3.1 표본추출 
## - 3.1 Random Sampling
sample(1:10, 5)
sample(1:10, replace = T)
sample(1:10, replace = T, prob=1:10)

# for using shuffling, permutation
(rsd <- sample(1:10))
seq(1, 10, 3)
rsd[seq(1, 10, 3)]


### 3.2 Stratifed Random Sampling
install.packages("sampling")
library(sampling)
# - Simple Random Sampling Without Replacement: srswor
x <- strata(iris, c("Species"), size=c(3, 3, 3), method ="srswor")
x
# - strata()가 반환값에서 데이터를 얻으려면 getdata()를 사용
getdata(iris, x)
getdata(iris, x)[names(iris)]

# - simple random sampling with replacement (srswr)
str(iris$Species)
levels(iris$Species)
x <- strata(iris, c("Species"), size=c(3, 1, 1), method ="srswr")
getdata(iris, x)[names(iris)]

# - 다중 층화 추출:
iris$Species2 <- rep(1:2, 75)

strata(c("Species", "Species2"), size =c(1, 1, 1, 1, 1, 1),
       method ="srswr", data = iris)


# - 각 층별 동일한 비율의 표본을 추출. with doBy::sampleBy()
install.packages("doBy")
library(doBy)
sampleBy( ~ Species, frac=.06, data = iris)
smps <- as.data.frame(sampleBy( ~ Species, frac=.06, data = iris))
row.names(smps) <- NULL


### 3.3 계통 추출(Systematic Sampling)
# - 계통 추출은 모집단의 임의 위치에서 시작해 매 k 번째 항목을 표본으로 추출하는 방법이다. 
# - sampleBy()에 systematic=TRUE 옵션을 주어 data.frame을 계통 추출을 할 수 있다.

x <- data.frame(k =1:10)
x

library(doBy)
sampleBy(~1, frac =.3 , data =x, systematic = TRUE)
# - formula's right-hand side item 그룹별로 frac 비율로 계통 샘플링.
# - item은 그룹 지정 항목이므로, 범주형 변수 또는 상수이어야 한다.
# -- 위의 예서 1을 쓰든 5를 쓰든 상수로서 아무 의미가 없다.

sampleBy(~ Species, frac=0.1, data=iris, systematic = TRUE)
sampleBy(~ Species, frac=0.1, data=iris)


## 4. 분할표(Contingency Table)
# - 명목형(Categorical) 또는 순서형(Ordinal) 자료의 도수를 표 형태로 기록한 것

### 4.1 분할표 작성: table()
# - 빈도 데이터가 없는 경우 table
table(c("a", "b", "b", "b", "c", "c", "d"))

# - **빈도 데이터**가 존재하는 경우 xtabs
d <- data.frame(x=c("1", "2", "2", "1"),
                y=c("A", "B", "A", "B"),
                num=c(3, 5, 8, 7))
d

xt <- xtabs(num ~ x + y, data =d)
xt

d2 <- data.frame(x=c("A", "A", "A", "B", "B"),
                 result =c(3, 2, 4, 7, 6))
d2
xtabs(~x, d2)
table(d2$x)
xtabs(result~x, d2)

# - **분할표**에 대한 주변합 계산 margin.table()
xt
margin.table(xt, 1) # 행이 1
margin.table(xt, 2)
margin.table(xt)

# - 분할표에 대한 비율 계산 prop.table()
xt
prop.table(xt, 1)
prop.table(xt, 2)
prop.table(xt)

## 추가학습: CrossTable, confusionmatrix
## - https://rfriend.tistory.com/120
## - https://thebook.io/006723/ch09/03/01-1/

library(gmodels)
CrossTable(d$x, d$y)



### 4.2 독립성 검정(Independence Test)
# - https://en.wikipedia.org/wiki/Pearson%27s_chi-squared_test
library( MASS )

## University of Adelaide에서 237명의 학생을 대상으로 설문조사한 결과
## - Sex 성별 “Male”, “Female”
## - Exer 운동의 빈도 “Freq”, “Some”, “None”
## - Smoke 흡연의 정도 “Heavy”, “Regul”, “Occas”, “Never”
data( survey )
survey
dim(survey)
str( survey )
head(survey)
summary(survey)

# - 학생들의 성별에 따른 운동량에 차이가 있는지 독립성 검정을 해보자.
# - 기대도수가 5보다 작으면 유의성이 떨어진다.
# - 이때는 데이터를 더 모아서 작업해야 한다.
head( survey[c("Sex", "Exer")])
tabs <- xtabs( ~ Sex + Exer , data = survey)
tabs
chisq.test(tabs)
# - df: degree of freedom: (2 -1)*(3-1)
# 샘플 수가 작다면 chisq.test()는 경고 메시지를 내보낸다. 


### 4.3 피셔의 정확 검정(Fisher’s Exact Test) => 시간관계상 pass.
# survey 데이터에서 손글씨를 어느 손으로 쓰는지와 박수를 칠 때 어느 손이 위로 가는지간의 분할표를 xtab()으로 구하고, 독립성 검증을 수행하면 다음과같이 경고 메시지가 나온다.
summary(survey)
tabs <- xtabs(~ W.Hnd + Clap , data = survey)
tabs
chisq.test(tabs)

# 샘플 수가 작다는 기준은 특정 짓기 어렵지만 기대빈도가 5보다 작은 셀의 비율이 전체의 25% 이상인 경우 등이 이에 해당한다. 이런 경우에는 피셔의 정확 검정을 사용한다. 
# https://dermabae.tistory.com/175
fisher.test( xtabs (~ W.Hnd + Clap , data = survey ))

# 더 정확한 검정을 위해:
library(dplyr)
survey <- MASS::survey
survey_subClapLeft <- survey %>%
  filter(Clap != 'Left')
survey_subClapNone <- survey %>%
  filter(Clap != 'Neither')
survey_subClapRight <- survey %>%
  filter(Clap != 'Right')
tabs_subClapLeft <- xtabs(~ W.Hnd + Clap , data = survey_subClapLeft)
tabs_subClapNone <- xtabs(~ W.Hnd + Clap , data = survey_subClapNone)
tabs_subClapRight <- xtabs(~ W.Hnd + Clap , data = survey_subClapRight)
fisher.test(tabs_subClapLeft)

str(tabs)
tabdf <- as.data.frame(tabs)
tabdf


### 4.4 맥니마 검정(McNemar Test)
# - 벌금을 부과하기 시작한 후 안전 벨트 착용자의 수, 유세를 하고난 뒤 지지율의 변화와 같이 응답자의 성향이 사건 전후에 어떻게 달라지는지를 알아보는 경우 맥니마 검정을 수행한다. 이때, 데이터의 범주는 binary이어야 한다.
# - 짝지은 명목형 데이터에서 Column과 Row의 marginal probability가 같은지를 검정한다.
# - 데이터는 보통 아래와 같이 구성된다.
#                   시행후
# 시행전      관찰값1    관찰값2
# 관찰값1
# 관찰값2


# example(mcnemar.test)
Performance <- matrix(c(794, 86, 150, 570),
                      nrow = 2,
                      dimnames = list("1st Survey" = c("Approve", "Disapprove"), 
                                      "2nd Survey" = c("Approve", "Disapprove")))

Performance
mcnemar.test(Performance)
chisq.test(Performance)

binom.test(86 , 86 + 150 , .5)


### 5. 적합도 검정(Goodness of Fit)
# 통계 분석에서는 종종 데이터가 특정 분포를 따름을 가정한다. 특히 데이터의 크기가 일정 수 이상이라면 데이터가 정규성을 따름을 별 의심없이 가정하기도 하지만 실제 검정을 해 볼 수도 있다.

## 5.1 Chi Square Test
table( survey$W.Hnd )
# 글씨를 왼손으로 쓰는 사람과 오른손으로 쓰는 사람의 비율이 30% : 70%인지의 여부를 분석해보자.
prop.table(table( survey$W.Hnd ))
chisq.test( table( survey$W.Hnd ), p=c(.15 , .85))


## 5.2 Shapiro-Wilk Test : 정규성 검증
shapiro.test( rnorm(1000) )
shapiro.test( rt(1000, 10000) )


## 5.3 Kolmogorov-Smirnov Test : 
# 비모수 검정(Nonparameteric Test)으로 경험적 분포함수(Empirical Distribution Function)와 비교대상이 되는 분포의 누적분포함수(Cumulative Distribution Function)간의 최대 거리를 통계량으로 사용한다.
a = rnorm(100)
b = rnorm(100, 0.2)
hist(a, breaks = 15)
hist(b, breaks = 15)

ks.test(a, b)

# - 정규분포와 균등분포간 비교를 하면?


## 5.4 Q-Q Plot
# 자료가 특정 분포를 따르는지를 시각적으로 검토하기위해 Q-Q Plot을 사용한다. Q-Q Plot은 Quantile-Quantile Plot의 약자로 비교하고자하는 분포의 분위수끼리 좌표 평면에 표시하여 그린다.
# x가 정귭문포를 따른다면, Z = (X - xbar) / sigma  => X = sigma Z + xbar
# - 이때 X값에 대응하는 동일한 분위수의 Z를 찾아 매핑하여 그린다.

x <- rnorm(1000 , mean =10 , sd =1)
x
qqnorm(x)
qqline(x, lty =2)

#코쉬분포와의 비교
y <- rcauchy (5000)
qqnorm(y)
qqline(y, lty =2)


### 6 상관 계수
# 6.1 피어슨 상관계수(Pearson Correlation Coefficient)
cor( iris$Sepal.Width , iris$Sepal.Length)
cor( iris[ ,1:4])
symnum( cor( iris[ ,1:4]) )
# - 위에서 [0, 0.3)은 표시되지 않고, 
# - [0.3, 0.6)은 ‘.’, 
# - [0.6, 0.8)은 ‘,’ 등으로 표시되었음을 알 수 있다.

install.packages("corrgram")
library( corrgram )
corrgram( cor( iris[ ,1:4]) , type ="corr", upper.panel = panel.conf )


## 6.2 스피어만 상관계수(Spearman’s Rank Correlation Coefficient)
# 스피어만 상관계수는 :
# - 상관계수를 계산할 두 데이터의 실제값 대신 두 값의 순위를 사용해 상관계수를 비교하는 방식이다. 
# - 계산 방법이 피어슨 상관계수와 유사해 이해가 쉽고,
# - 피어슨 상관계수와 달리 비선형 관계의 연관성을 파악할 수 있다는 장점이 있다. 
# - 또한 순위만 매길 수 있다면 적용이 가능하므로 
# -- 연속형(Continous) 데이터에 적합한 피어슨 상관계수와 달리
# -- 이산형(Discrete) 데이터, 순서형(Ordinal) 데이터에 적용이 가능하다.

x <- c(3, 4, 5, 3, 2, 1, 7, 5)
rank( sort(x))

m <- matrix(c(1:10 , (1:10)^2) , ncol =2)
m

library(Hmisc)
rcorr(m, type ="pearson")$r
rcorr(m, type ="spearman")$r


## 6.3 켄달의 순위 상관계수(Kendal’s Rank Correlation Coefficient)
# - (X, Y ) 형태의 순서쌍으로 데이터가 있을 때 xi < xj, yi < yj 가 성립하면 concordant, 
# - xi < xj 이지만 yi > yj 이면 discordant라고 정의한다.
cor(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5), method = "kendall")

install.packages("Kendall")
library( Kendall )
Kendall(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5))


## 6.4 상관 계수 검정(Correlation Test)
# - corr.test()를 사용해 상관 계수의 유의성을 판단할 수 있다. 
# - 이 때 귀무가설은 다음과 같다. 
# -- ‘H0: 상관 계수가 0이다.
cor.test(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5) , method ="pearson")
cor.test(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5) , method ="spearman")
cor.test(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5) , method ="kendall")


### 7. 추정과 검정
## 7.1 일표본 평균
# - 이론적 배경은 별도로 ...

x <- rnorm(1000, 0.5, 1.5)
x

# 표본의 크기가 30 이하일 때, 모평균을 추정하는데 사용한다.
# - 귀무가설: 모평균은 0이다.
t.test(x, mu=0)

x <- rnorm(30, mean=10)
# - 귀무가설: 모평균은 10이다.
t.test(x, mu=11)

# - 데이터가 정규분포로 부터 나왔음을 가정하므로, 사실 x에 대해 Shapiro-Wilk Test를 먼저 수행해야 한다.


## 7.2 독립 2표본 평균
# - 이론적 배경
# - group에 따라 수면제에 따라 환자id별 수면시간의 증가량(extra)

sleep
# - 독립되었다는 가정을 위해 환자 정보를 제거
sleep2 <- sleep[, -3]
tapply(sleep2$extra, sleep2$group, mean)

# 모분산이 같은지 먼저 검증하자.
var.test(extra ~ group, sleep2)

t.test(extra ~ group, sleep2, paired=F, var.equal=T)

## 7.3 paired 2표본 평균
# - 하나의 개체에 대해 서로 다른 측정으로 평가하므로
# - 동일한 사이즈의 2개의 측정 데이터 그룹이 필요.
sleep
library(tidyr)
w_sleep <- sleep %>% spread(group, extra) %>%
  arrange(ID)
w_sleep

t.test(w_sleep[,2], w_sleep[,3], paired = T)


## 7.4 이표본 분산
# - F 분포를 이용
iris
with(iris, var.test(Sepal.Width, Sepal.Length))


## 7.5 일표본 비율
### 1) 베르누이 시행 n번 시행하여 X번 성공 관찰
prop.test(42, 100, p=.5)

binom.test(42, 100, p=.5)


## 7.6 이표본 비율
prop.test(c(45, 55), c(100, 90))
prop.test(45, 100, p=.55)
prop.test(55, 90, p=.55)


###### -- 선형회귀 -- ######
# 1. 단순 선형회귀
# • 독립변수 X는 고정된 값이다.
# • 오차항의 분산이 동일하다.
# • 오차항간 상호 독립이다.
# • 오차항은 평균이 0이며 분산은 σ2인 정규 분포를 따른다.
# • 독립변수간 독립이다.
# • 종속 변수와 독립변수간에 수식 9.1이 성립해야한다.
# y = ax + b + error

## 1.1 모델 생성
data(cars)
head(cars)
# - speed에서 break를 밟을 때 밀려나는 distance
# dist = a x speed + b + error
summary(cars)
m <- lm(dist ~ speed, cars)
m

#Pr의 값은 오류를 범할 확률
summary(m)

## 1.2 결과 추출
# - 회귀 계수예측값 
coef(m)
confint(m)
# - 예측값
head(cars, 5)
fitted(m)[1:5]
# - 잔차
residuals(m)[1:5]
# - 잔차 제곱합: SSE
deviance(m)
sum((cars$dist - fitted(m))^2)
sum((cars$dist - predict(m, newdata = cars))^2)


## 1.3 예측과 신뢰구간
m
predict(m, newdata=data.frame(speed=3))
(cf <- coef(m))
cf[1] + cf[2]*3

predict(m, newdata=data.frame(speed=3),
        interval = "confidence")


## 1.4 모형 평가
# - 설명 변수 평가
summary(m)

# - 결정계수와 F 통계량
## F = MSR / MSE

## 1.5 ANOVA 및 모델간 비교
anova(m)

full <- lm(dist ~ speed, data=cars)
reduced <- lm(dist ~ 1, data=cars)
full
reduced

anova(reduced, full)

## 1.6 모델 평가 차트
plot(m)
# cook's distance
# -- https://datascienceschool.net/view-notebook/e18a542e4dbd429f8666ccafd1067e7d/

par( mfrow =c(1 ,2))
plot(m, which =c(4, 6))
# dev.off()
par(mfrow=c(1,1))


## 1.7 회귀 직선의 시각화
plot(cars$speed, cars$dist)
abline(coef(m))

# - 신뢰구간을 포함하여 그리면
summary(cars$speed)
predict(m,
        newdata= data.frame(speed =seq(4.0, 25.0, .2)),
        interval="confidence")

speed <- seq(min(cars$speed), max(cars$speed), .1)
ys <- predict(m, newdata = data.frame(speed = speed),
              interval ="confidence")
matplot(speed, ys, type ='n')
matlines(speed, ys)


### 2. 중선형회귀
# - 중회귀는 하나 이상의 설명변수가 사용된 선형 회귀이다.
## 2.1 모델 생성 및 평가
m <- lm( Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width ,
         data = iris )
m
coef(m)
summary(m)
plot(m)


## 2.2 범주형 변수
iris[1:5,]
m <- lm( Sepal.Length ~ ., data = iris )
m
summary(m)
plot(m)

# - 모델에 사용된 데이터는 model.matrix를 이용.
model.matrix(m)[c(1, 51, 101) ,]

anova(m)


## 2.3 중선형회귀모형의 시각화
# - 시각화를 위해 Sepal.Width와 Species만 사용하자.
with(iris , plot(Sepal.Width , Sepal.Length ,
                cex=.7 ,
                pch= as.numeric ( Species ),
                col= as.numeric(Species)))
legend("topright", levels(iris $ Species ), pch =1:3 , bg="white")
levels(iris$Species)

m <- lm(Sepal.Length ~ Sepal.Width + Species , data = iris)
coef(m)

abline(2.25 , 0.80 , lty =1)
abline(2.25 + 1.45 , 0.80 , lty =2)
abline(2.25 + 1.94 , 0.80 , lty =3)


## 2.4 표현식을 위한 I()의 사용
# 선형이 아닌 polynomial regression을 고려할 수 있다.
x <- 1:1000
y <- x^2 + 3*x + 5 + rnorm(1000) # = hat y + error
lm(y ~ I(x^2) + x)
lm(y ~ x^2 + x) # x^2은 상호작용으로석 해석.


## 2.5 변수의 변환
x <- 101:200
y <- exp(3*x + rnorm(100) )
plot(x, y)
lm(log(y) ~ x)
lm(y ~ exp(x))

x <- 101:200
y <- log(x) + rnorm(100)*0.01
plot(x, y)
summary(lm(y ~ log(x)))
summary(lm(y ~ x))
summary(lm(sqrt(y) ~ x))


## 2.6 상호작용 / 교호작용
# - 교호작용의 이해, speed:dist

# Orange 데이터에서:
#   - Tree는 서로 다른 나무 종을 뜻하고, 
#   - age는 나무의 수령, 
#   - circumference는 나무의 둘레를 뜻한다. 
# 특히 age는 Tree별로 모두 동일한 나이인 
#   - 118, 484, 664, ..., 1582때 측정되었다.

data( Orange )
Orange

with( Orange ,
     plot(Tree , circumference , 
         xlab ="tree", 
         ylab ="circumference"))

# 상호작용 그림(interaction plot)을 다음과 같이 그릴 수 있다.
with(Orange, interaction.plot(age, Tree, circumference))
# 이 절에서 다루고자 하는 내용은 :
#   - 범주형 변수와 연속형 변수의 상호작용이다. 
#   - 반면 Orange$Tree는 순서가 있는 범주형 변수.
#   - 따라서, 이를 순서가 없는 명목형 변수로 바꿔준다.
Orange[,"fTree"] <- factor(Orange[, "Tree"], ordered= F)
str(Orange)

# fTree, age를 설명변수로 한 선형회귀를 수행하자.
m <- lm(circumference ~ fTree * age , data = Orange )
# -- fTree * age는 fTree + age + fTree:age를 의미.
anova(m)

head(model.matrix(m))

# -- agee와 관련있는 열만 뽑아내보자.
mm = model.matrix(m)
grep("age", colnames(mm))
mm[, grep("age", colnames(mm))]
plot(m)
summary(m)

m <- lm(circumference ~ fTree * sqrt(age) , data = Orange )
summary(m)
plot(m)

### 3. 이상치(outlier)
# 이상치는 주어진 회귀모형에 의해 잘 설명되지 않는 자료점을 뜻한다:
# - 이상치 검출에서는 잔차, 특히 외면 스튜던트화 잔차(externally studentized residual)을 사용한다. 
# - 외면 스튜던트화 잔차는 rstudent()를 사용해 구한다
m <- lm( circumference ~ age + I(age^2), data = Orange )
rstudent(m)

# 외면 스튜던트화 잔차는 t 분포를 따르므로 
# - t-test를 사용해 rstudent() 값이 너무 크거나 작은 점을 찾으면 된다. 
# - 다행히 R에는 이를 간단하게 할 수 있는 라이브러리 car::outlierTest()가 있다.

library(car)
outlierTest(m)
head(Orange)
# - 일부러 이상치를 추가하여 test해보자.
Orange2 <- rbind(Orange,
                 data.frame(Tree = as.factor(c(6,6,6)),
                            age=c(118, 484, 664),
                            circumference=c(177,50,30),
                            fTree = as.factor(c(6,6,6))))
tail(Orange2)
with(Orange2, interaction.plot(age, Tree, circumference))

m <- lm( circumference ~ age + I(age^2), data = Orange2)
outlierTest(m)


### 4. 변수선택
# 중선형 회귀 모형에서의 설명변수를 선택하는 방법중 한가지는 특정 기준(예를들어 F-statistics 나 AIC)을 사용해 변수를 하나씩 택하거나 제거하는 것이다.

# 단계적 변수 선택을 위해 BostonHousing 데이터를 사용해보자.
# - 이 데이터는 보스턴 집 가격 medv를 종속 변수로 하고,
# - 범죄율, 방 수 등을 설명변수로하여 회귀분석을 할 수 있다. 
library( mlbench )
data( BostonHousing )
m <- lm( medv ~ ., data = BostonHousing )
summary(m)
m2 <- step(m, direction ="both")
m2
# - 해석해보자.
summary(m2)
summary(m)

## 4.2 모든 경우에 대한 비교
# leaps 패키지의 regsubsets()
# - 모든 변수를 넣거나 빼면서 AIC 값을 비교한다.
install.packages("leaps")
library( leaps )
m <- regsubsets( medv ~ ., data = BostonHousing )
summary(m)
summary(m)$bic
summary(m)$adjr2
str(m)

plot(m)
