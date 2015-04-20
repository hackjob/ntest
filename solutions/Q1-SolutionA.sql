USE [Nephila_Metarisks_Candidate_Sample]
GO

-- add event_set filegroups
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventSetDayR1;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventSetDayR2;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventSetDayR3;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventSetDayR4;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventSetDayR5;

-- add event_set files
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventSetDayR1,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventSetDayR1.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventSetDayR1;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventSetDayR2,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventSetDayR2.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventSetDayR2;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventSetDayR3,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventSetDayR3.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventSetDayR3;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventSetDayR4,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventSetDayR4.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventSetDayR4;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventSetDayR5,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventSetDayR5.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventSetDayR5;

-- add event_loss filegroups
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventLossR1;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventLossR2;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventLossR3;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventLossR4;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventLossR5;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventLossR6;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventLossR7;
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD filegroup EventLossR8;

-- add event_loss files
ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventLossR1,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventLossR1.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventLossR1;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventLossR2,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventLossR2.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventLossR2;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventLossR3,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventLossR3.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventLossR3;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventLossR4,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventLossR4.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventLossR4;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventLossR5,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventLossR5.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventLossR5;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
 ( NAME = EventLossR6,
   FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventLossR6.ndf',
   SIZE = 5MB,
   FILEGROWTH = 1MB) to FILEGROUP EventLossR6;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
  ( NAME = EventLossR7,
    FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventLossR7.ndf',
    SIZE = 5MB,
    FILEGROWTH = 1MB) to FILEGROUP EventLossR7;

ALTER DATABASE Nephila_Metarisks_Candidate_Sample ADD file
  ( NAME = EventLossR8,
    FILENAME='D:\Program Files\Microsoft SQL Server\MSSQL12.NTEST\MSSQL\DATA\EventLossR8.ndf',
    SIZE = 5MB,
    FILEGROWTH = 1MB) to FILEGROUP EventLossR8;


-- create t00001_event_loss_footprint partition function on event_id
create partition function t00001_event_loss_fp_partrange (int)
 as range left for values (2500,5000,7500,10000);
GO

-- create t00002_event_loss_footprint partition function on event_id
create partition function t00002_event_loss_fp_partrange (int)
  as range left for values (5000,10000,15000,20000);
GO

-- create t00001_event_loss_footprint partition scheme
create partition scheme t00001_eventloss_partscheme
 as partition t00001_event_loss_fp_partrange
  to (EventLossR1,EventLossR2,EventLossR3,EventLossR4,EventLossR5);
GO

-- create t00002_event_loss_footprint partition scheme
create partition scheme t00002_eventloss_partscheme
 as partition t00002_event_loss_fp_partrange
  to (EventLossR4,EventLossR5,EventLossR6,EventLossR7,EventLossR8);
GO

-- create generic partition function for two event_set tables on day#
create partition function t000_gen_event_set_partdayrange (int)
 as range left for values (100,200,300);
 GO

 -- create generic partition scheme for two event_set tables
create partition scheme t000_geneventset_partscheme
 as partition t000_gen_event_set_partdayrange
  to ( EventSetDayR1 , EventSetDayR2 , EventSetDayR3 , EventSetDayR4 );
GO


-- create partitioned t00001_event_loss_footprint prototype
CREATE TABLE [dbo].[t00001_event_loss_footprint_part](
	[id] [int] NOT NULL,
	[event_id] [int] NOT NULL,
	[t031_id] [int] NOT NULL,
	[loss_amount] [money] NOT NULL)
 on t00001_eventloss_partscheme (event_id)
 GO


-- create partitioned t00002_event_loss_footprint prototype
CREATE TABLE [dbo].[t00002_event_loss_footprint_part](
	[id] [int] NOT NULL,
	[event_id] [int] NOT NULL,
	[t031_id] [int] NOT NULL,
	[loss_amount] [money] NOT NULL)
 on t00002_eventloss_partscheme (event_id)

GO

-- create partitioned t00001_event_set prototype
CREATE TABLE [dbo].[t00001_event_set_part](
	[event_id] [int] NOT NULL,
	[event_simulation] [int] NOT NULL,
	[event_day] [int] NOT NULL,
	[t010_id] [int] NOT NULL)
 on t000_geneventset_partscheme (event_day)

GO

-- create partitioned t00002_event_set prototype
CREATE TABLE [dbo].[t00002_event_set_part](
	[event_id] [int] NOT NULL,
	[event_simulation] [int] NOT NULL,
	[event_day] [int] NOT NULL,
	[t010_id] [int] NOT NULL)
 on t000_geneventset_partscheme (event_day)

GO
