# 깃 배쉬 사용법

## 깃 초기 선언

```bash
git init
```



## git add 방법

```bash
git add 해당 파일 경로
```



## git commit 방법

``` bash
git commit -m '커밋 내용'
```



## git add 내용 확인

```bash
git status
```

녹색이 현재 추가된 파일 또는 디렉토리
빨간색이 현재 추가되지 않은 파일 또는 디렉토리

![gitStatus](.\assets\gitStatus.PNG)

## 커밋시 필요한 깃허브 로그인

```bash
git config --global user.email "해당 아이디"
git config --global user.name "이름"
```



## 등록 되었는지 확인 하는 방법

```bash
git config --global user.email
git config --global user.name
```

