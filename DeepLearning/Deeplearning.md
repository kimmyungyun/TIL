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

  