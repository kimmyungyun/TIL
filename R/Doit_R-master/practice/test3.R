#[R 분석 및 시각화 라이브러리]
# 데이터에서 size가 3 ~ 5인 데이터에 대해, sex별 tiprate의 평균은?
#  - 단, tiprate는 tip/total_bill이다.
#- 단, tips 데이터는 아래와 같이 가져온다.
library(reshape2)
library(dplyr)

tips %>% filter(size >=3 & size <=5) %>% #size 3이상 5이하인 데이터를 필터링
  select('tip', 'total_bill', 'sex') %>% #필요한 데이터만 선택
  mutate(tiprate = tip/total_bill) %>% # tiprate 계산
  group_by(sex) %>% #sex에 따라서 그룹화
  summarise(mean_tiprate = mean(tiprate)) #그룹화에 따른 tiprate 평균 구하기
