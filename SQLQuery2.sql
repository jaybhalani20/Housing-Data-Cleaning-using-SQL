Select* 
from DataCleaning..Housing

--Standarize date format
Select SaleDate, CONVERT(date,SaleDate)
from DataCleaning..Housing

alter table DataCleaning..Housing
ADD SaleDateConvertered date

update DataCleaning..Housing 
set SaleDateConvertered = CONVERT(date,SaleDate)

--to views changes
Select SaleDateConvertered, CONVERT(date,SaleDate)
from DataCleaning..Housing



--Populate property address (where parcel ids are same but address are not)
select *
from DataCleaning..Housing
where propertyaddress is null

Select a.parcelid,b.parcelid,a.propertyaddress,b.propertyaddress,isnull(a.propertyaddress,b.propertyaddress)
from DataCleaning..housing a 
JOIN Datacleaning..housing b
on a.parcelid=b.parcelid
AND a.[UniqueID] <> b.[UniqueID]
where a.propertyaddress is null

Update a	
SET propertyaddress= isnull(a.propertyaddress,b.propertyaddress)
from DataCleaning..housing a 
JOIN Datacleaning..housing b
on a.parcelid=b.parcelid
AND a.[UniqueID] <> b.[UniqueID]
where a.propertyaddress is null

--breaking address into individual columns(Address, city,State)
select propertyaddress
from DataCleaning..Housing


Select 
substring(propertyaddress,1,CHARINDEX(',',propertyaddress)) as address
from DataCleaning..Housing




--to eliminate comma
SELECT 
    SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1) AS address,
    SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress) + 1, LEN(propertyaddress) 
	- CHARINDEX(',', propertyaddress)) AS address
FROM 
    DataCleaning..Housing;

alter table DataCleaning..Housing
ADD Propertysplitaddress nvarchar(255);

update DataCleaning..Housing 
set Propertysplitaddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1)


alter table DataCleaning..Housing
ADD Propertysplitacity nvarchar(255);

update DataCleaning..Housing 
set Propertysplitacity = SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress) + 1, LEN(propertyaddress) 
- CHARINDEX(',', propertyaddress))


select *
from DataCleaning..Housing


select OwnerAddress
from DataCleaning..Housing



--parsename is used to separate periods (remember the chronology) 
Select 
PARSENAME(REPLACE(OwnerAddress,',','.'), 3)
,PARSENAME(REPLACE(OwnerAddress,',','.'), 2)
,PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
from DataCleaning..Housing

alter table DataCleaning..Housing
ADD Ownersplitaddress nvarchar(255);

update DataCleaning..Housing 
set Ownersplitaddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)


alter table DataCleaning..Housing
ADD Ownersplitcity nvarchar(255);

update DataCleaning..Housing 
set Ownersplitcity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)


alter table DataCleaning..Housing
ADD OwnersplitState nvarchar(255);

update DataCleaning..Housing 
set OwnersplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)




--changing y to yes and n to no in soldasvacant
select distinct(SoldAsVacant),count(SoldAsVacant) 
from DataCleaning..Housing
Group by SoldAsVacant
order by 2


Select SoldAsVacant
,CASE WHEN SoldAsVacant= 'Y' THEN 'Yes'
	 WHEN SoldAsVacant= 'N' THEN 'No'
	 Else SoldAsVacant
	 End
from DataCleaning..Housing


Update DataCleaning..Housing
SET SoldAsVacant= CASE WHEN SoldAsVacant= 'Y' THEN 'Yes'
	 WHEN SoldAsVacant= 'N' THEN 'No'
	 Else SoldAsVacant
	 End



--remove duplicates
with rownumcte as(
Select *,
Row_number() over(
partition by parcelid,
		     propertyaddress,
			 saleprice,
			 saledate,
			 legalreference
			 order by
			 uniqueid
			 )row_num
from DataCleaning..Housing
)
delete
--select *( to check whether the duplicates are removed or not)
from rownumcte
where row_num>1
--order by propertyaddress






--delete unused columns
select *
from DataCleaning..Housing

alter table DataCleaning..Housing
drop column propertyaddress,owneraddress, taxdistrict, saledate