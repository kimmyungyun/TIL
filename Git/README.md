# Git Bash 사용법

> Git 프로그램을 Bash 명령어를 활용한 방법을 공부해봅시다

## git 초기 선언

- 처음 수행할 때 한번만 하면 된다

```bash
git init
```



## git add 방법

```bash
git add 해당 파일 경로
git add .
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



## 깃허브와 repository 연결

- 원격으로 연결이 완료되면 안해도 된다

```bash
git remote add origin https://github.com/kimmyungyun/TIL.git
```

- 원격 저장소인 TIL.git을 추가하는데 origin이라는 이름으로 추가한다

## 깃허브의 원격 저장소에 연결 되었는지 확인

```bash
git remote
git remote -v
```

- 원격으로 어떤 이름으로 저장이 되어있는지 확인이 가능하다
- 기존 과정만으로는 push 를 할 목표가 없었기 때문에 하지 못했지만 지금은 목표를 remote를 통해서 지정했기 때문에 동작이 가능하다

## 깃허브에 푸쉬 하는 방법

```bash
git push origin master
```

