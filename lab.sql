--Строгонов Вячеслав

/*
1) Написать запрос,выводящий всю информацию о департаментах.
Упорядочить по коду департамента.
*/
SELECT  dep.*
  FROM  DEPARTMENTS dep
  ORDER BY  dep.DEPARTMENT_ID
;

/*
2)Написать запрос, выбирающий ID, имя+фамилию (в виде одного столбца через пробел)
и адрес электронной почты всех клиентов. (Использовать конкатенацию строк и
переименование столбца с именем и фамилией на «NAME»). Упорядочить по коду
клиента.
*/
SELECT  cus.customer_id , 
        cus.cust_first_name || ' ' || cus.cust_last_name AS Name, 
        cust_email
  FROM  customers cus
  ORDER BY  cus.customer_id
;

/*
3) Написать запрос, выводящий сотрудников, зарплата которых за год лежит в диапазоне
от 100 до 200 тыс. дол., упорядочив их по занимаемой должности, зарплате (от большей
к меньшей) и фамилии. Выбранные данные должны включать фамилию, имя, должность
(код должности), email, телефон, зарплату за месяц за вычетом налогов. Будем считать,
что у нас прогрессивная шкала налогообложения: с зарплаты за год от 100 до 150 тыс.
дол. налог составляет 30%, выше – 35%. Результат округлить до целого дол.
Обязательно использовать between и case.
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
4. Выбрать страны с идентификаторами DE, IT или RU. Переименовать столбцы на «Код
страны», «Название страны». Упорядочить по названию страны.
*/
SELECT  cntr.COUNTRY_ID  AS "Код страны",
        cntr.COUNTRY_NAME  AS "Название страны"
FROM COUNTRIES cntr
WHERE cntr.COUNTRY_ID IN ('DE','IT','RU')

;
/*
5.Выбрать имя+фамилия сотрудников, у которых в фамилии вторая буква «a» (латинская),
а в имени присутствует буква «d» (не важно, в каком регистре). Упорядочить по имени.
Использовать оператор like и функции приведения к нужному регистру.
*/
SELECT   emp.FIRST_NAME || ' ' || emp.LAST_NAME
    FROM EMPLOYEES emp
    WHERE emp.LAST_NAME like '_a%' and LOWER(emp.FIRST_NAME) like '%d%'
    ORDER BY 
        emp.FIRST_NAME
;

/*
6. Выбрать сотрудников у которых фамилия или имя короче 5 символов. Упорядочить
записи по суммарной длине фамилии и имени, затем по длине фамилии, затем просто по
фамилии, затем просто по имени.
Ответ: 27 строк.
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
7. Выбрать должности в порядке их «выгодности» (средней зарплаты, за среднюю взять
среднее-арифметическое минимальной и максимальной зарплат). Более «выгодные»
должности должны быть первыми, в случае одинаковой зарплаты упорядочить по коду
должности. Вывести столбцы код должности, название должности, средняя зарплата
после налогов, округленная до сотен. Считаем шкалу налогообложения плоской – 18%.
Ответ: 19 строк.
*/
SELECT   jb.JOB_ID,
         jb.JOB_TITLE,
         ROUND(((jb.MAX_SALARY+jb.MIN_SALARY)/2)*0.82, 2) AS AVG_SALARY
  FROM   JOBS jb
  ORDER BY 
          AVG_SALARY desc,
          jb.JOB_ID
;
/*8. Будем считать, что все клиенты делятся на категории A, B, C. Категория A – клиенты с
кредитным лимитом >= 3500, B >= 1000, C – все остальные. Вывести всех клиентов,
упорядочив их по категории в обратном порядке (сначала клиенты категории A), затем
по фамилии. Вывести столбцы фамилия, имя, категория, комментарий. В комментарии
для клиентов категории A должно быть строка «Внимание, VIP-клиенты», для
остальных клиентов комментарий должен остаться пустым (NULL).
*/
SELECT  cust.CUST_LAST_NAME,
        cust.CUST_FIRST_NAME,
        CASE
            WHEN cust.CREDIT_LIMIT >= 3500 THEN 'A'
            WHEN cust.CREDIT_LIMIT > 1000  THEN 'B'
            WHEN cust.CREDIT_LIMIT < 1000  THEN 'C'
        END AS CATEGORY,
        CASE
            WHEN cust.CREDIT_LIMIT >= 3500  THEN 'Внимение, VIP-клиенты'
        END AS COMMENTS
    
  FROM CUSTOMERS cust
  ORDER BY
         CATEGORY,
         cust.CUST_LAST_NAME
;

