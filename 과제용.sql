-------------------------------------------------
-- Basic SELECT 1번)
-- 춘 기술 대학교의 학과 이름과 계열을 표시하시요. 단, 출력 헤더는 
-- "학과 명" , "계열"으로 표시하도록 한다. 

SELECT DEPARTMENT_NAME 학과명 , CATEGORY 계열 
FROM TB_DEPARTMENT 

-------------------------------------------------
-- Basic SELECT 2번)
-- 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다. 

SELECT DEPARTMENT_NAME||'의 정원은 '||CAPACITY||'명 입니다. ' AS "학과별 정원" 
FROM TB_DEPARTMENT 

-------------------------------------------------
-- Basic SELECT 3번)
 /*"국어국문학과"에 다니는 여학생 중 현재 휴학중인 여학생을
  * 찾아달라는 요청이 들어왔다. 누구인가?
  * (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 
  * 조회해서 찾아 내도록 하자)
  */

SELECT STUDENT_NAME  
FROM TB_STUDENT A
JOIN TB_DEPARTMENT B ON(A.DEPARTMENT_NO = B.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '국어%' AND  ABSENCE_YN ='Y'
AND SUBSTR(STUDENT_SSN,8,1) = '2';

-------------------------------------------------
-- Basic SELECT 4번)
/* 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 개시하고자 한다.
  * 그 대상자들의 학번이 다음과 같을 때 대상자들을
  * 찾는 적절한 SQL 구문을 작성하시오.
  * A513079, A513090, A513091, A513110, A513119
  */

SELECT STUDENT_NAME ,STUDENT_NO 
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-------------------------------------------------
-- Basic SELECT 5번)
/* 입학정원이 20명 이상 30명 이하인 
  * 학과들의 학과 이름과 계열을 출력하시오.
  */

SELECT DEPARTMENT_NAME , CATEGORY 
FROM  TB_DEPARTMENT
WHERE  CAPACITY BETWEEN 20 AND 30;

-------------------------------------------------
-- Basic SELECT 6번)
/* 춘 기술대학교는 총장을 제외하고 모든 교수들이
  * 소속 학과를 가지고 있다. 그럼 춘 기술대학교 총장의
  * 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
  */

SELECT PROFESSOR_NAME, DEPARTMENT_NO 
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-------------------------------------------------
-- Basic SELECT 7번)
/* 혹시 전산상의 착오로 학과가 지정되어 있지 않은
  * 학생이 있는지 확인하고자 한다.
  * 어떠한 SQL 문장을 사용하면 될 것인지
  * 작성하시오.
  */

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-------------------------------------------------
-- Basic SELECT 8번)
/* 수강신청을 하려고 한다. 
    선수과목 여부를 확인해야 하는데, 
    선수과목이 존재하는 과목들은 
    어떤 과목인지 과목번호를
    조회해보시오.
 */

SELECT CLASS_NO 
FROM TB_CLASS 
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-------------------------------------------------
-- Basic SELECT 9번)
/* 춘 대학에는 어떤 계열(CATEGORY)들이
  * 있는지 조회해보시오.
  */

SELECT  DISTINCT CATEGORY 
FROM TB_DEPARTMENT;

-------------------------------------------------
-- Basic SELECT 10번)
/* 02학번 전주 거주자들의 모임을 만들려고 한다.
  * 휴학한 사람들은 제외한 재학중인
  * 학생들의 학번, 이름, 주민번호를 출력하는
  * 구문을 작성하시오.
  */

SELECT STUDENT_NO, STUDENT_NAME , STUDENT_SSN, ENTRANCE_DATE
FROM TB_STUDENT 
WHERE ENTRANCE_DATE BETWEEN  '2002-01-01' AND '2002-12-31'
AND STUDENT_ADDRESS LIKE '%전주%'
AND  ABSENCE_YN ='N';

--======================================================================
--======================================================================

-- Additional SELECT 1번)
/* 영어영문학과(학과코드 002) 학생들의 
 *  학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 
 * 표시하는 SQL 문장을 작성하시오.
 * (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
 */

