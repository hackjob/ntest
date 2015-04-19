
-- allow for bcp via ssms
sp_configure 'show advanced option',1
go
reconfigure
go
sp_configure 'xp_cmdshell',1
go
reconfigure

use Nephila_Metarisks_Candidate_Sample
go

-- solution B-1 "load via bcp"
select count(*) from Nephila_Metarisks_Candidate_Sample.dbo.t00001_event_loss_footprint_part;
select count(*) from Nephila_Metarisks_Candidate_Sample.dbo.t00002_event_loss_footprint_part;
go

xp_cmdshell 'bcp Nephila_Metarisks_Candidate_Sample.dbo.t00001_event_loss_footprint_part in "d:\GITWorkspace\NTEST\data\t00001_event_loss_footprint-bcpout.csv" -f "d:\GITWorkspace\NTEST\data\t0001_event_loss_footprint.fmt" -T'
xp_cmdshell 'bcp Nephila_Metarisks_Candidate_Sample.dbo.t00002_event_loss_footprint_part in "d:\GITWorkspace\NTEST\data\t00002_event_loss_footprint-bcpout.csv" -f "d:\GITWorkspace\NTEST\data\t0002_event_loss_footprint.fmt" -T'
go

select count(*) from Nephila_Metarisks_Candidate_Sample.dbo.t00001_event_loss_footprint_part;
select count(*) from Nephila_Metarisks_Candidate_Sample.dbo.t00002_event_loss_footprint_part;
go


-- solution B-2 "load via bulkinsert"
select * from Nephila_Metarisks_Candidate_Sample.dbo.t00001_event_set_part;
go

bulk insert Nephila_Metarisks_Candidate_Sample.dbo.t00001_event_set_part 
    from 'd:\GITWorkspace\NTEST\data\t00001_event_set-bcpout.csv'
	with ( KEEPIDENTITY, ROWTERMINATOR = '0x0a', FIELDTERMINATOR = ',')
go

select count(*) from Nephila_Metarisks_Candidate_Sample.dbo.t00001_event_set_part;
go



-- solution B-3 "load via openrowset"
-- enable openrowset (probably shouldn't but we're exhausting all nonprogrammatic options here)
sp_configure 'show advanced options',1
reconfigure
go
sp_configure 'ad hoc distributed queries',1
go
reconfigure
go


select count(*) from Nephila_Metarisks_Candidate_Sample.dbo.t00002_event_set_part;
go

insert into Nephila_Metarisks_Candidate_Sample.dbo.t00002_event_set_part
 select * from 
  OPENROWSET(BULK 'd:\GITWorkspace\NTEST\data\t00002_event_set-bcpout.csv',
               FORMATFILE = 'd:\GITWorkspace\NTEST\data\t0002_event_set2.fmt') as a;
go

select count(*) from Nephila_Metarisks_Candidate_Sample.dbo.t00002_event_set_part;
go
