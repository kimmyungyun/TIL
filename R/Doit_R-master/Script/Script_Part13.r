#### 13-2 t-검정 : 평균의 차 검정####
###
#제 1종오류라는 개념이 있음
# 유의확률 : 실제로는 집단간 차이가 없는데 우연히 차이가 있는 데이터가 추출될 확률
# t분포는 표본들에 의해 나타난 평균이 갖는 분포


## -------------------------------------------------------------------- ##
mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

head(mpg_diff)
table(mpg_diff$class)

t.test(data = mpg_diff, cty ~ class, var.equal = T)


## -------------------------------------------------------------------- ##
mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))  # r:regular, p:premium

table(mpg_diff2$fl)

# p-value에 따른 확률이 의미하는 것
# 연료의 종류에 따라서 도시에서의 연비가 차이가 없다 라고 했을 때 오류를 범할 확률이 28.75% 정도 된다

t.test(data = mpg_diff2, cty ~ fl, var.equal = T)


#### 13-3 ####

## -------------------------------------------------------------------- ##
economics <- as.data.frame(ggplot2::economics)
cor.test(economics$unemploy, economics$pce)


## -------------------------------------------------------------------- ##
head(mtcars)
car_cor <- cor(mtcars)  # 상관행렬 생성
round(car_cor, 2)       # 소수점 셋째 자리에서 반올림해서 출력

install.packages("corrplot")
library(corrplot)

corrplot(car_cor)

corrplot(car_cor, method = "number")

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

corrplot(car_cor,
         method = "color",       # 색깔로 표현
         col = col(200),         # 색상 200개 선정
         type = "lower",         # 왼쪽 아래 행렬만 표시
         order = "hclust",       # 유사한 상관계수끼리 군집화
         addCoef.col = "black",  # 상관계수 색깔
         tl.col = "black",       # 변수명 색깔
         tl.srt = 45,            # 변수명 45도 기울임
         diag = F)               # 대각 행렬 제외

