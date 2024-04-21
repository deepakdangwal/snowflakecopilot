create schema dbo;

CREATE OR REPLACE TABLE dbo.DimProductCategory
(
ProductCategoryKey INTEGER,
ProductCategoryAlternateKey INTEGER,
EnglishProductCategoryName VARCHAR(50),
SpanishProductCategoryName VARCHAR(50),
FrenchProductCategoryName VARCHAR(50),
primary key (ProductCategoryKey)
);

CREATE OR REPLACE TABLE dbo.DimProductSubcategory
(
ProductSubcategoryKey INTEGER,
ProductSubcategoryAlternateKey INTEGER,
EnglishProductSubcategoryName VARCHAR(50),
SpanishProductSubcategoryName VARCHAR(50),
FrenchProductSubcategoryName VARCHAR(50),
ProductCategoryKey INTEGER,
primary key (ProductSubcategoryKey),
CONSTRAINT FK_DimProductSubcategory_DimProductCategory_ProductCategoryKey FOREIGN KEY (ProductCategoryKey) REFERENCES dbo.DimProductCategory(ProductCategoryKey)
);

CREATE OR REPLACE TABLE dbo.DimSalesTerritory
(
SalesTerritoryKey INTEGER,
SalesTerritoryAlternateKey INTEGER,
SalesTerritoryRegion VARCHAR(50),
SalesTerritoryCountry VARCHAR(50),
SalesTerritoryGroup VARCHAR(50),
SalesTerritoryImage BINARY,
primary key (SalesTerritoryKey)
);

CREATE OR REPLACE TABLE dbo.DimGeography
(
GeographyKey INTEGER,
City VARCHAR(30),
StateProvinceCode VARCHAR(3),
StateProvinceName VARCHAR(50),
CountryRegionCode VARCHAR(3),
EnglishCountryRegionName VARCHAR(50),
SpanishCountryRegionName VARCHAR(50),
FrenchCountryRegionName VARCHAR(50),
PostalCode VARCHAR(15),
SalesTerritoryKey INTEGER,
IpAddressLocator VARCHAR(15),
primary key (GeographyKey),
CONSTRAINT FK_DimGeography_DimSalesTerritory_SalesTerritoryKey FOREIGN KEY (SalesTerritoryKey) REFERENCES dbo.DimSalesTerritory(SalesTerritoryKey)
);

CREATE OR REPLACE TABLE dbo.DimAccount
(
AccountKey INTEGER,
ParentAccountKey INTEGER,
AccountCodeAlternateKey INTEGER,
ParentAccountCodeAlternateKey INTEGER,
AccountDescription VARCHAR(50),
AccountType VARCHAR(50),
Operator VARCHAR(50),
CustomMembers VARCHAR(300),
ValueType VARCHAR(50),
CustomMemberOptions VARCHAR(200),
primary key (AccountKey),
CONSTRAINT FK_DimAccount_DimAccount_ParentAccountKey FOREIGN KEY (ParentAccountKey) REFERENCES dbo.DimAccount(AccountKey)
);

CREATE OR REPLACE TABLE dbo.DimCurrency
(
CurrencyKey INTEGER,
CurrencyAlternateKey VARCHAR(3),
CurrencyName VARCHAR(50),
primary key (CurrencyKey)
);

CREATE OR REPLACE TABLE dbo.DimCustomer
(
CustomerKey INTEGER,
GeographyKey INTEGER,
CustomerAlternateKey VARCHAR(15),
Title VARCHAR(8),
FirstName VARCHAR(50),
MiddleName VARCHAR(50),
LastName VARCHAR(50),
NameStyle BOOLEAN,
BirthDate DATE,
MaritalStatus VARCHAR(1),
Suffix VARCHAR(10),
Gender VARCHAR(1),
EmailAddress VARCHAR(50),
YearlyIncome NUMERIC(38,2),
TotalChildren INTEGER,
NumberChildrenAtHome INTEGER,
EnglishEducation VARCHAR(40),
SpanishEducation VARCHAR(40),
FrenchEducation VARCHAR(40),
EnglishOccupation VARCHAR(100),
SpanishOccupation VARCHAR(100),
FrenchOccupation VARCHAR(100),
HouseOwnerFlag VARCHAR(1),
NumberCarsOwned INTEGER,
AddressLine1 VARCHAR(120),
AddressLine2 VARCHAR(120),
Phone VARCHAR(20),
DateFirstPurchase DATETIME,
CommuteDistance VARCHAR(15),
primary key (CustomerKey),
CONSTRAINT FK_DimCustomer_DimGeography_GeographyKey FOREIGN KEY (GeographyKey) REFERENCES dbo.DimGeography(GeographyKey)
);

