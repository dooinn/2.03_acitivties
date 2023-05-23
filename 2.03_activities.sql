use bank;

-- 1. Select cards of type junior. Return just first 10 in your query.
select * from card
where type = 'junior'
limit 10;



-- 2.1 Select district name (A2) and salaries (A11), from the district table, where salary is greater than 10000. 
select A2 as name, A11 as salaires from district
where A11 > 1000;


-- 2.2 From the district table, return the district name (A2) and region (A3) together, separate by "-". Example: "Benesov - Central Bohemia".

select concat(A2,' - ',A3) from district;



-- 3.1 Select those loans whose contract finished and not paid back (status = B). Return the debt value (amount of the loan - payment).

select (amount-payments) as debt_value from loan
where status = 'B';


-- 3.2 From the query above, return only the loans where the debt value is greater than 10000.
select (amount-payments) as debt_value from loan
where status = 'B' and (amount-payments) > 10000;




-- 4.1 Return card_id and year_issued for all gold cards.

select card_id, year(str_to_date(issued, '%y%m%d %H:%i:%s')) as year_issued
from card
where type = 'gold';




-- 4.2 Return the year of the first gold card issued.
select card_id, year(str_to_date(issued, '%y%m%d %H:%i:%s')) as extracted_year
from card
where type = 'gold'
order by issued desc
limit 1;


-- 4.3 Format the issue date to be similar to the format in the example: 'November 7th, 1993'

select date_format(str_to_date(issued, '%y%m%d %H:%i:%s'), '%M %D, %Y') as issued
from card;


-- 5.1 Check for transactions with null or empty values for the amount column.

select * from trans
where amount is null or amount = '';


-- 5.2 Count how many transactions have empty and non-empty k_symbol. (Hint: use SUM and CASE WHEN)


# method 1
select
	sum(case when k_symbol is null or k_symbol = '' then 1 else 0 end) as count_empty_k_symbol,
    sum(case when k_symbol is not null and k_symbol != '' then 1 else 0 end) as count_non_empty_k_symbol
from trans;


# method 2
select *, (a.empty + b.non_empty) as total
from
  (select count(*) as 'empty'
   from trans
   where k_symbol = '') as a
join
  (select count(*) as 'non_empty'
   from trans
   where k_symbol != '') as b;




