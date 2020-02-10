# Preprocessing

## Mean subtraction, scaling, normalization

- 데이터셋의 조명 변화를 방지하는데 사용
- CNN을 보조하는데 사용하는기술
- 모든 딥러닝 방식이 mean subtraction과 scaling 방식을 사용하는 것은 아니다

#### 계산방식

1. R, G, B 채널에 대해서 트레이닝 셋의 모든 이미지의 평균 픽셀 값을 계산

2. 3가지 값 Mr, Mg, Mb가 나온다
3. 훈련하는 동안 인풋 이미지에 대해서 Mr, Mg, Mb를 빼준다
4. ![](https://www.pyimagesearch.com/wp-content/uploads/2017/11/blob_from_images_mean_subtraction.jpg)
5. 만약 scaling factor가 있다면, scaling factor로 나눠줌으로써 정규화를 해줄 수 있다
   - scaling factor는 훈련 데이터들의 표준편차로 사용할 수 있다
   - 하지만 이미지 공간을 특정 공간의 범위로 만들고 싶다면 직접 값을 정해도 된다

## min-max scaling

- 최댓값 1, 최솟값 0이 되도록 선형적으로 크기를 보정하는 것
- ![](https://media.geeksforgeeks.org/wp-content/uploads/min-max-normalisation.jpg)

## Whitening

- 모든 변수가 uncorrelated 하고, 1의 분산을 갖게만드는 것

- 즉 whitening 과정은 Decorrelation을 통해 최적화 과정에서 빠르게 수렴할 수 있도록 하는 것

- ![](http://aikorea.org/cs231n/assets/nn2/prepro2.jpeg)

  #### 구하는 방법

  1. 데이터 간의 공분산 행렬을 구한다
  2. 공분산 행렬의 고유벡터를 구한다
  3. 데이터행렬과 고유벡터를 dot 연산한 값을 구한다(decorrelate 한 데이터)
  4. 3번에서 구한 행렬을 고유값의 sqrt 값으로 나누어 준다