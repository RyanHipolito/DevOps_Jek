--Test Scenarios
Select PD.PERSON_ID,
PD.first_name||' '||PD.last_name AS FULL_NAME,
ID.Status,
ID.Address1||' '||ID.Address2 AS FULL_ADDRESS,
ID.Telephone,
ID.Mobile_Number
from Personal_Details pd INNER JOIN Information_Details ID
ON PD.PERSON_ID = ID.PERSON_ID
WHERE PD.PERSON_ID ='11789';
