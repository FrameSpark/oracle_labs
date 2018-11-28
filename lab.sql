--��������� ��������

/*
1) �������� ������,��������� ��� ���������� � �������������.
����������� �� ���� ������������.
*/
SELECT  dep.*
  FROM  DEPARTMENTS dep
  ORDER BY  dep.DEPARTMENT_ID
;

/*
2)�������� ������, ���������� ID, ���+������� (� ���� ������ ������� ����� ������)
� ����� ����������� ����� ���� ��������. (������������ ������������ ����� �
�������������� ������� � ������ � �������� �� �NAME�). ����������� �� ����
�������.
*/
SELECT  cus.customer_id , 
        cus.cust_first_name || ' ' || cus.cust_last_name AS Name, 
        cust_email
  FROM  customers cus
  ORDER BY  cus.customer_id
;

/*
3) �������� ������, ��������� �����������, �������� ������� �� ��� ����� � ���������
�� 100 �� 200 ���. ���., ���������� �� �� ���������� ���������, �������� (�� �������
� �������) � �������. ��������� ������ ������ �������� �������, ���, ���������
(��� ���������), email, �������, �������� �� ����� �� ������� �������. ����� �������,
��� � ��� ������������� ����� ���������������: � �������� �� ��� �� 100 �� 150 ���.
���. ����� ���������� 30%, ���� � 35%. ��������� ��������� �� ������ ���.
����������� ������������ between � case.
*/
SELECT  emp.LAST_NAME,
        emp.FIRST_NAME,
        emp.JOB_ID,
        emp.EMAIL,
        emp.PHONE_NUMBER,
        CASE
          WHEN emp.SALARY*12 > 100000 THEN 
            ROUND((emp.SALARY*0.7))                             
          WHEN emp.SALARY*12 => 150000 AND emp.SALARY*12 <= 200000 THEN 
            ROUND((emp.SALARY*0.65))
        END AS SALARY
  FROM    EMPLOYEES emp
  WHERE emp.SALARY*12 BETWEEN 100000 AND 200000
  ORDER BY 
        emp.JOB_ID, 
        emp.SALARY, 
        emp.LAST_NAME
    
;
/*
4. ������� ������ � ���������������� DE, IT ��� RU. ������������� ������� �� ����
�������, ��������� �������. ����������� �� �������� ������.
*/
SELECT  cntr.COUNTRY_ID  AS "��� ������",
        cntr.COUNTRY_NAME  AS "�������� ������"
FROM COUNTRIES cntr
WHERE cntr.COUNTRY_ID IN ('DE','IT','RU')

;
/*
5.������� ���+������� �����������, � ������� � ������� ������ ����� �a� (���������),
� � ����� ������������ ����� �d� (�� �����, � ����� ��������). ����������� �� �����.
������������ �������� like � ������� ���������� � ������� ��������.
*/
SELECT   emp.FIRST_NAME || ' ' || emp.LAST_NAME
    FROM EMPLOYEES emp
    WHERE emp.LAST_NAME like '_a%' and LOWER(emp.FIRST_NAME) like '%d%'
    ORDER BY 
        emp.FIRST_NAME
;

/*
6. ������� ����������� � ������� ������� ��� ��� ������ 5 ��������. �����������
������ �� ��������� ����� ������� � �����, ����� �� ����� �������, ����� ������ ��
�������, ����� ������ �� �����.
�����: 27 �����.
*/
SELECT *
  FROM EMPLOYEES emp
  WHERE (LENGTH(emp.FIRST_NAME) < 5 OR LENGTH(emp.LAST_NAME)<5)
  ORDER BY
      LENGTH(emp.FIRST_NAME) + LENGTH(emp.LAST_NAME),
      LENGTH(emp.LAST_NAME),
      emp.LAST_NAME,
      emp.FIRST_NAME
;

