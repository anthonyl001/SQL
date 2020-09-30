--1
SELECT TreatmentTypeName,TreatmentName,Price
from MsTreatment t join MsTreatmentType y
	on t.TreatmentTypeId=y.TreatmentTypeId
where (TreatmentTypeName like '%hair%' or TreatmentTypeName like 'nail%') and Price<100000

--2
select distinct StaffName,StaffEmail=lower(left(staffname,1)+reverse(left(REVERSE(staffname),CHARINDEX(' ',REVERSE(staffname))-1))+'@oosalon.com')
from MsStaff s join HeaderSalonServices h
	on s.StaffId=h.StaffId
where DATENAME(weekday,TransactionDate)like 'Thursday'

--3
select [New Transaction ID]=REPLACE(TransactionId,'TR','Trans'),[Old Transaction ID]=TransactionId,TransactionDate,StaffName,CustomerName
from MsCustomer c join HeaderSalonServices h
	on c.CustomerId=h.CustomerId join MsStaff s
	on h.StaffId=s.StaffId 
where datediff(DAY,TransactionDate,'2012-12-24')<=2


--4
select [New Transaction Date]=dateadd(day,5,TransactionDate),[Old Transaction Date]=TransactionDate, CustomerName
from MsCustomer c join HeaderSalonServices h
	on c.CustomerId=h.CustomerId
where datepart(DAY,TransactionDate) not like '20'

--5
SELECT [Display Id]=datename(weekday,TransactionDate),CustomerName,TreatmentName,StaffPosition
FROM MsCustomer c join HeaderSalonServices h
	on c.CustomerId=h.CustomerId join MsStaff s
	on h.StaffId=s.StaffId join DetailSalonServices d
	on h.TransactionId=d.TransactionId join MsTreatment t
	on d.TreatmentId=t.TreatmentId
where StaffGender like 'Female' 
order by CustomerName

--6
select top(1) c.CustomerId,CustomerName,h.TransactionId,[Total Treatment]=count(d.TreatmentId)
from MsCustomer c join HeaderSalonServices h
	on c.CustomerId=h.CustomerId join DetailSalonServices d
	on h.TransactionId=d.TransactionId
group by c.CustomerId,CustomerName,h.TransactionId
order by [Total Treatment] desc

--7
select c.CustomerId,d.TransactionId,CustomerName,[Total Price]=sum(t.Price)
from MsCustomer c join HeaderSalonServices h
	on c.CustomerId=h.CustomerId join DetailSalonServices d
	on h.TransactionId=d.TransactionId join MsTreatment t
	on d.TreatmentId=t.TreatmentId ,
	(select avg(pr)as a
	 from (	select h.TransactionId,sum(price) as pr
			from HeaderSalonServices h join DetailSalonServices d
			on h.TransactionId=d.TransactionId join MsTreatment t
			on d.TreatmentId=t.TreatmentId
	group by h.TransactionId)as x) as b
group by c.CustomerId,d.TransactionId,CustomerName,b.a
having  sum(price)>b.a
order by [Total Price] desc

--8
select [Display Name]='Mr. '+StaffName,StaffPosition,StaffSalary
from MsStaff
where StaffGender ='Male'
union
select [Display Name]='Ms. '+StaffName,StaffPosition,StaffSalary
from MsStaff
where StaffGender ='Female'
ORDER BY [Display Name],StaffPosition

--9
select TreatmentName,Price='Rp. '+ cast(price as varchar),Status='Maximum Price'
from MsTreatment,(select max(price)as mx from MsTreatment)as x
where Price = x.mx
union
select TreatmentName,Price='Rp. '+ cast(price as varchar),Status='Minimum Price'
from MsTreatment,(select min(price)as mn from MsTreatment)as y
where Price = y.mn

--10
select [Longest Name of Staff and Customer]=CustomerName,[Length of Name]=len(customername),Status='Customer'
from MsCustomer,(select max(len(customername))as mx from MsCustomer) as x
where len(customername)=x.mx
union
select [Longest Name of Staff and Customer]=StaffName,[Length of Name]=len(StaffName),Status='staff'
from MsStaff,(select max(len(StaffName))as mn from MsStaff) as y
where len(StaffName)=y.mn













