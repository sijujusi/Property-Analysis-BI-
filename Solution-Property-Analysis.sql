
--Q1a)Display a list of all property names and their property id’s for Owner Id: 1426.

select OP.OwnerId, P.ID as PropertyID, P.Name as PropertyName, PT.Name as PropertyTypeName
From OwnerProperty OP
Join Property P on OP.PropertyId=P.Id
Join PropertyType PT on P.PropertyTypeId = PT.PropertyTypeId
where OwnerId = 1426

--Q1b)Display the current home value for each property in question a). 
select OP.OwnerId, P.ID as PropertyID, P.Name as PropertyName, PHV.Value as PropertyValue, PHV.Date, PHVT.HomeValueType
From OwnerProperty OP
Join Property P on OP.PropertyId=P.Id
Join PropertyHomeValue PHV on P.ID = PHV.PropertyId
Join PropertyHomeValueType PHVT on PHV.HomeValueTypeId = PHVT.Id
where OwnerId = 1426

--Q1c)For each property in question a), return the following:                                                                      
--Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
--Display the yield. 
select OP.OwnerId, P.ID as PropertyID, P.Name as PropertyName, TP.TenantId, TP.StartDate, TP.EndDate, TP.PaymentAmount, PRP.Date, PRP.FrequencyType, TPF.Name as Frequency, PF.Yield,
CASE
        WHEN TPF.Name = 'Weekly'
        THEN DATEDIFF(Week, TP.StartDate, TP.EndDate)*TP.PaymentAmount
		WHEN TPF.Name = 'Fortnightly'
        THEN DATEDIFF(Week, TP.StartDate, TP.EndDate)*TP.PaymentAmount/2
		WHEN TPF.Name = 'Monthly'
        THEN DATEDIFF(Month, TP.StartDate, TP.EndDate)*TP.PaymentAmount
END as TotalPayment
From OwnerProperty OP
Join Property P on OP.PropertyId=P.Id
Join TenantProperty TP on P.ID = TP.PropertyId
Join PropertyFinance PF on P.ID = PF.PropertyId
Join PropertyRentalPayment PRP on TP.PropertyId = PRP.PropertyId
Join TenantPaymentFrequencies TPF on PRP.FrequencyType = TPF.Id
where OwnerId = 1426

--Display all the jobs available

select OP.OwnerId, P.ID as PropertyID, P.Name as PropertyName, TJR.JobDescription, Rs.Name
From OwnerProperty OP
Join Property P on OP.PropertyId=P.Id
Join TenantJobRequest TJR on P.ID = TJR.PropertyId
Join RequestStatus RS on TJR.JobStatusId = RS.Id
where OP.OwnerId = 1426

--Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a).

select OP.OwnerId, P.ID as PropertyID, P.Name as PropertyName, TP.TenantId, TP.PaymentAmount, TPF.Name as Frequency, PP.FirstName, PP.LastName 
From OwnerProperty OP
Join Property P on OP.PropertyId=P.Id
Join TenantProperty TP on P.ID = TP.PropertyId
Join PropertyRentalPayment PRP on TP.PropertyId = PRP.PropertyId
Join TenantPaymentFrequencies TPF on PRP.FrequencyType = TPF.Id
Join Person PP on TP.TenantId = PP.Id
where OwnerId = 1426