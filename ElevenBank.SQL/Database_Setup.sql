-- --------------------------------------------------
-- Dropping existing Database & Creating new
-- --------------------------------------------------
USE master;  
GO  

IF EXISTS(SELECT * from sys.databases WHERE name='Bank')  
BEGIN  
    DROP DATABASE Bank;  
END  

CREATE DATABASE Bank
GO 

USE Bank
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------
-- Creating table 'Customer'
CREATE TABLE [dbo].[Customer] (
    [CustomerID] int IDENTITY(1,1) NOT NULL,
    [SocialSecurityNumber] int NULL,
    [FirstName] nvarchar(25)  NOT NULL,
    [LastName] nvarchar(25)  NOT NULL,
    [CreatedUtc]    DATETIMEOFFSET (7) NOT NULL
);
GO

-- Creating table 'Account'
CREATE TABLE [dbo].[Account] (
    [AccountID] int IDENTITY(1,1) NOT NULL,
    [AccountNumber] nvarchar(75)  NOT NULL,
    [Pin] nvarchar(75)  NOT NULL,
    [AccountType] int  NOT NULL,
    [CustomerID] int  NOT NULL,
    [Balance] money  NULL,
    [CreatedUtc]    DATETIMEOFFSET (7) NOT NULL
);
GO

-- Creating table 'Transaction'
CREATE TABLE [dbo].[Transaction] (
    [TransactionID] int IDENTITY(1,1) NOT NULL,
    [TransactionType] int  NOT NULL,
    [AccountID] int  NOT NULL,
    [CreatedUtc]    DATETIMEOFFSET (7) NOT NULL
);
GO

-- Creating table 'Deposit'
CREATE TABLE [dbo].[Deposit] (
    [DepositID] int IDENTITY(1,1) NOT NULL,
    [TransactionID] int  NOT NULL,
    [Amount] money  NOT NULL
);
GO

