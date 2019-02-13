SELECT client_visits.age_group AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F', 1, 0),0))) AS 'New Clients Female',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'M', 1, 0),0))) AS 'New Clients Male',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F', 1, 0),0))) AS 'Retutning Clients Female',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'M', 1, 0),0))) AS 'Retutning Clients Male',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(client_visits.patient_gender = 'F', 1, 0),0))) AS 'Total Clients Female',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(client_visits.patient_gender = 'M', 1, 0),0))) AS 'Total Clients Male',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(client_visits.patient_gender = 'M', 1, 1),0))) AS 'Total Clients'

FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   visit.date_started AS visit_date,
                   person.gender AS patient_gender,
                   observed_age_group.sort_order AS sort_order
   FROM visit
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND (DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) OR visit.date_stopped IS NULL) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.name='Above 18 Years' OR observed_age_group.name ='Below 18 Years' ) AS client_visits
GROUP BY client_visits.age_group
ORDER BY client_visits.sort_order;