/*
7. ������� ��������� � ������� �� ����������� (������� ��������, �� ������� �����
�������-�������������� ����������� � ������������ �������). ����� ���������
��������� ������ ���� �������, � ������ ���������� �������� ����������� �� ����
���������. ������� ������� ��� ���������, �������� ���������, ������� ��������
����� �������, ����������� �� �����. ������� ����� ��������������� ������� � 18%.
�����: 19 �����.
*/
SELECT   jb.JOB_ID,
         jb.JOB_TITLE,
         ROUND(((jb.MAX_SALARY+jb.MIN_SALARY)/2)*0.82, 2) AS AVG_SALARY
  FROM   JOBS jb
  ORDER BY 
          AVG_SALARY desc,
          jb.JOB_ID
;
/*8. ����� �������, ��� ��� ������� ������� �� ��������� A, B, C. ��������� A � ������� �
��������� ������� >= 3500, B >= 1000, C � ��� ���������. ������� ���� ��������,
���������� �� �� ��������� � �������� ������� (������� ������� ��������� A), �����
�� �������. ������� ������� �������, ���, ���������, �����������. � �����������
��� �������� ��������� A ������ ���� ������ ���������, VIP-��������, ���
��������� �������� ����������� ������ �������� ������ (NULL).
*/
SELECT  cust.CUST_LAST_NAME,
        cust.CUST_FIRST_NAME,
        CASE
            WHEN cust.CREDIT_LIMIT >= 3500 THEN 'A'
            WHEN cust.CREDIT_LIMIT > 1000  THEN 'B'
            WHEN cust.CREDIT_LIMIT < 1000  THEN 'C'
        END AS CATEGORY,
        CASE
            WHEN cust.CREDIT_LIMIT >= 3500  THEN '��������, VIP-�������'
        END AS COMMENTS
    
  FROM CUSTOMERS cust
  ORDER BY
         CATEGORY,
         cust.CUST_LAST_NAME
;

/*
9. ������� ������ (�� �������� �� �������), � ������� ���� ������ � 1998 ����. ������
�� ������ ����������� � ������ ���� �����������. ������������ ����������� ��
������� extract �� ���� ��� ���������� ������������ ������� � decode ��� ������
�������� ������ �� ��� ������. ���������� �� ������������
*/
SELECT  
    DECODE(
      EXTRACT(MONTH FROM ord.ORDER_DATE),
      '1','������',
      '2','�������',
      '3','����',
      '4','������',
      '5','���',
      '6','����',
      '7','����',
      '8','������',
      '9','��������',
      '10','�������',
      '11','������',
      '12','�������'
    ) AS MONTH
  FROM
    ORDERS ord
  WHERE
    DATE'1998-01-01' <=ord.ORDER_DATE AND ord.ORDER_DATE <DATE'1999-01-01'
  GROUP BY
    EXTRACT(MONTH FROM ord.ORDER_DATE)
  ORDER BY
    MONTH desc

;

/*
10. �������� ���������� ������, ��������� ��� ��������� �������� ������ �������
to_char (������� ��� ������� nls_date_language 3-� ����������). ������ �����������
������������ distinct, ���������� �� ������������.
�����: ����������� ����������� �������
*/
SELECT  DISTINCT
        TO_CHAR(ord.ORDER_DATE ,'Month', 'nls_date_language=RUSSIAN') AS MONTH
  FROM ORDERS ord
  WHERE DATE'1998-01-01' <=ord.ORDER_DATE AND ord.ORDER_DATE <DATE'1999-01-01'
  ORDER BY
        MONTH DESC
;

/*
11. �������� ������, ��������� ��� ���� �������� ������. ������� ����� ������ �������
�� sysdate. ������ ������� ������ ��������� ����������� � ���� ������ ���������
��� ������ � �����������. ��� ����������� ��� ������ ��������������� �������
to_char. ��� ������ ����� �� 1 �� 31 ����� ��������������� �������������� rownum,
������� ������ �� ����� �������, ��� ���������� ����� ����� 30.
�����: 30 ��� 31 ������ (�� ���� ������ ������� ������� �� � �������)
*/
select EXTRACt(DAY from last_day(sysdate))
from dual
;

SELECT
    trunc(sysdate, 'mm')+rownum-1,
    TO_DATE(sysdate,'DD.MM.YY')-EXTRACT(day from sysdate)+ROWNUM as DT,
    CASE
      WHEN  TO_CHAR(TO_DATE(sysdate,'DD.MM.YY')+ROWNUM-EXTRACT(day from sysdate),'D','NLS_DATE_LANGUAGE=RUSSIAN') >= 6 THEN '��������'
    end as Comments
  from EMPLOYEES
  where rownum <= EXTRACT(DAY from last_day(sysdate))
  order by 
    EXTRACT(DAY FROM DT)
