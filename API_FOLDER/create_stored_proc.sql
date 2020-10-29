CREATE PROCEDURE Personal_Detl (person_id NUMBER) AS
   tot_emps NUMBER;
   BEGIN
      select * FROM Personal_Details
      WHERE Personal_Details.person_id = Personal_Detl.person_id;

   EXCEPTION
   WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
   END;
/
