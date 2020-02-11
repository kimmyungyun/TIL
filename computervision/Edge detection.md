# Edge detection

## Edge

- 경계선, 윤곽선을 의미
- 에지 검출은 에지에 해당하는 화소를 찾는 과정
- 영상에서의 에지는 영상의 밝기가 낮은 곳에서 높은 곳, 또는 반대로 변하는 지점에서의 화소를 의미

- 변화율 = 기울기 = 함수의 미분을 의미



## Mask

- Edge를 찾기 위해 미분을 적용하기 위한 하나의 방법
- 모든 픽셀에 대하여 직접 미분 값을 구하는 것보다 빠름
- 기본 조건
  - 마스크 크기의 가로, 세로가 같고, 홀수여야 한다
  - 중심 지점을 기준으로 상하좌우 대칭
  - 모든 지점의 값들의 합은 0이다

#### 소벨 마스크

![](https://homepages.inf.ed.ac.uk/rbf/HIPR2/figs/sobmasks.gif)

- 모든 방향의 에지 추출
- 수직, 수평 에지보다 대각선 에지에 더 민감
- 잡음에 강함



#### Prewitt mask

![](https://www.researchgate.net/profile/S_N_Kumar/publication/317754223/figure/fig3/AS:565335482351616@1511797890242/Masks-for-the-Prewitt-gradient-edge-detector-The-Laplacian-operator-is-based-on-second.png)

- sobel mask와 비슷
- sobel 보다 에지가 덜 부각
- 수직, 수평 에지에 더 민감



#### Robert mask

![](https://homepages.inf.ed.ac.uk/rbf/HIPR2/figs/robmasks.gif)

- 매우 빠른 계산 속도
- 에지를 확실하게 추출
- 에지가 가늠
- 잡음에 매우 민감
- 위의 이미지는 mask의 기본 조건을 충족시키지 못하는데, 3x3 으로 확장시키고 확장된 위치의 값을 0으로 고정한다



## Convolution

- 이미지에 마스크를 적용할 때 사용하는 계산 방법
- 계산 방법
  1. 마스크 크기 만큼의 픽셀과 마스크를 각 원소에 대응하여 곱셈
  2. 계산된 모든 값을 더하여 가운데 픽셀에 대입
  3. 그외 픽셀은 그대로 유지 또는 0으로 변환
  4. 그 다음 픽셀부터 원본을 기준으로 첫번째 계산과 같이 연산하여 값을 업데이트

![](https://sgugger.github.io/images/art4_one_conv.png)