;

/*
12. ������� ���� ����������� (��� ����������, �������+��� ����� ������, ��� ���������,
��������, �������� - %), ������� �������� �������� �� �������. ���������������
������������ is not null.����������� ����������� �� �������� �������� (�� �������� �
��������), ����� �� ���� ����������.
�����: 35 �����
*/
SELECT  emp.EMPLOYEE_ID,
        emp.LAST_NAME || ' ' || emp.FIRST_NAME,
        emp.JOB_ID,
        emp.SALARY,
        emp.COMMISSION_PCT
  FROM EMPLOYEES emp
  WHERE emp.COMMISSION_PCT IS NOT NULL
  ORDER BY
        emp.COMMISSION_PCT DESC,
        emp.JOB_ID
;

/*
13. �������� ���������� �� ����� ������ �� 1995-2000 ���� � ������� ��������� (1 �������
� ������-���� � �.�.). � ������� ������ ���� 6 �������� � ���, ����� ������ �� 1-��, 2-
��, 3-�� � 4-�� ��������, � ����� ����� ����� ������ �� ���. ����������� �� ����.
��������������� ������������ �� ����, � ����� ������������� �� ��������� � case
��� decode, ������� ����� �������� ������� �� ������ �������.
�����: 5 �����
*/
SELECT  EXTRACT(YEAR FROM ord.ORDER_DATE) as YEAR,
        SUM(CASE WHEN EXTRACT(month FROM ord.ORDER_DATE) >=1 THEN ord.ORDER_TOTAL END) AS QUART1_SUM,
        SUM(CASE WHEN EXTRACT(month FROM ord.ORDER_DATE) >=4 THEN ord.ORDER_TOTAL END) AS QUART2_SUM,
        SUM(CASE WHEN EXTRACT(month FROM ord.ORDER_DATE) >=7 THEN ord.ORDER_TOTAL END) AS QUART3_SUM,
        SUM(CASE WHEN EXTRACT(month FROM ord.ORDER_DATE) >=10 THEN ord.ORDER_TOTAL END) AS QUART4_SUM,
        SUM(T1.ORDER_TOTAL)AS YEAR_SUM
  FROM ORDERS ord
  WHERE date'1995-01-01'<=ord.ORDER_DATE and ord.ORDER_DATE<date'2001-01-01'
  GROUP BY 
        EXTRACT(YEAR FROM ord.ORDER_DATE)
;

/*
14. ������� �� ������� ������� ��� ����������� ������. ������� ������� ����� �����
��� �������� � �������� ������ ������ � MB ��� GB (� ����� ��������), ��������
������ �� ���������� � HD, � ����� � ������ 30 �������� �������� ������ ��
����������� ����� disk, drive � hard. ������� �������: ��� ������, �������� ������,
��������, ���� (�� ������ � LIST_PRICE), url � ��������. � ���� �������� ������ ����
�������� ����� ����� � ���������� ������� �������� (������, ��� �������� ����� ����
��� � �����). ����������� �� ������� ������ (�� �������� � ��������), ����� �� ����
(�� ������� � �������). ������ ��� �������������� ������� �� �������� ������ ��
������� NN MB/GB (�� ������ ��� ���� ��������������� GB � ���������) c �������
regexp_replace. Like �� ������������, ������ ���� ������������ regexp_like � �����
���������, ��� ������� ���� ������� ������������.
*/
select  pinf.PRODUCT_ID,
        pinf.PRODUCT_NAME,
        (EXTRACT(MONTH FROM pinf.WARRANTY_PERIOD) + EXTRACT(YEAR FROM pinf.WARRANTY_PERIOD)*12) AS WARRANTY_MONTH,
        pinf.LIST_PRICE,
        pinf.CATALOG_URL
  from PRODUCT_INFORMATION pinf
  WHERE ( NOT REGEXP_LIKE(pinf.PRODUCT_NAME, '^HD') 
          AND NOT REGEXP_LIKE(SUBSTR(pinf.PRODUCT_NAME, 1, 30), 'disk|drive|hard', 'i') 
          AND REGEXP_LIKE(pinf.PRODUCT_NAME, '(\d+)\s*(mb|gb)', 'i')
         )
    -- \d+\s*(mb|gb)
  order by
   case
        when REGEXP_LIKE(pinf.PRODUCT_NAME,'GB','i') then cast(REGEXP_SUBSTR(REGEXP_SUBSTR(pinf.PRODUCT_NAME,'(\d+)\s*(gb|GB)'), '(\d+)\s*') as number)*1024
        when REGEXP_LIKE(pinf.PRODUCT_NAME,'MB','i') then cast(REGEXP_SUBSTR(REGEXP_SUBSTR(pinf.PRODUCT_NAME,'(\d+)\s*(mb|MB)'),'(\d+)\s*') as number)
   end desc
    