-- Creating table 'Withdrawl'
CREATE TABLE [dbo].[Withdrawal] (
    [WithdrawalID] int IDENTITY(1,1) NOT NULL,
    [TransactionID] int  NOT NULL,
    [Amount] money NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [AccountID] in table 'Account'
ALTER TABLE [dbo].[Account]
ADD CONSTRAINT [PK_Account]
    PRIMARY KEY CLUSTERED ([AccountID] ASC);
GO

-- Creating primary key on [CustomerID] in table 'Customer'
ALTER TABLE [dbo].[Customer]
ADD CONSTRAINT [PK_Customer]
    PRIMARY KEY CLUSTERED ([CustomerID] ASC);
GO

-- Creating primary key on [DepositID] in table 'Deposit'
ALTER TABLE [dbo].[Deposit]
ADD CONSTRAINT [PK_Deposit]
    PRIMARY KEY CLUSTERED ([DepositID] ASC);
GO

-- Creating primary key on [TransactionID] in table 'Transaction'
ALTER TABLE [dbo].[Transaction]
ADD CONSTRAINT [PK_Transaction]
    PRIMARY KEY CLUSTERED ([TransactionID] ASC);
GO

-- Creating primary key on [WithdrawalID] in table 'Withdrawal'
ALTER TABLE [dbo].[Withdrawal]
ADD CONSTRAINT [PK_Withdrawal]
    PRIMARY KEY CLUSTERED ([WithdrawalID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CustomerID] in table 'Account'
ALTER TABLE [dbo].[Account]
ADD CONSTRAINT [FK_dbo_Account_dbo_Customer_CustomerID]
    FOREIGN KEY ([CustomerID])
    REFERENCES [dbo].[Customer]
        ([CustomerID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_dbo_Accounts_dbo_Customer_CustomerID'
CREATE INDEX [IX_FK_dbo_Account_dbo_Customer_CustomerID]
ON [dbo].[Account]
    ([CustomerID]);
GO

-- Creating foreign key on [AccountID] in table 'Transactions'
ALTER TABLE [dbo].[Transaction]
ADD CONSTRAINT [FK_dbo_Transaction_dbo_Account_AccountID]
    FOREIGN KEY ([AccountID])
    REFERENCES [dbo].[Account]
        ([AccountID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_dbo_Transactions_dbo_Accounts_AccountID'
CREATE INDEX [IX_FK_dbo_Transaction_dbo_Account_AccountID]
ON [dbo].[Transaction]
    ([AccountID]);
GO

-- Creating foreign key on [TransactionID] in table 'Deposits'
ALTER TABLE [dbo].[Deposit]
ADD CONSTRAINT [FK_dbo_Deposit_dbo_Transaction]
    FOREIGN KEY ([TransactionID])
    REFERENCES [dbo].[Transaction]
        ([TransactionID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_dbo_Deposits_dbo_Transactions'
CREATE INDEX [IX_FK_dbo_Deposit_dbo_Transaction]
ON [dbo].[Deposit]
    ([TransactionID]);
GO

-- Creating foreign key on [TransactionID] in table 'Withdrawals'
ALTER TABLE [dbo].[Withdrawal]
ADD CONSTRAINT [FK_dbo_Withdrawal_dbo_Transaction]
    FOREIGN KEY ([TransactionID])
    REFERENCES [dbo].[Transaction]
        ([TransactionID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_dbo_Withdrawals_dbo_Transactions'
CREATE INDEX [IX_FK_dbo_Withdrawal_dbo_Transaction]
ON [dbo].[Withdrawal]
    ([TransactionID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------




--inserts--
--SET IDENTITY_INSERT "Customer" ON
--INSERT "Customer"("CustomerID","FirstName","LastName") VALUES(1,'Billy', 'Idol')
--INSERT "Customer"("CustomerID","FirstName","LastName") VALUES(2,'Max', 'Headroom')
--INSERT "Customer"("CustomerID","FirstName","LastName") VALUES(3,'Jim', 'Carey')
--INSERT "Customer"("CustomerID","FirstName","LastName") VALUES(4,'Dee', 'Snider')
--SET IDENTITY_INSERT "Customer" OFF
--GO

--SET IDENTITY_INSERT "Account" ON
--INSERT "Account"("AccountID","AccountNumber","Pin","AccountType","CustomerID","Balance","CreatedUtc") VALUES(1,1111,1111,'Savings',1,999,N'12/1/2017 9:07:59 AM -01:00')
--INSERT "Account"("AccountID","AccountNumber","Pin","AccountType","CustomerID","Balance","CreatedUtc") VALUES(2,2222,2222,'Savings',2,999,N'12/2/2017 9:07:59 AM -02:00')
--INSERT "Account"("AccountID","AccountNumber","Pin","AccountType","CustomerID","Balance","CreatedUtc") VALUES(3,3333,3333,'Savings',3,999,N'12/3/2017 9:07:59 AM -03:00')
--INSERT "Account"("AccountID","AccountNumber","Pin","AccountType","CustomerID","Balance","CreatedUtc") VALUES(4,4444,4444,'Savings',4,999,N'12/4/2017 9:07:59 AM -04:00')
--SET IDENTITY_INSERT "Account" OFF
--GO
--SET IDENTITY_INSERT "Transactions" ON
--INSERT "Transactions"("TransactionID","TransactionType","AccountID") VALUES(1,'Deposit', 1)
--INSERT "Transactions"("TransactionID","TransactionType","AccountID") VALUES(2,'Deposit', 2)
--INSERT "Transactions"("TransactionID","TransactionType","AccountID") VALUES(3,'Deposit', 3)
--INSERT "Transactions"("TransactionID","TransactionType","AccountID") VALUES(4,'Deposit', 4)
--SET IDENTITY_INSERT "Transactions" OFF

--SET IDENTITY_INSERT "Deposit" ON
--INSERT "Deposit"("DepositID","Amount","TransactionID") VALUES(1, 100, 1)
--INSERT "Deposit"("DepositID","Amount","TransactionID") VALUES(2, 200, 2)
--INSERT "Deposit"("DepositID","Amount","TransactionID") VALUES(3, 300, 3)
--INSERT "Deposit"("DepositID","Amount","TransactionID") VALUES(4, 400, 4)
--SET IDENTITY_INSERT "Deposit" OFF

--SET IDENTITY_INSERT "Withdrawal" ON
--INSERT "Withdrawal"("WithdrawalID","Amount","TransactionID") VALUES(1, 100, 1)
--INSERT "Withdrawal"("WithdrawalID","Amount","TransactionID") VALUES(2, 200, 2)
--INSERT "Withdrawal"("WithdrawalID","Amount","TransactionID") VALUES(3, 300, 3)
--INSERT "Withdrawal"("WithdrawalID","Amount","TransactionID") VALUES(4, 400, 4)
--SET IDENTITY_INSERT "Withdrawal" OFF




-- --------------------------------------------------
---- Dropping existing tables
---- --------------------------------------------------

--IF OBJECT_ID(N'[dbo].[Accounts]', 'U') IS NOT NULL
--    DROP TABLE [dbo].[Accounts];
--GO
--IF OBJECT_ID(N'[dbo].[Customers]', 'U') IS NOT NULL
--    DROP TABLE [dbo].[Customers];
--GO
--IF OBJECT_ID(N'[dbo].[Deposits]', 'U') IS NOT NULL
--    DROP TABLE [dbo].[Deposits];
--GO
--IF OBJECT_ID(N'[dbo].[Transactions]', 'U') IS NOT NULL
--    DROP TABLE [dbo].[Transactions];
--GO
--IF OBJECT_ID(N'[dbo].[Withdrawals]', 'U') IS NOT NULL
--    DROP TABLE [dbo].[Withdrawals];
--GO