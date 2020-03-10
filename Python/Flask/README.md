# Flask

---

## 제공 위치

- [Link](https://www.palletsprojects.com/p/flask/)

---

## Flask 사용 시 html 내에서 python 사용법

- [jinja2](https://jinja.palletsprojects.com/en/2.10.x/)라는 문법을 사용한다
- jinja2를 사용할 경우 jinja2가 html 파일을 읽고, html로 변환 시킨 후 보여준다

---

## 실행 명령어

- 윈도우의 경우 env가 아닌 set을 사용
- 환경변수 FLASK_APP에다가 hello.py를 지정하고 flask 프로그램을 실행

```bash
env FLASK_APP=hello.py flask run
```

---

## 명령어 쉽게 만들기

- 이 코드를 작성할 경우 `python hello.py` 와 같은 방법으로 실행이 가능

```python
if __name__ == '__main__':
    app.run(debug = True)
```

---

## HTML 파일 보여주기

- 해당 프로젝트 내에 폴더를 만들어야하는데, 폴더 이름은 반드시 `templates`로 해야한다

- `templates` 폴더에 `index.html` 파일을 생성

- 이후 라우트 부분 코드를 작성

  ```python
  @app.route('/html_file')
  def html_file():
      return flask.render_template('index.html')
  ```

---

## HTML 파일에 변수 전달하기

- `variable.html` 파일의 html_name 변수에 name값을 넣어준다

  ```python
  def variable():
      name = "햄버거"
      return render_template('variable.html', html_name=name)
  ```

- 이때 variable.html 파일 형태

- 중괄호 2개를 변수이름에 씌우면 렌더링이 된다

  ```html
      <ol class="lunch">
          <li>{{html_name}}음식 드세요</li>
          <li>볶음밥</li>
          <li>짬뽕</li>
          <li>탕수육</li>
      </ol>
  ```

---

## url_for 함수

- HTML에서 사용하는 함수
- 기본 URL뒤에 Endpoint로 매개변수를 넣어서 호출해준다

```python
{{ url_for('video_feed2', name='assets_video2')  }}
```

```python
@app.route('/video_feed2/<string:name>')
```

- 첫번째 코드의 name은 두번째 코드의 동적 URL name 변수에 값이 들어간다



## 동적 라우트

- app.route 부분의 string:name 이 url로 들어올 경우, name변수에 string형태로 저장한다라는 의미
- 즉 /greeting/kmy/라고 들어오면 name 변수에 kmy가 string 형태로 저장
- 그리고 render_template 함수를 통해서 html_name 변수에 저장 됨

```python
@app.route('/greeting/<string:name>/')
def greeting(name):
    def_name = name

    return render_template('greeting.html', html_name=def_name)
```

- greeting.html 파일의 해당 코드 내용

```html
<h1>{{html_name}} 안녕하세요</h1>
```

---

## 리스트를 html로 넘기기 및 반복문 사용

- jinja 문법을 활용하여 html 에서 사용한다

```python
@app.route('/movie')
def movies():
    movie_list = ['겨울왕국2', '쥬만지', '엔드게임']

    return render_template('movies.html', movie_list = movie_list)
```

```jinja2
<h1>{{movie_list}}</h1>
{% for movie in movie_list    %}
<li>{{movie}}</li>
{% endfor %}
```

---

## if문 사용법

```jinja2
{% for movie in movie_list %}
    {% if movie == '겨울왕국2' %}
        <li style="color:blue">{{movie}}</li>
    {% else %}
        <li>{{movie}}</li>
    {% endif %}
{% endfor %}
```

---

## html 간의 GET, POST 통신

- GET과 POST방식의 차이점
  - GET은 커피 주문 같은 것
  - POST는 서류 제출과 같은 것

```python

@app.route('/pong', methods=['GET', 'POST'])
def pong():
    return render_template('pong.html')
```

#### 추가적인 내용

- REST API
  - 하나의 URL에 대하여 어떤 방식으로 요청을 해올지 미리 알 수 있는 방식을 채택

### 파이썬 코드

- post를 통해 요청 받은 값에서 get함수를 통해서 keyword 값을 가져온다
- GET의 경우 request.args를 사용하면 된다
- .get 함수의 경우 두번째 파라미터로 없는 키에 접근할 경우 리턴할 값을 정해줄 수 있다

```python
@app.route('/pong', methods=['GET', 'POST'])
def pong():
    keyword = request.form.get(key='keyword')
    return render_template('pong.html',keyword=keyword)

```

---

## URL을 활용한 GET 방식

- 파이썬 부분

```python
@app.route('/google', methods=['GET'])
def google():
    return render_template('google.html')
```
- html 파일

```html
<h1>구글 대리 검색</h1>
<form action="https://www.google.com/search">
    <input type="text" name="q">
    <input type="submit">
</form>
```



---

## 연습 예제

- ### 모든 연습 예제  [링크](https://github.com/kimmyungyun/Flask)

- ### 랜덤으로 메뉴 뽑아서 출력