CREATE OR REPLACE TABLE dbo.DimDate
(
DateKey INTEGER,
FullDateAlternateKey DATE,
DayNumberOfWeek INTEGER,
EnglishDayNameOfWeek VARCHAR(10),
SpanishDayNameOfWeek VARCHAR(10),
FrenchDayNameOfWeek VARCHAR(10),
DayNumberOfMonth INTEGER,
DayNumberOfYear INTEGER,
WeekNumberOfYear INTEGER,
EnglishMonthName VARCHAR(10),
SpanishMonthName VARCHAR(10),
FrenchMonthName VARCHAR(10),
MonthNumberOfYear INTEGER,
CalendarQuarter INTEGER,
CalendarYear INTEGER,
CalendarSemester INTEGER,
FiscalQuarter INTEGER,
FiscalYear INTEGER,
FiscalSemester INTEGER,
primary key (DateKey)
);

CREATE OR REPLACE TABLE dbo.DimDepartmentGroup
(
DepartmentGroupKey INTEGER,
ParentDepartmentGroupKey INTEGER,
DepartmentGroupName VARCHAR(50),
primary key (DepartmentGroupKey),
CONSTRAINT FK_DimDepartmentGroup_DimDepartmentGroup_ParentDepartmentGroupKey FOREIGN KEY (ParentDepartmentGroupKey) REFERENCES dbo.DimDepartmentGroup(DepartmentGroupKey)
);

CREATE OR REPLACE TABLE dbo.DimEmployee
(
EmployeeKey INTEGER,
ParentEmployeeKey INTEGER,
EmployeeNationalIDAlternateKey VARCHAR(15),
ParentEmployeeNationalIDAlternateKey VARCHAR(15),
SalesTerritoryKey INTEGER,
FirstName VARCHAR(50),
LastName VARCHAR(50),
MiddleName VARCHAR(50),
NameStyle BOOLEAN,
Title VARCHAR(50),
HireDate DATE,
BirthDate DATE,
LoginID VARCHAR(256),
EmailAddress VARCHAR(50),
Phone VARCHAR(25),
MaritalStatus VARCHAR(1),
EmergencyContactName VARCHAR(50),
EmergencyContactPhone VARCHAR(25),
SalariedFlag BOOLEAN,
Gender VARCHAR(1),
PayFrequency INTEGER,
BaseRate NUMERIC(38,2),
VacationHours INTEGER,
SickLeaveHours INTEGER,
CurrentFlag BOOLEAN,
SalesPersonFlag BOOLEAN,
DepartmentName VARCHAR(50),
StartDate DATE,
EndDate DATE,
Status VARCHAR(50),
EmployeePhoto BINARY,
primary key (EmployeeKey),
CONSTRAINT FK_DimEmployee_DimEmployee_ParentEmployeeKey FOREIGN KEY (ParentEmployeeKey) REFERENCES dbo.DimEmployee(EmployeeKey),
CONSTRAINT FK_DimEmployee_DimSalesTerritory_SalesTerritoryKey FOREIGN KEY (SalesTerritoryKey) REFERENCES dbo.DimSalesTerritory(SalesTerritoryKey)
);


