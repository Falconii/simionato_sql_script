//RH

SELECT * FROM ESTRUTURAS WHERE CONTA = '01' AND LEFT(SUBCONTA,4) ='0105' ORDER BY CONTA,SUBCONTA

/*
DROP TABLE RH;
GO
CREATE TABLE RH AS
SELECT * FROM ESTRUTURAS WHERE  CONTA = '01' AND LEFT(SUBCONTA,4) ='0105' ORDER BY CONTA,SUBCONTA
GO
*/


UPDATE RH SET CONTA = '06', SUBCONTA = SUBSTRING(SUBCONTA,3), NIVEL = NIVEL - 1
GO
UPDATE RH SET SUBCONTA = '06' || SUBSTRING(SUBCONTA,3);
GO
UPDATE RH SET TIPO = 'C' WHERE NIVEL = 1
GO
DELETE FROM estruturas WHERE CONTA = '06'
GO
INSERT INTO estruturas
 SELECT * FROM RH ORDER BY CONTA,SUBCONTA
GO

