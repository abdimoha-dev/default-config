SELECT 
    pa.start_date_time AS 'APPOINTMENT DATE',
    pid.identifier AS 'PATIENT ID',
    CONCAT(COALESCE(pe.family_name, ''),
            ' ',
            COALESCE(pe.middle_name, ''),
            ' ',
            COALESCE(pe.given_name, '')) AS 'PATIENT NAME',
    aps.name AS 'SERVICE',
    patt.value AS 'CONTACT No.'
FROM
    patient_appointment pa
        LEFT JOIN
    patient_identifier pid ON pid.patient_id = pa.patient_id AND pid.voided IS FALSE
        LEFT JOIN
    person_name pe ON pe.person_id = pa.patient_id AND pe.voided IS FALSE
        LEFT JOIN
    appointment_service aps ON aps.appointment_service_id = pa.appointment_service_id AND aps.voided IS FALSE
        LEFT JOIN
    person_attribute patt ON patt.person_id = pa.patient_id AND patt.person_attribute_type_id = 28 AND patt.voided IS FALSE
WHERE
    (pa.voided IS FALSE OR pa.voided IS NULL)
        AND DATE(pa.start_date_time) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
        AND pa.status = 'Missed'
ORDER BY pa.start_date_time ASC;