CREATE OR REPLACE TABLE dbo.DimOrganization
(
OrganizationKey INTEGER,
ParentOrganizationKey INTEGER,
PercentageOfOwnership VARCHAR(16),
OrganizationName VARCHAR(50),
CurrencyKey INTEGER,
primary key (OrganizationKey),
CONSTRAINT FK_DimOrganization_DimOrganization_ParentOrganizationKey FOREIGN KEY (ParentOrganizationKey) REFERENCES dbo.DimOrganization(OrganizationKey),
CONSTRAINT FK_DimOrganization_DimCurrency_CurrencyKey FOREIGN KEY (CurrencyKey) REFERENCES dbo.DimCurrency(CurrencyKey)
);

CREATE OR REPLACE TABLE dbo.DimProduct
(
ProductKey INTEGER,
ProductAlternateKey VARCHAR(25),
ProductSubcategoryKey INTEGER,
WeightUnitMeasureCode VARCHAR(3),
SizeUnitMeasureCode VARCHAR(3),
EnglishProductName VARCHAR(50),
SpanishProductName VARCHAR(50),
FrenchProductName VARCHAR(50),
StandardCost NUMERIC(38,2),
FinishedGoodsFlag BOOLEAN,
Color VARCHAR(15),
SafetyStockLevel INTEGER,
ReorderPoint INTEGER,
ListPrice NUMERIC(38,2),
Size VARCHAR(50),
SizeRange VARCHAR(50),
Weight FLOAT,
DaysToManufacture INTEGER,
ProductLine VARCHAR(2),
DealerPrice NUMERIC(38,2),
Class VARCHAR(2),
Style VARCHAR(2),
ModelName VARCHAR(50),
LargePhoto BINARY,
EnglishDescription VARCHAR(400),
FrenchDescription VARCHAR(400),
ChineseDescription VARCHAR(400),
ArabicDescription VARCHAR(400),
HebrewDescription VARCHAR(400),
ThaiDescription VARCHAR(400),
GermanDescription VARCHAR(400),
JapaneseDescription VARCHAR(400),
TurkishDescription VARCHAR(400),
StartDate DATETIME,
EndDate DATETIME,
Status VARCHAR(7),
primary key (ProductKey),
CONSTRAINT FK_DimProduct_DimProductSubcategory_ProductSubcategoryKey FOREIGN KEY (ProductSubcategoryKey) REFERENCES dbo.DimProductSubcategory(ProductSubcategoryKey)
);



CREATE OR REPLACE TABLE dbo.DimPromotion
(
PromotionKey INTEGER,
PromotionAlternateKey INTEGER,
EnglishPromotionName VARCHAR(255),
SpanishPromotionName VARCHAR(255),
FrenchPromotionName VARCHAR(255),
DiscountPct FLOAT,
EnglishPromotionType VARCHAR(50),
SpanishPromotionType VARCHAR(50),
FrenchPromotionType VARCHAR(50),
EnglishPromotionCategory VARCHAR(50),
SpanishPromotionCategory VARCHAR(50),
FrenchPromotionCategory VARCHAR(50),
StartDate DATETIME,
EndDate DATETIME,
MinQty INTEGER,
MaxQty INTEGER,
primary key (PromotionKey)
);

CREATE OR REPLACE TABLE dbo.DimReseller
(
ResellerKey INTEGER,
GeographyKey INTEGER,
ResellerAlternateKey VARCHAR(15),
Phone VARCHAR(25),
BusinessType VARCHAR(20),
ResellerName VARCHAR(50),
NumberEmployees INTEGER,
OrderFrequency VARCHAR(1),
OrderMonth INTEGER,
FirstOrderYear INTEGER,
LastOrderYear INTEGER,
ProductLine VARCHAR(50),
AddressLine1 VARCHAR(60),
AddressLine2 VARCHAR(60),
AnnualSales NUMERIC(38,2),
BankName VARCHAR(50),
MinPaymentType INTEGER,
MinPaymentAmount NUMERIC(38,2),
AnnualRevenue NUMERIC(38,2),
YearOpened INTEGER,
primary key (ResellerKey),
CONSTRAINT FK_DimReseller_DimGeography_GeographyKey FOREIGN KEY (GeographyKey) REFERENCES dbo.DimGeography(GeographyKey)
);

