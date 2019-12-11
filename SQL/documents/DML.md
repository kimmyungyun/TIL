# DML(Data Manipulation Language)

<hr>

## DESC

```sql
desc 테이블명

Ex) desc BONUS
```

## SELECT

```sql
SELECT 보고 싶은 열 FROM TABLE_NAME
EX) select A, B from table_name

--조회 중 산술 연산 방법
select a * 100 from table_name
--산술 연산 시 null 값이 있는데 계산한다면 null 값이 된다

--계산 사용시 오라클은 계산한 값이 실수면은 실수로, 정수라면 정수로 보여준다
```

## NULL값에 대한 관리

```sql
nvl(열이름, 값)
-- 원래 있던 값이 있다면 그대로 나온다
--하지만 null값이 있다면 지정해준 값으로 변해서 나온다
--nvl 의 경우 null 값을 해당 열의 자료형에 맞춰서 값을 넣어줄 수 있다
--null 값은 그 어떤 비교연산자도 사용 불가능
```



## 별칭 사용법

```sql
select ename, sal, comm, nvl(comm, 0), sal*12+nvl(comm, 0) as Annsal from emp
-- as를 통해서 사용된다
--이 경우 sal*12_nvl(comm, 0)이 Annsal이라는 이름의 열로 출력된다
--별칭 쓸 때는 " "를 사용해서 감싸준다
--다른 경우에는 당연히 ' ' 를 사용한다
```

## Concatenation

```sql
-- 연결하는 법
select ename || job from emp

--이런 방식으로 연결 가능
select ename || ' is a ' ||job from emp
```



## 중복된 데이터 제거 후 출력

```sql
select distinct deptno from emp
```



## 오라클에서 연산자

![Image](.\assets\DML1.png)



## 오라클에서 조건문

```sql
select empno, ename, sal from emp where sal = 3000;
select empno, ename, sal from emp where sal != 3000
```



## 논리 연산자

![image](.\assets\DML2.png)

## 사이 연산자

![img](.\assets\DML3.png)

## select 할 때 날짜 형태 잡아주기

```sql
to_char(hirdate, 'yyyy-mm-dd') --이런식으로 사용
select empno, ename, to_char(hiredate, 'yyyyd-mm-dd') from emp;
select empno, ename, to_char(hiredate, 'yyyy/mm/dd') from emp;

select empno, ename, to_char(hiredate, 'yyyy/mm/dd HH:MI:SS') from emp;
```

## OR 연산자를 줄이는 방법

```sql
select * from emp where comm in(300, 500, 1400)
```

## null 확인

```
select * from emp where comm is null
select * from emp where comm is not null
```

## 패턴 검색

```sql
column_name like pattern

--F이후에 어떤 문자가 와도 OK
select * from emp where ename like 'F%';
--F만 포함되면 OK
select * from emp where ename like '%F%';

--A가 끝에인 2글자
select * from emp where ename like '_A';
--끝에서 2번째가 A인 글자, 또는 맨앞이 A인 2글자 
select * from emp where ename like '%A_';

--A가 포함되지 않은 글자
select * from emp where ename not like '%A%';
```

![image](.\assets\DML4.png)



## 정렬

![img](.\assets\DML5.png)

--정렬은 sql문 가장 마지막에 넣어줘야한다 select * from emp order by sal desc;

```sql
--월급에 따라서 내림차순 정렬 이후, 이름에 따라서 오름차순으로 정렬
select * from emp order by sal desc, ename asc;
```



## 그룹조건

![img](.\assets\DML6.png)


- 그룹 함수는 null값을 제외하고 계산을 한다
```sql
select sum(sal) from emp; 
select avg(sal) from emp;

--그룹 함수를 사용할 때는 보통 1개만 나오므로
--다른 것과 같이 출력을 할 때는 줄 수를 맞출 수 있도록 해야한다
```

## 소수점이 길게 나오는 연산일 때

```sql
select round(avg(sal), 4) from emp;
-- round 뒤의 매개변수가 몇번째자리까지 보여줄지 알려주는 것
--round 뒤의 매개변수가 음수가 될 경우 정수 n번째 자리에서 반올림해서 보여준다
--
```

## 행 개수 아는 법

```sql
select count(ename) from emp;
select count(distinct job) from emp;
select count(distinct job), count(distinct deptno) from emp;
```

## Group by 절

![img](.\assets\DML7.png)
```sql
select deptno from emp group by deptno; 
--deptno 열에 저장된 값이 같은 레코드끼리 그룹으로 쳐짐
```
- 보통 groupby 뒤에는 열의 이름을 적음
- 예를 들어 select avg(sal) from emp group by deptno 를 입력하면 
  - 같은 deptno끼리 묶여서 평균 sal이 나온다

## sql문 실행 순서

1. ( ) 실행되고
2. where 실행되고
3. group by 실행되고
4. having 실행 되고
5. 출력 부분 실행되고
6. order by 로 정렬이 된다
7. 마지막에 정렬된 것이 출력된다

## Having

```sql
select round(avg(sal), 4), deptno from emp where sal>=2000 
group by deptno having avg(sal)>=2000 order by deptno;
```