SELECT services.form_name AS 'Services',
       IF(services.obs_id IS NULL, 0, SUM(IF(services.voided = 0, 1, 0))) as 'Total Clients'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
		   concept_name.name AS concept_name,
                   concept.concept_id AS concept_id,
                   obs.obs_datetime AS datetime,
                   concept_name.concept_name_type as type,
                   form_concepts_map.form_name AS form_name
   FROM obs
     INNER JOIN concept ON obs.concept_id = concept.concept_id 
     INNER JOIN concept_name ON concept.concept_id = concept_name.concept_id
     INNER JOIN form_concepts_map ON form_concepts_map.concept_id = concept_name.concept_id
   WHERE concept_name.concept_name_type="SHORT"  ) AS services
GROUP BY services.concept_name
ORDER BY services.concept_name;
