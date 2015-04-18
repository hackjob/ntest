use Nephila_Metarisks_Candidate_Sample
go

/* loopback doesnt work well for mssql
exec sp_addlinkedserver @server='127.0.0.1'
exec sp_addlinkedsrvlogin '127.0.0.1','true' */

-- not needed but illustrative of linked server ddl
exec sp_addlinkedsrvlogin 'WIN-DPSRILL4HOF\NTEST','true'
exec sp_linkedservers
select * from sys.server_principals
go

-- create remote dev guest
create LOGIN remotedev WITH PASSWORD='remotedev';
use Nephila_Metarisks_Candidate_Sample;
create user remotedev for login remotedev;
go

-- create view for limited subset of t011_meta_risk
select distinct(t011_active_yn) from t011_meta_risk

select t011_id,t011_name from [WIN-DPSRILL4HOF\NTEST].Nephila_Metarisks_Candidate_Sample.dbo.t011_meta_risk where t011_active_yn='Y'
go

create view vw_temp4remotedev
 as
 select t011_id,t011_name from Nephila_Metarisks_Candidate_Sample.dbo.t011_meta_risk where t011_active_yn='Y';

GRANT SELECT ON vw_temp4remotedev to remotedev
go

-- test via loopback remote connection
:connect WIN-DPSRILL4HOF\NTEST -U remotedev -P remotedev
select * from Nephila_Metarisks_Candidate_Sample.dbo.vw_temp4remotedev
go


