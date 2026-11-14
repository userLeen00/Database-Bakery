
alter Table Customer 
modify  COLUMN PhoneNumber varchar(15) NOT NULL;


select c.FirstName , count(o.OrderID) as ordercount from 
c_order o 
join customer c on o.customerid = c.customerid
group by c.FirstName;

