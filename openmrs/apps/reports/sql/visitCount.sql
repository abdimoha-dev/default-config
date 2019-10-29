SELECT 'Totals' AS 'Visit Count',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.visit_type = 4, 1, 0))) as 'Total OPD Viits',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.visit_type = 3, 1, 0))) as 'Total CWC Visits',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.visit_type = 3, 1, 0))) as 'Total ANC Visits',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.visit_type = 3, 1, 1))) as 'Total Visits'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   visit.visit_type_id as visit_type,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender
   FROM visit
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
   WHERE visit.voided=0 ) AS client_visits
