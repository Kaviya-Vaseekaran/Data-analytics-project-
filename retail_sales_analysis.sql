
create table ss as
(


select distinct s1.* ,r1.Region,r1.Country,r1.Continent,
             rt1.ReturnDate,
             p1.ProductSubcategoryKey,p1.ProductSKU,p1.ProductName,
		p1.ModelName,p1.ProductDescription,p1.ProductColor,p1.ProductSize, 
		p1.ProductStyle,p1.ProductCost,p1.ProductPrice,
             ps1.SubcategoryName,ps1.ProductCategoryKey,
			 pc1.CategoryName,
			 c1.Prefix,c1.FirstName,c1.LastName,c1.BirthDate,
		c1.MaritalStatus,c1.Gender,c1.EmailAddress,c1.AnnualIncome,
		c1.TotalChildren,c1.EducationLevel,c1.Occupation,c1.HomeOwner
from sales as s1 
             left join region as r1 on s1.territorykey = r1.salesterritorykey 
             left join returns as rt1 on s1.ordernumber= rt1.ordernumber
			 left join product as p1 on s1.productkey= p1.productkey
			 left join  productsubcat as ps1 on p1.productsubcategorykey=ps1.productsubcategorykey
             left join productcat as pc1 on ps1.productcategorykey = pc1.productcategorykey
             left join customers as c1 on s1.customerkey = c1.customerkey
);


create view ss_view as
(


select distinct s1.* ,r1.Region,r1.Country,r1.Continent,
             rt1.ReturnDate,
             p1.ProductSubcategoryKey,p1.ProductSKU,p1.ProductName,
		p1.ModelName,p1.ProductDescription,p1.ProductColor,p1.ProductSize, 
		p1.ProductStyle,p1.ProductCost,p1.ProductPrice,
             ps1.SubcategoryName,ps1.ProductCategoryKey,
			 pc1.CategoryName,
			 c1.Prefix,c1.FirstName,c1.LastName,c1.BirthDate,
		c1.MaritalStatus,c1.Gender,c1.EmailAddress,c1.AnnualIncome,
		c1.TotalChildren,c1.EducationLevel,c1.Occupation,c1.HomeOwner
from sales as s1 
             left join region as r1 on s1.territorykey = r1.salesterritorykey 
             left join returns as rt1 on s1.ordernumber= rt1.ordernumber
			 left join product as p1 on s1.productkey= p1.productkey
			 left join  productsubcat as ps1 on p1.productsubcategorykey=ps1.productsubcategorykey
             left join productcat as pc1 on ps1.productcategorykey = pc1.productcategorykey
             left join customers as c1 on s1.customerkey = c1.customerkey
);

select * from ss;
select * from ss_view
 where ordernumber = 'SO45080';

--1. Find the total number of orders placed.
select count ( distinct ordernumber) from sales; 
select count


--2. Find the total quantity of products sold.
select sum (orderquantity) from sales;

--3. Find the total number of customers who placed at least one order.
select count (distinct productkey) from sales;

--4. Find the total number of products that have been sold.
select count (distinct productkey) from sales;

--5. Find the total number of returned orders.
select count (distinct ordernumber) from returns;

--6. Find the total number of orders by region.
select region, count(distinct ordernumber )
from sales as s1
            
            left join region as r1 on s1.territorykey = r1.salesterritorykey
             group by region ;

--7. Find the total quantity of products sold in each region.
select region, sum(productkey)
from sales as s1
            
            left join region as r1 on s1.territorykey = r1.salesterritorykey
             group by region ;
			 
--8. Find the total number of orders for each product category.
select categoryname, count(distinct ordernumber)
from sales as s1
             left join product as p1 on s1.productkey= p1.productkey
			 left join  productsubcat as ps1 on p1.productsubcategorykey=ps1.productsubcategorykey
             left join productcat as pc1 on ps1.productcategorykey = pc1.productcategorykey
             group by categoryname;
			 
--9. Find the total number of orders for each product subcategory.
select subcategoryname,count (distinct ordernumber)
from sales as s1
            left join product as p1 on s1.productkey= p1.productkey
			left join  productsubcat as ps1 on p1.productsubcategorykey=ps1.productsubcategorykey
            group by subcategoryname;

