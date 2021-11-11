CREATE DATABASE project3;
USE project3;


--cleaning data

--selecting the table for analysis and data cleaning

SELECT *
FROM housingdata;

--Standardize Date Format

SELECT saledate
FROM housingdata;


SELECT saledate, CONVERT(date,saledate)
FROM housingdata;

UPDATE housingdata
SET saledate = CONVERT(date,saledate)


ALTER TABLE housingdata
ADD salesdateconverted date;

UPDATE housingdata
SET salesdateconverted = CONVERT(date,saledate);

--filling null values in propertyaddress column with self join

SELECT PropertyAddress
FROM housingdata
WHERE PropertyAddress IS NULL;

SELECT a.ParcelID,a.PropertyAddress,
b.ParcelID, b.ParcelID,
ISNULL(a.propertyaddress, b.PropertyAddress)
FROM project3.dbo.housingdata AS a
JOIN project3.dbo.housingdata AS b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

UPDATE a
SET PropertyAddress = ISNULL(a.propertyaddress, b.PropertyAddress)
FROM project3.dbo.housingdata AS a
JOIN project3.dbo.housingdata AS b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

/* Conclusion
As there are multiple owners 
with more than one property address and
with the help of self joins we have filled
the property column where there is null
*/

--spliting property Address column

SELECT
SUBSTRING(propertyaddress,1, CHARINDEX(',',propertyaddress) - 1) AS Address,
SUBSTRING(propertyaddress, CHARINDEX(',',propertyaddress)+1 ,
LEN(propertyAddress)) AS Address
FROM housingdata;

ALTER TABLE housingdata
ADD propertyspiltaddress Nvarchar(235);

UPDATE housingdata
SET propertyspiltaddress = SUBSTRING(propertyaddress,1,
CHARINDEX(',',propertyaddress) - 1);

ALTER TABLE housingdata
ADD property_city Nvarchar(235);

UPDATE housingdata
SET property_city = SUBSTRING(propertyaddress,
CHARINDEX(',',propertyaddress)+1 ,
LEN(propertyAddress));

--spliting owner address column

SELECT
PARSENAME(REPLACE(owneraddress, ',', '.') , 3),
PARSENAME(REPLACE(owneraddress, ',', '.') , 2),
PARSENAME(REPLACE(owneraddress, ',', '.') , 1)
FROM housingdata;

ALTER TABLE housingdata
ADD ownersplitaddress Nvarchar(235);

UPDATE housingdata
SET ownersplitaddress = PARSENAME(REPLACE(owneraddress, ',', '.') , 3);

ALTER TABLE housingdata
ADD ownersplitcity Nvarchar(235);

UPDATE housingdata
SET ownersplitcity =PARSENAME(REPLACE(owneraddress, ',', '.') , 2);


ALTER TABLE housingdata
ADD ownersplitstate Nvarchar(235);

UPDATE housingdata
SET ownersplitstate = PARSENAME(REPLACE(owneraddress, ',', '.') , 1);

--changing Y and N to yes and No in 'sold as vacant' column

SELECT DISTINCT(Soldasvacant), COUNT(soldasvacant) as a 
FROM housingdata
GROUP BY SoldAsVacant
ORDER BY a


UPDATE housingdata
SET SoldAsVacant = 'Yes'
WHERE SoldAsVacant = 'Y';

UPDATE housingdata
SET SoldAsVacant = 'No'
WHERE SoldAsVacant = 'N';

--removing duplicates

WITH  dupvalueCTE AS(
SELECT *,
     ROW_NUMBER() OVER(
	 PARTITION BY parcelID,
	 propertyaddress,saleprice,
	 saledate,legalreference
	 ORDER BY uniqueID
	   ) AS dup_value
from housingdata);


 --SELECT *
 --FROM dupvalueCTE
 --WHERE dup_value >1


 DELETE
 FROM dupvalueCTE
 WHERE dup_value >1;

 /* Conclusion
 we are not deleting the real data as 
 it is not recommended
 */

 --Deleting unused columns

 SELECT *
 FROM housingdata;

 ALTER TABLE housingdata
 DROP COLUMN saledate, owneraddress,
 taxdistrict, propertyaddress 

 --data cleaned for better analysis