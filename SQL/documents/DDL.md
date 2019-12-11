# DDL(Data Definition Language)

<hr>

## CREATE

```sql
create table 테이블명(
 자료이름 자료타입,
자료이름 자료타입
)
```

## number 타입 정리

```
Number(precision, scale)
-- precision은 소수점을 포함한 전체 자리수를 의미
-- scale은 소수점 이하 자리수를 지정
--precision만 적을 경우 반올림
--지정 안할 경우 입력한 만큼 할당
-- number(5, 2)일 경우 소숫점 2자리 포함 총 5자리가 되야 하므로 정수부분 4자리를 쓰면 에러
```

## Date 타입 정리

```
--날짜 타입
```

## CHAR 타입 정리

```
CHAR(20) 으로 설정할 경우 최대 20까지 사용 가능
근데 내용물이 5까지 밖에 안들어갈경우 15크기만큼 빈공간이 들어감
그래서 무조건 적으로 20을 차지하고 있음
최대 이상으로 넣을 경우 에러 발생
영어, 숫자는 1바이트 한글은 3바이트
```

## 잠깐 데이터 크기 시간

- 오라클, 파이썬은 UTF-8로 이루어져있어서 한글이 3바이트
- 자바는 UTF-16으로 인해 한글 2바이트로 취급

## 테이블 만들고 서브쿼리 내용 넣기

- 서브쿼리(select 부분) 실행 결과를 table에다가 넣는다

- 서브쿼리 내용(열과 데이터)를 테이블명1에다가 넣는다

```sql
create table 테이블명1 
as 
select * from 테이블명2
```



  - 일부만 하고 싶을 때
  - 입력한 것만 들어간다


```sql
create table 테이블명1 
as 
select empno, ename from emp
```



- where절을 사용할 경우

- where 절에 맞는 것만 들어간다

```sql
create table emp05
as
select * from emp where deptno=10;

create table emp05
as
select * from emp 1=0;
```

- where 절에 해당하는 것이 없을 때는?
- 열은 생기지만 줄은 생기지 않는다(데이터는 존재하지 않는다)
- 아예 조회가 안돼서 열만 생기는 것

##  

##  ALTER TABLE

- MODIFY 
  - 데이터가 없는 칸은 자유롭게 수정 가능
  - 데이터가 있는 칸은 타입수정 불가, 사이즈 줄이기 불가, 사이즈 늘리기 가능
- DROP 
  - 열을 지우는 건 되살리기가 불가능
  - 줄을 지우는 건 취소가 가능하다

```sql
ALTER TABLE TABLE_NAME 
ADD(COLUMN_NAME DATA_TYPE)

--자료 타입 변경 시
ALTER TABLE EMP03 
MODIFY(JOB VARCHAR2(111));

--자료 열 지우기
ALTER TABLE EMP02
DROP COLUMN JOB;

-테이블 지우기
DROP TABLE EMP01;
```