SELECT STUDENT_NO 학번 , STUDENT_NAME 이름 , ENTRANCE_DATE 입학년도
FROM TB_STUDENT A
JOIN TB_DEPARTMENT B ON(A.DEPARTMENT_NO=B.DEPARTMENT_NO) 
WHERE B.DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-------------------------------------------------
-- Additional SELECT 2번)
/* 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 
 * 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자.
 * (* 이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 
      원인이 무엇일지 생각해볼 것) */ 

SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-------------------------------------------------
-- Additional SELECT 3번)
/* 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오.
 * 단 이때 나이가 적은 사람에서 많은 사람 순으로 화면에 출력되도록 만드시오. 
 * (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름, "나이"로 한다. 
 * 나이는 '만'으로 계산한다.)
 */

-- 내 풀이 (만 나이 적용전)
SELECT PROFESSOR_NAME 교수이름 , (100 - SUBSTR(PROFESSOR_SSN, 0,2)) +23 나이, PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8,1) = '1';

-- 강사 풀이 
SELECT PROFESSOR_NAME 교수이름, 
    FLOOR(MONTHS_BETWEEN(SYSDATE,TO_DATE(19||SUBSTR(PROFESSOR_SSN,1,6))) / 12) 나이
FROM TB_PROFESSOR 
WHERE SUBSTR(PROFESSOR_SSN, 8,1) = '1'
ORDER BY 나이;

-------------------------------------------------
-- Additional SELECT 5번)
/* 춘 기술 대학교의 재수생 입학자를 구하려고 한다. 
 * 어떻게 찾아낼 것인가? 
 * 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주된다.
 */
SELECT STUDENT_NO , STUDENT_NAME 
FROM TB_STUDENT  
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - 
  	  EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6))) > 19;
  	 
-------------------------------------------------
-- Additional SELECT 10번)
-- 학과 별 학생 수를 구하여 "학과 번호", "학생수(명)"의 형태로 
-- 헤더를 만들어 결과값이 출력되도록하시오.

SELECT DEPARTMENT_NO "학과 번호" ,COUNT(*) "학생수(명)"
FROM TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-------------------------------------------------
-- Additional SELECT 12번)
/* 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오
 * 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점"이라고 찍히게 하고,
 * 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
 */

SELECT SUBSTR(TERM_NO,1,4 ) 년도, ROUND( AVG(POINT),1)"년도 별 평점" 
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4 )
ORDER BY 년도;

-------------------------------------------------
-- Additional SELECT 13번)
/* 학과 별 휴학생 수를 파악하고자 한다. 
 * 학과 번호와 휴학생 수를 표시하는  SQL문장을 작성하시오 */

--문제 풀이 1번 SUM을 활용
SELECT DEPARTMENT_NO "학과 코드명",
	   SUM(DECODE(ABSENCE_YN, 'Y',1,0))"휴학생 수"
FROM TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

--문제 풀이 2번 COUNT 활용 
SELECT DEPARTMENT_NO "학과 코드명",
	   COUNT(DECODE(ABSENCE_YN, 'Y',1))"휴학생 수"
FROM TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-------------------------------------------------
-- Additional SELECT 14번)
-- 춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다
-- 어떤 SQL문장을 사용하면 가능하겠는가?

SELECT STUDENT_NAME , COUNT(*) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) >= 2
ORDER BY 1;

-------------------------------------------------
-- Additional SELECT 15번)

/* 학번이 A112113인 김고운 학생의 년도, 학기 별 평점을 구하는 SQL문을 작성하시오
 * 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점"이라고 찍히게 하고, 
 * 점수는 반올림하여 소수점 이하 한 자리까지만 표시한다. */

SELECT NVL(SUBSTR(TERM_NO,1,4), ' ')년도,
	   NVL(SUBSTR(TERM_NO,5,2),' ')학기,
	   ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2)) 
ORDER BY SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2);
--> ORDER BY절에 함수 작성 가능