/*
9. Вывести месяцы (их название на русском), в которые были заказы в 1998 году. Месяцы
не должны повторяться и должны быть упорядочены. Использовать группировку по
функции extract от даты для исключения дублирования месяцев и decode для выбора
названия месяца по его номеру. Подзапросы не использовать
*/
SELECT  
    DECODE(
      EXTRACT(MONTH FROM ord.ORDER_DATE),
      '1','Январь',
      '2','Февраль',
      '3','Март',
      '4','Апрель',
      '5','Май',
      '6','Июнь',
      '7','Июль',
      '8','Август',
      '9','Сентябрь',
      '10','Октябрь',
      '11','Ноябрь',
      '12','Декабрь'
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
10. Написать предыдущий запрос, используя для получения названия месяца функцию
to_char (указать для функции nls_date_language 3-м параметром). Вместо группировки
использовать distinct, подзапросы не использовать.
Ответ: аналогичный предыдущему заданию
*/
SELECT  DISTINCT
        TO_CHAR(ord.ORDER_DATE ,'Month', 'nls_date_language=RUSSIAN') AS MONTH
  FROM ORDERS ord
  WHERE DATE'1998-01-01' <=ord.ORDER_DATE AND ord.ORDER_DATE <DATE'1999-01-01'
  ORDER BY
        MONTH DESC
;

/*
11. Написать запрос, выводящий все даты текущего месяца. Текущий месяц должен браться
из sysdate. Второй столбец должен содержать комментарий в виде строки «Выходной»
для суббот и воскресений. Для определения дня недели воспользоваться функций
to_char. Для выбора чисел от 1 до 31 можно воспользоваться псевдостолбцом rownum,
выбирая данные из любой таблицы, где количество строк более 30.
Ответ: 30 или 31 строка (ну если только задание сдается не в феврале)
*/
select EXTRACt(DAY from last_day(sysdate))
from dual
;

SELECT
    trunc(sysdate, 'mm')+rownum-1,
    TO_DATE(sysdate,'DD.MM.YY')-EXTRACT(day from sysdate)+ROWNUM as DT,
    CASE
      WHEN  TO_CHAR(TO_DATE(sysdate,'DD.MM.YY')+ROWNUM-EXTRACT(day from sysdate),'D','NLS_DATE_LANGUAGE=RUSSIAN') >= 6 THEN 'Выходной'
    end as Comments
  from EMPLOYEES
  where rownum <= EXTRACT(DAY from last_day(sysdate))
  order by 
    EXTRACT(DAY FROM DT)
;

/*
12. Выбрать всех сотрудников (код сотрудника, фамилия+имя через пробел, код должности,
зарплата, комиссия - %), которые получают комиссию от заказов. Воспользоваться
конструкцией is not null.Упорядочить сотрудников по проценту комиссии (от большего к
меньшему), затем по коду сотрудника.
Ответ: 35 строк
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
13. Получить статистику по сумме продаж за 1995-2000 годы в разрезе кварталов (1 квартал
– январь-март и т.д.). В выборке должно быть 6 столбцов – год, сумма продаж за 1-ый, 2-
ой, 3-ий и 4-ый квартала, а также общая сумма продаж за год. Упорядочить по году.
Воспользоваться группировкой по году, а также суммированием по выражению с case
или decode, которое будут отделять продажи за нужный квартал.
Ответ: 5 строк
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
14. Выбрать из таблицы товаров всю оперативную память. Считать таковой любой товар
для которого в названии указан размер в MB или GB (в любом регистре), название
товара не начинается с HD, а также в первых 30 символах описания товара не
встречаются слова disk, drive и hard. Вывести столбцы: код товара, название товара,
гарантия, цена (по прайсу – LIST_PRICE), url в каталоге. В поле гарантия должно быть
выведено целое число – количество месяцев гарантии (учесть, что гарантия может быть
год и более). Упорядочить по размеру памяти (от большего к меньшему), затем по цене
(от меньшей к большей). Размер для упорядочивания извлечь из названия товара по
шаблону NN MB/GB (не забыть при этом сконвертировать GB в мегабайты) c помощью
regexp_replace. Like не использовать, вместо него использовать regexp_like с явным
указанием, что регистр букв следует игнорировать.
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
15. Вывести целое количество минут, оставшихся до окончания занятий. Время окончания
занятия в запросе должно быть задано в виде строки, например «21:30». Явного указания
текущей даты в запросе быть не должно. Можно воспользоваться комбинацией функций
to_char/to_date
*/
SELECT
    ROUND((TO_char(to_date('21:30','HH24,MI'),'HH24,MI') - to_CHAR(sysdate,'HH24,MI')),0)*60 +
   ((TO_char(to_date('21:30','HH24,MI'),'HH24,MI') - to_CHAR(sysdate,'HH24,MI')) - (ROUND((TO_char(to_date('21:30','HH24,MI'),'HH24,MI') - to_CHAR(sysdate,'HH24,MI')),0)))*100 as Minutes
from dual
;



















/*Предположим что высокая зарплата >10000, 2 таблицы sal_grade , count
*/

select --можно использовать подзапрос во from, засунуть туда case и группировка по sal_grade
    Count(T1.salary) AS N,
    CASE
        WHEN T1.salary >= 10000 THEN 'Высокая'
        ELSE 'Низкая'
    END 
    AS SAL_GRADE
        
FROM EMPLOYEES T1
    GROUP BY 
    CASE
         WHEN T1.salary >= 10000 THEN 'Высокая'
         ELSE 'Низкая'
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
FROM PRODUCT_INFORMATION T1 --выбор первой второй число 'regexp_substr(prudct,'\d+(\.\d+)?',1,1/2)
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
         
  
           


    
    

