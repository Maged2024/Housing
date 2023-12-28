--Standardize Date Format

SELECT CONVERT(DATE,SaleDate) AS DATE_CONVERTED
FROM NASH
UPDATE  NASH
SET SaleDate  = CONVERT(DATE,SaleDate)
SELECT *
FROM NASH
UPDATE  NASH
SET DATE_CONVERTEDDATE  = SaleDate

-- Populate Property Address data

SELECT A.ParcelID ,A.PropertyAddress,B.ParcelID ,B.PropertyAddress
FROM NASH A
JOIN NASH B
ON A.ParcelID  =B.ParcelID 
AND A.UniqueID <>B.UniqueID 
WHERE A.PropertyAddress IS NULL

SELECT *
FROM dbo.NASH 
WHERE PropertyAddress IS NULL

UPDATE A
SET PropertyAddress = B.PropertyAddress
FROM NASH A
JOIN NASH B
ON A.ParcelID  =B.ParcelID 
AND A.UniqueID <>B.UniqueID 


SELECT PropertyAddress
FROM NASH




-- Breaking out Address into Individual Columns (Address, City, State)

SELECT SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)AS ADDRESS,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))AS ADDRESS
FROM NASH


ALTER TABLE NASH
ADD ADDRESS1 NVARCHAR(225)
UPDATE NASH 
SET ADDRESS1 = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)


ALTER TABLE NASH
ADD ADDRESS2 NVARCHAR(225)
UPDATE NASH 
SET ADDRESS2 =SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))



-- Breaking out Owner Address
Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From NASH
ALTER TABLE NASH
ADD OWNERADDRESS1 NVARCHAR(225)
UPDATE NASH 
SET OWNERADDRESS1 = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE NASH
ADD OWNERADDRESS2 NVARCHAR(225)

UPDATE NASH 
SET OWNERADDRESS2 = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE NASH
ADD OWNERADDRESS3 NVARCHAR(225)
UPDATE NASH 
SET OWNERADDRESS3 = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



-- Change Y and N to Yes and No in "Sold as Vacant" field
SELECT SoldAsVacant ,
  CASE WHEN SoldAsVacant ='N'THEN 'No'
       WHEN SoldAsVacant = 'Y' THEN 'Yes'
       ELSE SoldAsVacant
       END
FROM NASH

UPDATE NASH 
SET SoldAsVacant =CASE WHEN SoldAsVacant ='N'THEN 'No'
       WHEN SoldAsVacant = 'Y' THEN 'Yes'
       ELSE SoldAsVacant
       END


-- Delete Unused Columns
SELECT *
FROM NASH
ALTER TABLE NASH
DROP COLUMN OwnerAddress , SaleDate , PropertyAddress




SELECT COUNT(DISTINCT UniqueID )

FROM NASH




SELECT COUNT( UniqueID )

FROM NASH