//FINANCEIRO

SELECT * FROM ESTRUTURAS WHERE CONTA = '01' AND LEFT(SUBCONTA,4) ='0104' ORDER BY CONTA,SUBCONTA

/*
DROP TABLE FINANCEIRO;
GO
CREATE TABLE FINANCEIRO AS
SELECT * FROM ESTRUTURAS WHERE  CONTA = '01' AND LEFT(SUBCONTA,4) ='0104' ORDER BY CONTA,SUBCONTA
GO
*/


UPDATE FINANCEIRO SET CONTA = '05', SUBCONTA = SUBSTRING(SUBCONTA,3), NIVEL = NIVEL - 1
GO
UPDATE FINANCEIRO SET SUBCONTA = '05' || SUBSTRING(SUBCONTA,3);
GO
UPDATE FINANCEIRO SET TIPO = 'C' WHERE NIVEL = 1
GO
DELETE FROM estruturas WHERE CONTA = '05'
GO
INSERT INTO estruturas
 SELECT * FROM FINANCEIRO ORDER BY CONTA,SUBCONTA
GO

