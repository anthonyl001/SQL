--1
SELECT [Maximum Price]=MAX(Price),[Minimum Price]=MIN(Price),[Average Price]=CAST(ROUND(AVG(Price),3) AS  NUMERIC(10,2))
FROM MsTreatment

--2
SELECT StaffPosition,Gender=LEFT(StaffGender,1),[Average Salary]='Rp. '+ CAST(CAST(AVG(StaffSalary) AS numeric(10,2)) AS varchar)
FROM MsStaff
GROUP BY StaffPosition,StaffGender

--3
SELECT [TransactionDate]=CONVERT(varchar,TransactionDate,107),[Total Transaction per Day]=COUNT(TransactionID)
FROM HeaderSalonServices
GROUP BY TransactionDate

--4
SELECT CustomerGender=UPPER(CustomerGender),[Total Transaction]=COUNT(TransactionID)
FROM MsCustomer c JOIN HeaderSalonServices h on c.CustomerId=h.CustomerId
GROUP BY CustomerGender

--5
SELECT TreatmentTypeName,[Total Transaction]=COUNT(h.TransactionId)
FROM HeaderSalonServices h JOIN DetailSalonServices D
	ON h.TransactionId=D.TransactionId JOIN MsTreatment t
	on d.TreatmentId=t.TreatmentId JOIN MsTreatmentType mt
	ON t.TreatmentTypeId=mt.TreatmentTypeId
GROUP BY TreatmentTypeName
ORDER BY [Total Transaction] DESC

--6
SELECT [Date]=CONVERT(VARCHAR,TransactionDate,106),[Revenue]='Rp. '+CAST(SUM(Price) AS varchar)
FROM HeaderSalonServices h join DetailSalonServices d
	ON h.TransactionId=d.TransactionId JOIN MsTreatment t
	ON d.TreatmentId=t.TreatmentId
GROUP BY TransactionDate
HAVING SUM(Price) BETWEEN 1000000 AND 5000000

--7
SELECT [Display ID]=REPLACE(t.TreatmentTypeId,'TT0','Treatment Type '),TreatmentTypeName,[Total Treatment per Type]=CAST(COUNT(t.TreatmentTypeId) AS varchar)+' Treatment'
FROM MsTreatment t JOIN MsTreatmentType y on t.TreatmentTypeId=y.TreatmentTypeId
GROUP BY TreatmentTypeName,T.TreatmentTypeId
HAVING COUNT(t.TreatmentTypeId) >5

--8
SELECT StaffName=LEFT(StaffName,CHARINDEX(' ',StaffName)-1),h.TransactionId,[Total Treatment per Transaction]=COUNT(t.TreatmentId)
FROM MsStaff s JOIN HeaderSalonServices h 
	on s.StaffId=h.StaffId JOIN DetailSalonServices d	
	ON h.TransactionId=d.TransactionId JOIN MsTreatment t
	ON d.TreatmentId=t.TreatmentId
GROUP BY h.TransactionId ,StaffName

--9
SELECT TransactionDate,CustomerName,TreatmentName,Price
FROM MsCustomer c JOIN HeaderSalonServices h
	ON c.CustomerId=h.CustomerId JOIN DetailSalonServices d
	ON h.TransactionId=d.TransactionId JOIN MsTreatment t
	ON d.TreatmentId=t.TreatmentId JOIN MsStaff f
	ON H.StaffId=f.StaffId
WHERE DATENAME(WEEKDAY,TransactionDate)='Thursday' and StaffName LIKE '%Ryan%'
ORDER BY TransactionDate,CustomerName

--10
SELECT TransactionDate,CustomerName,TotalPrice=SUM(Price)
FROM MsCustomer c JOIN HeaderSalonServices h
	ON c.CustomerId=h.CustomerId JOIN MsStaff s
	ON s.StaffId=h.StaffId JOIN DetailSalonServices d
	ON h.TransactionId=d.TransactionId JOIN MsTreatment tr
	ON d.TreatmentId=tr.TreatmentId
WHERE DAY(TransactionDate)>'20'
GROUP BY CustomerName,TransactionDate
ORDER BY TransactionDate 

SELECT * FROM MsStaff
select * from HeaderSalonServices
SELECT * from MsTreatment
select COUNT(TreatmentTypeId) from MsTreatmentType



	



select * from HeaderSalonServices
SELECT * FROM DetailSalonServices
