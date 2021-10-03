CREATE TABLE AUDIT(
   s_ID character(9) NOT NULL,
   s_duration numeric(5,1) NOT NULL,
   ENTRY_DATE TEXT NOT NULL
);


CREATE OR REPLACE FUNCTION auditlogfunc() RETURNS TRIGGER AS $example_table$

   BEGIN
      INSERT INTO AUDIT(s_ID, s_duration, ENTRY_DATE) VALUES (new.song_id, new.duration, current_timestamp);
      RETURN NEW;
   END;
$example_table$ LANGUAGE plpgsql;

CREATE TRIGGER example_trigger AFTER INSERT ON song
FOR EACH ROW EXECUTE PROCEDURE auditlogfunc();