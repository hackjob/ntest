use Nephila_Metarisks_Candidate_Sample
go

-- regions
select tgr.t030_level_no,tgr.t030_id,tgr.t030_parent_id,tgr.t030_name,
       tgc.t030_country_name,tgc.t030_area_name,tgc.t030_subarea_name,
	   tgc.t031_id,tgc.t030_region_id,tgc.t030_country_id,tgc.t030_area_id,tgc.t030_subarea_id
  from Nephila_Metarisks_Candidate_Sample.dbo.t030_geo_region tgr
 left outer join Nephila_Metarisks_Candidate_Sample.dbo.t031_geo_code tgc
   on tgr.t030_id = tgc.t030_subarea_id
  where tgr.t030_parent_id =5

-- countries
select tgr.t030_level_no,tgr.t030_id,tgr.t030_parent_id,tgr.t030_name,
       tgc.t030_country_name,tgc.t030_area_name,tgc.t030_subarea_name,
	   tgc.t031_id,tgc.t030_region_id,tgc.t030_country_id,tgc.t030_area_id,tgc.t030_subarea_id
  from Nephila_Metarisks_Candidate_Sample.dbo.t030_geo_region tgr
 left outer join Nephila_Metarisks_Candidate_Sample.dbo.t031_geo_code tgc
   on tgr.t030_id = tgc.t030_subarea_id
  where tgr.t030_parent_id in (select t030_id from t030_geo_region where t030_parent_id=5)

-- states/areas
select tgr.t030_level_no,tgr.t030_id,tgr.t030_parent_id,tgr.t030_name
  from Nephila_Metarisks_Candidate_Sample.dbo.t030_geo_region tgr
 left outer join Nephila_Metarisks_Candidate_Sample.dbo.t031_geo_code tgc
   on tgr.t030_id = tgc.t030_subarea_id
  where tgr.t030_parent_id in
   (select t030_id from t030_geo_region where t030_parent_id in 
      (select t030_id from t030_geo_region where t030_parent_id=5))

-- counties/subarea
select tgr.t030_level_no,tgr.t030_id,tgr.t030_parent_id,tgr.t030_name
  from Nephila_Metarisks_Candidate_Sample.dbo.t030_geo_region tgr
 left outer join Nephila_Metarisks_Candidate_Sample.dbo.t031_geo_code tgc
   on tgr.t030_id = tgc.t030_subarea_id
  where tgr.t030_parent_id in
   (select t030_id from t030_geo_region where t030_parent_id in 
    (select t030_id from t030_geo_region where t030_parent_id in 
      (select t030_id from t030_geo_region where t030_parent_id=5)))




-- nested subqueries count right?  
 select region.name as region,country.name as country,area.name as area,subarea.name as subarea 
  from 
   (select tgr.t030_name  as name, tgr.t030_parent_id as parent_id , tgr.t030_id as id
      from Nephila_Metarisks_Candidate_Sample.dbo.t030_geo_region tgr
       left outer join Nephila_Metarisks_Candidate_Sample.dbo.t031_geo_code tgc
        on tgr.t030_id = tgc.t030_subarea_id where tgr.t030_parent_id =5) as region,

   (select tgr.t030_name  as name, tgr.t030_parent_id as parent_id , tgr.t030_id as id
      from Nephila_Metarisks_Candidate_Sample.dbo.t030_geo_region tgr
       left outer join Nephila_Metarisks_Candidate_Sample.dbo.t031_geo_code tgc
        on tgr.t030_id = tgc.t030_subarea_id where tgr.t030_parent_id in 
         (select t030_id from t030_geo_region where t030_parent_id=5))      as country,

   (select tgr.t030_name  as name, tgr.t030_parent_id as parent_id , tgr.t030_id as id
      from Nephila_Metarisks_Candidate_Sample.dbo.t030_geo_region tgr
       left outer join Nephila_Metarisks_Candidate_Sample.dbo.t031_geo_code tgc
        on tgr.t030_id = tgc.t030_subarea_id where tgr.t030_parent_id in 
          (select t030_id from t030_geo_region where t030_parent_id in 
            (select t030_id from t030_geo_region where t030_parent_id=5)))  as area,
          
   (select tgr.t030_name  as name, tgr.t030_parent_id as parent_id , tgr.t030_id as id
      from Nephila_Metarisks_Candidate_Sample.dbo.t030_geo_region tgr
       left outer join Nephila_Metarisks_Candidate_Sample.dbo.t031_geo_code tgc
        on tgr.t030_id = tgc.t030_subarea_id where tgr.t030_parent_id in 
           (select t030_id from t030_geo_region where t030_parent_id in 
              (select t030_id from t030_geo_region where t030_parent_id in 
                 (select t030_id from t030_geo_region where t030_parent_id=5))))  as subarea
   where country.parent_id = region.id 
     and area.parent_id = country.id 
	 and subarea.parent_id = area.id
