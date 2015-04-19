use Nephila_Metarisks_Candidate_Sample
go

-- row distribution on event_day 
select $partition.t000_gen_event_set_partdayrange(event_day) as partition,
       count(*) as count
  from Nephila_Metarisks_Candidate_Sample.dbo.t00002_event_set_part
 group by $partition.t000_gen_event_set_partdayrange(event_day)
 order by partition
 