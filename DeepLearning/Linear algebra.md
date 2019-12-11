# 선형대수학

<hr>

##  텐서

### 정의

- 숫자의 다차원 배열
- RGB 이미지는 3차원 텐서
- CNN에서 미니배치르르 통해 이미지를 공급하는 것에는 4차원 텐서

<hr>

## 벡터의 내적

### 정의

- 두 벡터의 내적은 서로 대응하는 구성 요소의 곱의 합

<hr>

## 벡터와 행렬 작업

- 행렬에 벡터를 곱하면 또 다른 벡터가 결과로 나옴
- 행렬 A와 X의 곱셈을 통해 생성된 새로운 벡터 b는 A와 같은 열 벡터 차원을 가진다

<hr>

## 벡터의 일차독립

### 정의

- 벡터가 다른 벡터의 선형 조합으로 표현될 수 있다면 벡터는 다른 벡터에 일차독립

  ![일차독립](./assets/일차독립.jpg)


- c1 = c2 = 0 인 경우 외에 연립 방정식을 만족하는 경우가 있으면 `일차종속` 이라고 한다

---

## 행렬식

### 정의

- 정사각행렬에 수를 대응시키는 함수의 하나

  ![행렬식](./assets/행렬식.PNG)

- 행렬식이 0인 경우 역행렬이 없다

---

## 벡터의 놈

### 정의

- 벡터 크기의 척도

### 놈의 종류

- 맨해튼 놈(1차 놈)

  ![](https://latex.codecogs.com/gif.latex?\left\||u\right\||_1=\sum_{k=1}^{n}\left|u_k\right|)

- 유클리드 놈(2차 놈)

  ![유클리드 놈](https://latex.codecogs.com/gif.latex?\left&space;\||&space;u&space;\right&space;\||_2&space;=&space;\sqrt{\sum_{k=1}^{n}\left&space;|&space;u_k&space;\right&space;|^2})

- 맥시멈 놈

  ![맥시멈 놈](https://latex.codecogs.com/gif.latex?\displaystyle&space;\|&space;\math{u}&space;\|_\infty&space;=&space;\max_{1\le&space;k&space;\le&space;n}&space;|u_k|)