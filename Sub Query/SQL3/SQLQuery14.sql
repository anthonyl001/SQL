--1
SELECT TreatmentId,TreatmentName
FROM MsTreatment
WHERE TreatmentId in('TM001','TM002')

--2
SELECT TreatmentName,Price
FROM MsTreatment  t
WHERE TreatmentTypeId in(
	select TreatmentTypeId from MsTreatmentType y
	where t.TreatmentTypeId=y.TreatmentTypeId and TreatmentTypeName not in ('Hair Treatment','Message / Spa')
)

--3
SELECT CustomerName,CustomerPhone,CustomerAddress
FROM MsCustomer c, HeaderSalonServices h
where c.CustomerId=h.CustomerId and
len(CustomerName)> 8 and datename(WEEKDAY,TransactionDate) in('Friday')

--4
select TreatmentTypeName,TreatmentName,Price
from MsTreatment t, MsTreatmentType y,DetailSalonServices D, HeaderSalonServices H, MsCustomer c
where t.TreatmentTypeId=y.TreatmentTypeId and t.TreatmentId=d.TreatmentId and d.TransactionId=h.TransactionId and h.CustomerId=c.CustomerId
and CustomerName like '%Putra%' and day(TransactionDate) in ('22')

--5
SELECT StaffName,CustomerName,TransactionDate=convert(varchar,TransactionDate,107)
FROM MsCustomer c, HeaderSalonServices h, MsStaff s
WHERE c.CustomerId=h.CustomerId and h.StaffId=s.StaffId and exists (
	SELECT * FROM DetailSalonServices d
	where h.TransactionId=d.TransactionId and right(TreatmentId,1) %2 =0
)

--6
select CustomerName,CustomerPhone,CustomerAddress
from MsCustomer c, HeaderSalonServices h
where exists(
	select * from MsStaff s 
	where  s.StaffId=h.StaffId and h.CustomerId= c.CustomerId and len(StaffName) %2=1
)

--7
SELECT DisplayID=RIGHT(StaffId,3),Name= substring(StaffName,CHARINDEX(' ',StaffName)+1,charindex(' ',StaffName,CHARINDEX(' ',StaffName))+1)
FROM MsStaff
where StaffName like '% % %' and exists(
	select * from MsCustomer 
	WHERE CustomerGender NOT LIKE 'Male'
)

--10
SELECT CustomerName,CustomerPhone,CustomerAddress,ts
FROM MsCustomer,
	(	select TransactionId,count(TreatmentId)as ts 
		from DetailSalonServices
		group by TransactionId) as jumlahtreatment,
	(
		SELECT MAX(jumlahtreatment.count) as mxx
		FROM (
				select TransactionId,count(TreatmentId)as [count] 
				from DetailSalonServices
				group by TransactionId
			) as jumlahtreatment
	) AS terbanyak
where ts=terbanyak.mxx
