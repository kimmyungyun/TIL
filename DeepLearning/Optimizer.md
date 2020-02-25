# Optimizer

## GradientDescent

- 기본적인 전체 배치 기울기 하강 알고리즘



## Adagrad

- 기울기 하강과 같은 방식
- 글로벌 학습 속도 대신, 비용 함수가 의존하는 각 차원에 대해 학습 속도를 정규화
  - 글로벌 학습 속도를 각 차원에 대한 현재 반복까지의 이전 기울기의 l^2 노름으로 나눈 값
- 

## SGD

- 임의이 T값을 기준으로 미분값을 구해서 미분값의 반대방향으로 이동하면서 미분값이 0이 되는 구간으로 간다

- 운 나쁘면 local minimum에 도착하고 운이 좋으면 global minimum에 도착한다

- ![](https://latex.codecogs.com/gif.latex?w(t&plus;1)&space;=&space;w(t)&space;-&space;{\partial\over\partial&space;w}\mathbf{Loss(w)})



## 모멘텀

- 



## Nesterov 모멘텀

- 



## RMSprop

- 일괄 배치 학습에 가장 적합한 탄력적인 역전파 최적화 기술의 미니 배치버젼
- 학습 비율이 학습이 진행됨에 따라 자동으로 줄어드는 학습방법
- 