select * from production.productcategory;

select orderdate, salesorderid, customerid, productid, product.name as productname, productcategory.name as productcategory, orderqty, ((unitprice - (unitpricediscount * unitprice)) * orderqty) as revenue, ((unitprice - (unitpricediscount * unitprice) - standardcost) * orderqty) as profit,
case
	when countryregioncode = 'US' then 'United States'
	when countryregioncode = 'AU' then 'Australia'
	when countryregioncode = 'FR' then 'France'
	when countryregioncode = 'GB' then 'United Kingdom'
	when countryregioncode = 'CA' then 'Canada'
	when countryregioncode = 'DE' then 'Germany'
  end as country
from sales.salesorderdetail
left join
sales.salesorderheader using(salesorderid)
left join
production.product using(productid)
left join
sales.customer using(customerid)
left join
sales.salesterritory on salesorderheader.territoryid = salesterritory.territoryid
left join production.productsubcategory using (productsubcategoryid)
left join production.productcategory using (productcategoryid);