CREATE OR REPLACE TABLE dbo.DimSalesReason
(
SalesReasonKey INTEGER,
SalesReasonAlternateKey INTEGER,
SalesReasonName VARCHAR(50),
SalesReasonReasonType VARCHAR(50),
primary key (SalesReasonKey)
);



CREATE OR REPLACE TABLE dbo.DimScenario
(
ScenarioKey INTEGER,
ScenarioName VARCHAR(50),
primary key (ScenarioKey)
);

CREATE OR REPLACE TABLE dbo.FactAdditionalInternationalProductDescription
(
ProductKey INTEGER,
CultureName VARCHAR(50),
ProductDescription VARCHAR(10000),
primary key (ProductKey,CultureName)
);

CREATE OR REPLACE TABLE dbo.FactCallCenter
(
FactCallCenterID INTEGER,
DateKey INTEGER,
WageType VARCHAR(15),
Shift VARCHAR(20),
LevelOneOperators INTEGER,
LevelTwoOperators INTEGER,
TotalOperators INTEGER,
Calls INTEGER,
AutomaticResponses INTEGER,
Orders INTEGER,
IssuesRaised INTEGER,
AverageTimePerIssue INTEGER,
ServiceGrade FLOAT,
Date DATETIME,
primary key (FactCallCenterID),
CONSTRAINT FK_FactCallCenter_DimDate_DateKey FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey)
);

CREATE OR REPLACE TABLE dbo.FactCurrencyRate
(
CurrencyKey INTEGER,
DateKey INTEGER,
AverageRate FLOAT,
EndOfDayRate FLOAT,
Date DATETIME,
primary key (CurrencyKey,DateKey),
CONSTRAINT FK_FactCurrencyRate_DimCurrency_CurrencyKey FOREIGN KEY (CurrencyKey) REFERENCES dbo.DimCurrency(CurrencyKey),
CONSTRAINT FK_FactCurrencyRate_DimDate_DateKey FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey)
);

CREATE OR REPLACE TABLE dbo.FactFinance
(
FinanceKey INTEGER,
DateKey INTEGER,
OrganizationKey INTEGER,
DepartmentGroupKey INTEGER,
ScenarioKey INTEGER,
AccountKey INTEGER,
Amount FLOAT,
Date DATETIME
,
CONSTRAINT FK_FactFinance_DimDate_DateKey FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_FactFinance_DimOrganization_OrganizationKey FOREIGN KEY (OrganizationKey) REFERENCES dbo.DimOrganization(OrganizationKey),
CONSTRAINT FK_FactFinance_DimDepartmentGroup_DepartmentGroupKey FOREIGN KEY (DepartmentGroupKey) REFERENCES dbo.DimDepartmentGroup(DepartmentGroupKey),
CONSTRAINT FK_FactFinance_DimScenario_ScenarioKey FOREIGN KEY (ScenarioKey) REFERENCES dbo.DimScenario(ScenarioKey),
CONSTRAINT FK_FactFinance_DimAccount_AccountKey FOREIGN KEY (AccountKey) REFERENCES dbo.DimAccount(AccountKey)
);

