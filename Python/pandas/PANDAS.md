# Pandas

## loc

- 이름을 사용하여 접근한다
- 그래서 `df.loc[-1]` 이 사용이 안된다
- 왜냐하면 -1이라는 이름을 가진 값이 없기 때문



## iloc

- 위치에 의한 접근이다
- 그래서 `df.iloc[-1]`로 접근이 가능하다



## tail 과 head 함수

- 함수이기 때문에 인덱싱과는 전혀 다른 것이다
- 인덱싱은 스칼라, 벡터, 행렬이 될 수도 있지만 함수는 Dataframe으로 리턴이 되도록 정해져 있기 때문에 항상 Dataframe으로 리턴한다



## columns 함수

- 데이터 프레임의 컬럼을 indexes 라는 형태로 리턴해주는 함수

- ```python
  df[df.columns[[0,4]]]
  ```

- 이런 방식으로 컬럼 이름을 점 인덱싱을 통해 접근이 가능



## Series와 Dataframe

- 1차원은 Series, 2차원은 Dataframe으로 다룬다
- 2차원 Dataframe에서 차원을 유지해야 할 필요성이 있을 때 연속 색인을 사용하도록 한다
- 즉 리스트로 위치 값을 접근하면은 차원이 유지된 상태로 반환이 된다
- 두 개의 타입은 메소드가 다르기 때문에 잘 생각해줘야 한다
- 데이터프레임에 대한 색인은 열 이름으로 들어간다 `df[[1, 2, 3]]` 이런 것은 에러가 뜬다
  만약 열 이름 중 `1, 2, 3`이 있으면 가능하다



## nunique()

- 유니크한 값들의 갯수를 리턴해줌
- 