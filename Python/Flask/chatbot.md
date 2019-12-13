# 챗봇

---

## 기반

- 텔레그램
- Python의 Flask

---

## 세팅 방법

- 텔레그램의 BotFather이라는 봇과 채팅을 시작한다

  ```
  /newbot 명령어를 활용
  이름 설정 후 API KEY 저장
  ```

---

## API Key 관리 방법

- `python-decouple`이라는 라이브러리를 설치한다

- .env 라는 파일을 만든다

- .gitignore에 .env 파일을 추가한다

- env 파일에 해당과 같은 방식으로 Key 값을 추가한다

  ```bash
  TELEGRAM_BOT_TOEKN='1234567890'
  ```

  

- 이후 Key 값을 사용할 파이썬 파일에 해당 코드를 활용한다

  ```python
  from decouple import config
  token = config('TELEGRAM_BOT_TOEKN')
  ```



---

## 텔레그램과 웹Hook 연결하는 법

- 텔레그램 API 사이트에서 setWebhook이라는 함수의 문서를 보면 된다
- 웹훅을 연결할 경우 

### 사용방법

- 파라미터 url에 ngrok 서버의 url을 넣어준다(왜냐하면 서버가 로컬이기 때문에 외부에서 접근할 수 있도록 해주는 ngrok을 사용했기 때문)
- `setwebhook_url`을 requests.get(setwebhook_url) 함수를 통해 연결을 해주면은 해당 봇에 메세지가 전달되면 ngrok를 통해서 로컬 서버로 값이 들어온다

```python
from decouple import config

token = config('TELEGRAM_BOT_TOKEN')
url = f'https://api.telegram.org/bot{token}/setWebhook'
ngrok_url = 'http://00d3dfd4.ngrok.io/telegram'

setwebhook_url = f"{url}?url={ngrok_url}"
```

---

## 연결 후 구현할 것

- 텔레그램과 Hook된 링크와 메인 코드에서 route를 통해 연결한다
- 이후 채팅을 통해 봇에 전달된 메세지를 분석해서 명령어로 인식하여 그에 따른 값을 반환해주면 된다

```python
@app.route(f'/telegram', methods=['POST'])
def telegram():
    req = request.get_json()
    print(req)
    user_id = req['message']['chat']['id']
    user_input = req['message']['text']

    if user_input == '로또':
        return_data = "로또를 입력하셨습니다."
    else:
        return_data = "지금 사용 가능한 명령어는 로또입니다."
    send_url = f'{url}sendMessage?chat_id={user_id}&text={user_input}'
    requests.get(send_url)
    print(f'{user_id} 님이 {user_input}이라는 문자를 보내셨습니다')
```





---

## API 문서

- [API 문서](https://core.telegram.org/bots/api)
- 해당 링크의 문서를 보면 API가 제공하는 함수들을 볼 수 있다

---

## 외부에서 로컬호스트로 올 수 있는 경로 만들기

### ngrok

- [다운로드 URL](https://ngrok.com/download)에서 다운로드

- 외부에서 로컬 포트번호로 접근할 수 있는 URL을 생성해준다

  ```bash
  ngrok http 포트번호
  ```

  