CREATE OR REPLACE TABLE dbo.FactInternetSales
(
ProductKey INTEGER,
OrderDateKey INTEGER,
DueDateKey INTEGER,
ShipDateKey INTEGER,
CustomerKey INTEGER,
PromotionKey INTEGER,
CurrencyKey INTEGER,
SalesTerritoryKey INTEGER,
SalesOrderNumber VARCHAR(20),
SalesOrderLineNumber INTEGER,
RevisionNumber INTEGER,
OrderQuantity INTEGER,
UnitPrice NUMERIC(38,2),
ExtendedAmount NUMERIC(38,2),
UnitPriceDiscountPct FLOAT,
DiscountAmount FLOAT,
ProductStandardCost NUMERIC(38,2),
TotalProductCost NUMERIC(38,2),
SalesAmount NUMERIC(38,2),
TaxAmt NUMERIC(38,2),
Freight NUMERIC(38,2),
CarrierTrackingNumber VARCHAR(25),
CustomerPONumber VARCHAR(25),
OrderDate DATETIME,
DueDate DATETIME,
ShipDate DATETIME,
primary key (SalesOrderNumber,SalesOrderLineNumber),
CONSTRAINT FK_FactInternetSales_DimProduct_ProductKey FOREIGN KEY (ProductKey) REFERENCES dbo.DimProduct(ProductKey),
CONSTRAINT FK_FactInternetSales_DimDate_OrderDateKey FOREIGN KEY (OrderDateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_FactInternetSales_DimDate_DueDateKey FOREIGN KEY (DueDateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_FactInternetSales_DimDate_ShipDateKey FOREIGN KEY (ShipDateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_FactInternetSales_DimCustomer_CustomerKey FOREIGN KEY (CustomerKey) REFERENCES dbo.DimCustomer(CustomerKey),
CONSTRAINT FK_FactInternetSales_DimPromotion_PromotionKey FOREIGN KEY (PromotionKey) REFERENCES dbo.DimPromotion(PromotionKey),
CONSTRAINT FK_FactInternetSales_DimCurrency_CurrencyKey FOREIGN KEY (CurrencyKey) REFERENCES dbo.DimCurrency(CurrencyKey),
CONSTRAINT FK_FactInternetSales_DimSalesTerritory_SalesTerritoryKey FOREIGN KEY (SalesTerritoryKey) REFERENCES dbo.DimSalesTerritory(SalesTerritoryKey)
);

CREATE OR REPLACE TABLE dbo.FactInternetSalesReason
(
SalesOrderNumber VARCHAR(20),
SalesOrderLineNumber INTEGER,
SalesReasonKey INTEGER,
primary key (SalesOrderNumber,SalesOrderLineNumber,SalesReasonKey),
CONSTRAINT FK_FactInternetSalesReason_FactInternetSales_SalesOrderNumber FOREIGN KEY (SalesOrderNumber,SalesOrderLineNumber) REFERENCES dbo.FactInternetSales(SalesOrderNumber,SalesOrderLineNumber),
CONSTRAINT FK_FactInternetSalesReason_DimSalesReason_SalesReasonKey FOREIGN KEY (SalesReasonKey) REFERENCES dbo.DimSalesReason(SalesReasonKey)
);

CREATE OR REPLACE TABLE dbo.FactProductInventory
(
ProductKey INTEGER,
DateKey INTEGER,
MovementDate DATE,
UnitCost NUMERIC(38,2),
UnitsIn INTEGER,
UnitsOut INTEGER,
UnitsBalance INTEGER,
primary key (ProductKey,DateKey),
CONSTRAINT FK_FactProductInventory_DimProduct_ProductKey FOREIGN KEY (ProductKey) REFERENCES dbo.DimProduct(ProductKey),
CONSTRAINT FK_FactProductInventory_DimDate_DateKey FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey)
);

CREATE OR REPLACE TABLE dbo.FactResellerSales
(
ProductKey INTEGER,
OrderDateKey INTEGER,
DueDateKey INTEGER,
ShipDateKey INTEGER,
ResellerKey INTEGER,
EmployeeKey INTEGER,
PromotionKey INTEGER,
CurrencyKey INTEGER,
SalesTerritoryKey INTEGER,
SalesOrderNumber VARCHAR(20),
SalesOrderLineNumber INTEGER,
RevisionNumber INTEGER,
OrderQuantity INTEGER,
UnitPrice NUMERIC(38,2),
ExtendedAmount NUMERIC(38,2),
UnitPriceDiscountPct FLOAT,
DiscountAmount FLOAT,
ProductStandardCost NUMERIC(38,2),
TotalProductCost NUMERIC(38,2),
SalesAmount NUMERIC(38,2),
TaxAmt NUMERIC(38,2),
Freight NUMERIC(38,2),
CarrierTrackingNumber VARCHAR(25),
CustomerPONumber VARCHAR(25),
OrderDate DATETIME,
DueDate DATETIME,
ShipDate DATETIME,
primary key (SalesOrderNumber,SalesOrderLineNumber),
CONSTRAINT FK_FactResellerSales_DimProduct_ProductKey FOREIGN KEY (ProductKey) REFERENCES dbo.DimProduct(ProductKey),
CONSTRAINT FK_FactResellerSales_DimDate_OrderDateKey FOREIGN KEY (OrderDateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_FactResellerSales_DimDate_DueDateKey FOREIGN KEY (DueDateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_FactResellerSales_DimDate_ShipDateKey FOREIGN KEY (ShipDateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_FactResellerSales_DimReseller_ResellerKey FOREIGN KEY (ResellerKey) REFERENCES dbo.DimReseller(ResellerKey),
CONSTRAINT FK_FactResellerSales_DimEmployee_EmployeeKey FOREIGN KEY (EmployeeKey) REFERENCES dbo.DimEmployee(EmployeeKey),
CONSTRAINT FK_FactResellerSales_DimPromotion_PromotionKey FOREIGN KEY (PromotionKey) REFERENCES dbo.DimPromotion(PromotionKey),
CONSTRAINT FK_FactResellerSales_DimCurrency_CurrencyKey FOREIGN KEY (CurrencyKey) REFERENCES dbo.DimCurrency(CurrencyKey),
CONSTRAINT FK_FactResellerSales_DimSalesTerritory_SalesTerritoryKey FOREIGN KEY (SalesTerritoryKey) REFERENCES dbo.DimSalesTerritory(SalesTerritoryKey)
);

CREATE OR REPLACE TABLE dbo.FactSalesQuota
(
SalesQuotaKey INTEGER,
EmployeeKey INTEGER,
DateKey INTEGER,
CalendarYear INTEGER,
CalendarQuarter INTEGER,
SalesAmountQuota NUMERIC(38,2),
Date DATETIME,
primary key (SalesQuotaKey),
CONSTRAINT FK_FactSalesQuota_DimEmployee_EmployeeKey FOREIGN KEY (EmployeeKey) REFERENCES dbo.DimEmployee(EmployeeKey),
CONSTRAINT FK_FactSalesQuota_DimDate_DateKey FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey)
);

CREATE OR REPLACE TABLE dbo.FactSurveyResponse
(
SurveyResponseKey INTEGER,
DateKey INTEGER,
CustomerKey INTEGER,
ProductCategoryKey INTEGER,
EnglishProductCategoryName VARCHAR(50),
ProductSubcategoryKey INTEGER,
EnglishProductSubcategoryName VARCHAR(50),
Date DATETIME,
primary key (SurveyResponseKey),
CONSTRAINT FK_FactSurveyResponse_DimDate_DateKey FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_FactSurveyResponse_DimCustomer_CustomerKey FOREIGN KEY (CustomerKey) REFERENCES dbo.DimCustomer(CustomerKey)
);

CREATE OR REPLACE TABLE dbo.NewFactCurrencyRate
(
AverageRate REAL,
CurrencyID VARCHAR(3),
CurrencyDate DATE,
EndOfDayRate REAL,
CurrencyKey INTEGER,
DateKey INTEGER

);

CREATE OR REPLACE TABLE dbo.ProspectiveBuyer
(
ProspectiveBuyerKey INTEGER,
ProspectAlternateKey VARCHAR(15),
FirstName VARCHAR(50),
MiddleName VARCHAR(50),
LastName VARCHAR(50),
BirthDate DATETIME,
MaritalStatus VARCHAR(1),
Gender VARCHAR(1),
EmailAddress VARCHAR(50),
YearlyIncome NUMERIC(38,2),
TotalChildren INTEGER,
NumberChildrenAtHome INTEGER,
Education VARCHAR(40),
Occupation VARCHAR(100),
HouseOwnerFlag VARCHAR(1),
NumberCarsOwned INTEGER,
AddressLine1 VARCHAR(120),
AddressLine2 VARCHAR(120),
City VARCHAR(30),
StateProvinceCode VARCHAR(3),
PostalCode VARCHAR(15),
Phone VARCHAR(20),
Salutation VARCHAR(8),
Unknown INTEGER,
primary key (ProspectiveBuyerKey)
);
