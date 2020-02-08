# 딥러닝

## Logistic Cost function

![](https://t1.daumcdn.net/cfile/tistory/215B8646592521CE12)

위의 식처럼 정의할 수 있다
그런데 cost function에서는 if문을 사용할 수 없으므로 두가지 경우를 합쳐서 만든 식이 아래의 것과 같다

![](https://t1.daumcdn.net/cfile/tistory/25193846592521CF17)

[식 출처 ](https://copycode.tistory.com/162)

## 활성함수

- 시그모이드 함수

  - 임의의 값을 0~1사이의 값으로 변환시키는 함수
  - 특징
    - 양 끝점에서의 변화량이 굉장히 작기 때문에 학습이 제대로 되지 않는 경우가 있다
    - 0~1 사이의 값에서 변화량이 크기 때문에 이미지 같은 경우도 0~1사이로 변환시킨다

  

## 다중 분류

- 분류하고자 하는 데이터가 여러가지
- softmax 함수를 사용

#### 소프트맥스

- 총합이 1인 형태로 바꿔서 계산해주는 함수
- 큰 값은 두드러지고, 작은 값은 더 작아지는 효과가 발생

#### 교차 엔트로피

- 올바르게 예측했을 때 cost 0
- 틀리게 예측했을 때 cost 무한대
- ![](https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F213B3033596A268523)
- 