--10. Find the top 5 products with the highest number of orders.
select productname,count(distinct ordernumber)
from sales as s1
           left join product as p1 on s1.productkey= p1.productkey
		   group by productname
		   order by count(distinct ordernumber)desc
		   limit 5;

--11. Find the total number of orders placed by customers grouped by gender.
select gender,count (distinct ordernumber)
from sales as s1
        left join customers as c1 on s1.customerkey = c1.customerkey
        group by gender;

--12. Find the average income of customers who placed orders.
select avg(AnnualIncome) from customer 
       left join sales as s1 on c1.customerkey = s1.customerkey;

--13.find the number of customers by marital status who placed orders.

select maritalstatus,count (distinct c1.customerkey)
from customers as c1
       left join sales as s1 on c1.customerkey = s1.customerkey
         group by maritalstatus; 
		 
--14. Find the top 10 customers who placed the highest number of orders.
select s1.customerkey,count (distinct orderquantity)
from sales as s1
        left join customers as c1 on s1.customerkey = c1.customerkey
        group by s1.customerkey
		order by count (distinct orderquantity)desc
		limit 10;
--15. Find the customers who placed more than 5 orders.
select customerkey
from sales as s1
        where orderquantity > '5';
       
--16. Find the total number of orders for each product.
select productname,count(distinct ordernumber)
from sales as s1
join product as p1 on s1.productkey = p1.productkey
group by productname;

--17. Find the total quantity sold for each product category.
select categoryname,sum(orderquantity)
from sales as s1
			 left join product as p1 on s1.productkey= p1.productkey
			 left join  productsubcat as ps1 on p1.productsubcategorykey=ps1.productsubcategorykey
             left join productcat as pc1 on ps1.productcategorykey = pc1.productcategorykey
 group by categoryname;

--18. Find the total quantity sold for each product subcategory
select subcategoryname,sum(orderquantity)
from sales as s1
			 left join product as p1 on s1.productkey= p1.productkey
			 left join  productsubcat as ps1 on p1.productsubcategorykey=ps1.productsubcategorykey
 group by subcategoryname;

--19. Find the top selling product in each category based on total quantity sold.
select productname,sum(orderquantity)
from sales as s1
			 left join product as p1 on s1.productkey= p1.productkey
 group by productname
 order by sum(orderquantity) desc;

--20. Find the products that were never sold
select productname from product as p1
left join sales as s1 on p1.productkey = s1.productkey
where s1.productkey is null;

--21. Find the total number of returned orders for each region.
select region,count (distinct ordernumber)
from returns as rt1
left join region as r1 on rt1.territorykey = r1.salesterritorykey
group by region;

--22. Find the number of returned orders for each product category.
select categoryname,count (distinct rt1.productkey)
from returns as rt1
			 left join product as p1 on rt1.productkey= p1.productkey
			 left join  productsubcat as ps1 on p1.productsubcategorykey=ps1.productsubcategorykey
             left join productcat as pc1 on ps1.productcategorykey = pc1.productcategorykey
 group by categoryname;

--23. Find the products with the highest number of returns.
select productname,count (distinct ordernumber)
from returns as rt1
			 left join product as p1 on rt1.productkey= p1.productkey
group by productname
order by count (distinct ordernumber)desc;

--24. Find the return percentage for each product (returned orders divided by total orders).
select 
from returns as rt1
			 left join product as p1 on rt1.productkey= p1.productkey

--25. Find the total number of orders placed in each year.
select count(distinct ordernumber),
extract ( year from orderdate) from sales
group by distinct orderdate;

--26. Find the total number of orders placed in each month.
select count(distinct ordernumber),
extract ( month from orderdate) from sales
group by distinct orderdate;

--27. Find the month with the highest number of orders.


--28. Find the total number of orders placed each day.
select count(distinct ordernumber),
extract ( day from orderdate) from sales
group by distinct orderdate;

--29. Find the total number of products sold in each year.
select count(productkey),
extract (year from orderdate) from sales
group by distinct order;

--30. Find the regions with the highest number of orders
select region, count (distinct ordernumber)
from sales as s1
left join region as r1 on s1.territorykey = r1.salesterritorykey
group by region
order by count (distinct ordernumber)desc;




select * from employes;