;

select *
  from dual
  where NOT REGEXP_LIKE(SUBSTR('fgfg disk dsdsd', 1, 30) ,'diskdricehard','i') 
;

/*
15. ������� ����� ���������� �����, ���������� �� ��������� �������. ����� ���������
������� � ������� ������ ���� ������ � ���� ������, �������� �21:30�. ������ ��������
������� ���� � ������� ���� �� ������. ����� ��������������� ����������� �������
to_char/to_date
*/
SELECT
    ROUND((TO_char(to_date('21:30','HH24,MI'),'HH24,MI') - to_CHAR(sysdate,'HH24,MI')),0)*60 +
   ((TO_char(to_date('21:30','HH24,MI'),'HH24,MI') - to_CHAR(sysdate,'HH24,MI')) - (ROUND((TO_char(to_date('21:30','HH24,MI'),'HH24,MI') - to_CHAR(sysdate,'HH24,MI')),0)))*100 as Minutes
from dual
;



















/*����������� ��� ������� �������� >10000, 2 ������� sal_grade , count
*/

select --����� ������������ ��������� �� from, �������� ���� case � ����������� �� sal_grade
    Count(T1.salary) AS N,
    CASE
        WHEN T1.salary >= 10000 THEN '�������'
        ELSE '������'
    END 
    AS SAL_GRADE
        
FROM EMPLOYEES T1
    GROUP BY 
    CASE
         WHEN T1.salary >= 10000 THEN '�������'
         ELSE '������'
    END 
;
select
    COUNT( CASE WHEN T1.salary>=10000 THEN '1' END) as HIGH_SAL
                                        ,
    COUNT (CASE WHEN T1.salary<10000 THEN  '2' END ) as LOW_SAL
FROM EMPLOYEES T1
;

SELECT *
FROM PRODUCT_INFORMATION T1
WHERE REGEXP_LIKE(T1.PRODUCT_NAME, '^\d')
;
SELECT *
FROM PRODUCT_INFORMATION T1
WHERE REGEXP_LIKE(T1.PRODUCT_NAME, '^\d|\d$')
;
SELECT 
    REGEXP_SUBSTR(T1.PRODUCT_NAME,'\d+\.*\d*') --'^\D*(\d+(\.\d+)?)[^0-9.]+(\d+(\.\d+)?)\D*$'
FROM PRODUCT_INFORMATION T1 --����� ������ ������ ����� 'regexp_substr(prudct,'\d+(\.\d+)?',1,1/2)
WHERE REGEXP_LIKE(T1.PRODUCT_NAME, '\d+\.*\d*\D\d\.*\d*')
;
SELECT 
    REGEXP_SUBSTR(T1.PRODUCT_NAME,'\d+\.*\d*')
FROM PRODUCT_INFORMATION T1
WHERE REGEXP_LIKE(T1.PRODUCT_NAME, '\d+\.*\d*\D\d\.*\d*')
;

select  e.employee_id,
        e.first_name || ' ' || e.last_name,
        c.country_name
  from  employees e left join departments d on e.department_id = d.department_id
                    left join locations l on l.location_id = d.location_id
                    left join countries c on l.country_id = c.country_id
         
  
           


    
    

