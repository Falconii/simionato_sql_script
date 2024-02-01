/*
DROP TABLE IF EXISTS Registros;
CREATE TABLE public.registros  ( 
    id              serial NOT NULL,
    pasta           varchar(255) NOT NULL,
    nome            varchar(100) NOT NULL,
    data            TimeStamp NOT NULL,
    Tamanho         CHAR(10)  NOT NULL,
    Id_Cab          INT4      default 0,
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX id_registros_nome
	ON public.registros USING btree (nome text_ops)
GO
CREATE UNIQUE INDEX id_registros_pasta_nome
	ON public.registros USING btree (nome text_ops)
GO

DROP TABLE IF EXISTS Plan_Demanda;
CREATE TABLE public.Plan_Demanda  ( 
    id_planilha     int4 NOT NULL,
    id_cab          int4 NOT NULL, 
	id_demanda    	int4 NULL,
    pasta_destino   varchar(255) null,
	PRIMARY KEY(id_planilha,id_cab,id_demanda)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
*/



SELECT CAB.PLANILHA,CAB.DATA_CRIACAO,CAB.ID,COALESCE(REG.ID,0),REG.nome,REG.ID_CAB
FROM   NFE_CAB CAB
LEFT JOIN registros reg on reg.nome = cab.planilha 
ORDER BY CAB.ID

SELECT    NOME,COUNT(*) 
FROM      REGISTROS
GROUP BY  NOME

/*
Unindo Nfe_Cab X Registros
*/

UPDATE REGISTROS SET (id_cab) =
    (SELECT id FROM nfe_cab 
     WHERE trim(nfe_cab.planilha) = trim(registros.nome))
WHERE ID = 1319

 UPDATE REGISTROS SET(id_cab) =  (SELECT id FROM nfe_cab  WHERE nfe_cab.planilha = registros.nome)  WHERE ID = 293 

SELECT * FROM REGISTROS where pasta like '%CONSOLIDADO%'



//
SELECT CAB.PLANILHA,CAB.DATA_CRIACAO,CAB.ID,COALESCE(REG.ID,0),REG.nome,REG.ID_CAB
FROM   NFE_CAB CAB
LEFT JOIN registros reg on reg.nome = cab.planilha 
WHERE       (
        ( cab.id = 4     ) OR 
        ( cab.id = 9     ) OR 
        ( cab.id = 190   ) OR 
        ( cab.id = 191   ) OR 
        ( cab.id = 192   ) OR 
        ( cab.id = 193   ) OR 
        ( cab.id = 194   ) OR 
        ( cab.id = 195   ) OR 
        ( cab.id = 196   ) OR 
        ( cab.id = 197   ) OR 
        ( cab.id = 198   ) OR 
        ( cab.id = 199   ) OR 
        ( cab.id = 200   ) OR 
        ( cab.id = 201   ) OR 
        ( cab.id = 202   ) OR 
        ( cab.id = 203   ) OR 
        ( cab.id = 204   ) OR 
        ( cab.id = 205   ) OR 
        ( cab.id = 206   ) OR 
        ( cab.id = 207   ) OR 
        ( cab.id = 208   ) OR 
        ( cab.id = 209   ) OR 
        ( cab.id = 210   ) OR 
        ( cab.id = 211   ) OR 
        ( cab.id = 212   ) OR 
        ( cab.id = 213   ) OR 
        ( cab.id = 214   ) OR 
        ( cab.id = 215   ) OR 
        ( cab.id = 216   ) OR 
        ( cab.id = 217   ) OR 
        ( cab.id = 218   ) OR 
        ( cab.id = 219   ) OR 
        ( cab.id = 220   ) OR 
        ( cab.id = 221   ) OR 
        ( cab.id = 222   ) OR 
        ( cab.id = 223   ) OR 
        ( cab.id = 224   ) OR 
        ( cab.id = 225   ) OR 
        ( cab.id = 226   ) OR 
        ( cab.id = 227   ) OR 
        ( cab.id = 228   ) OR 
        ( cab.id = 229   ) OR 
        ( cab.id = 230   ) OR 
        ( cab.id = 231   ) OR 
        ( cab.id = 232   ) OR 
        ( cab.id = 233   ) OR 
        ( cab.id = 234   ) OR 
        ( cab.id = 235   ) OR 
        ( cab.id = 236   ) OR 
        ( cab.id = 237   ) OR 
        ( cab.id = 238   ) OR 
        ( cab.id = 239   ) OR 
        ( cab.id = 240   ) OR 
        ( cab.id = 241   ) OR 
        ( cab.id = 242   ) OR 
        ( cab.id = 243   ) OR 
        ( cab.id = 244   ) OR 
        ( cab.id = 245   ) OR 
        ( cab.id = 246   ) OR 
        ( cab.id = 247   ) OR 
        ( cab.id = 248   ) OR 
        ( cab.id = 249   ) OR 
        ( cab.id = 250   ) OR 
        ( cab.id = 251   ) OR 
        ( cab.id = 252   ) OR 
        ( cab.id = 253   ) OR 
        ( cab.id = 254   ) OR 
        ( cab.id = 255   ) OR 
        ( cab.id = 256   ) OR 
        ( cab.id = 257   ) OR 
        ( cab.id = 258   ) OR 
        ( cab.id = 259   ) OR 
        ( cab.id = 260   ) OR 
        ( cab.id = 261   ) OR 
        ( cab.id = 262   ) OR 
        ( cab.id = 263   ) OR 
        ( cab.id = 264   ) OR 
        ( cab.id = 265   ) OR 
        ( cab.id = 266   ) OR 
        ( cab.id = 267   ) OR 
        ( cab.id = 268   ) OR 
        ( cab.id = 269   ) OR 
        ( cab.id = 270   ) OR 
        ( cab.id = 271   ) OR 
        ( cab.id = 272   ) OR 
        ( cab.id = 273   ) OR 
        ( cab.id = 274   ) OR 
        ( cab.id = 275   ) OR 
        ( cab.id = 276   ) OR 
        ( cab.id = 1311  ) OR 
        ( cab.id = 1363  ) OR 
        ( cab.id = 1364  ) OR 
        ( cab.id = 1365  ) OR 
        ( cab.id = 1366  ) OR 
        ( cab.id = 1367  ) OR 
        ( cab.id = 1368  ) OR 
        ( cab.id = 1369  ) OR 
        ( cab.id = 1370  ) OR 
        ( cab.id = 1371  ) OR 
        ( cab.id = 1372  ) OR 
        ( cab.id = 1373  ) OR 
        ( cab.id = 1374  ) OR 
        ( cab.id = 1375  ) OR 
        ( cab.id = 1376  ) OR 
        ( cab.id = 1377  ) OR 
        ( cab.id = 1378  ) OR 
        ( cab.id = 1379  ) OR 
        ( cab.id = 1380  ) OR 
        ( cab.id = 1381  ) OR 
        ( cab.id = 1382  ) OR 
        ( cab.id = 1383  ) OR 
        ( cab.id = 1384  ) OR 
        ( cab.id = 1385  ) OR 
        ( cab.id = 1386  ) OR 
        ( cab.id = 1387  ) OR 
        ( cab.id = 1388  ) OR 
        ( cab.id = 1389  ) OR 
        ( cab.id = 1390  ) OR 
        ( cab.id = 1391  ) OR 
        ( cab.id = 1392  ) OR 
        ( cab.id = 1393  ) OR 
        ( cab.id = 1394  ) OR 
        ( cab.id = 1395  ) OR 
        ( cab.id = 1396  ) OR 
        ( cab.id = 1397  ) OR 
        ( cab.id = 1398  ) OR 
        ( cab.id = 1399  ) OR 
        ( cab.id = 1400  ) OR 
        ( cab.id = 1401  ) OR 
        ( cab.id = 1402  ) OR 
        ( cab.id = 1403  ) OR 
        ( cab.id = 1404  ) OR 
        ( cab.id = 1405  ) OR 
        ( cab.id = 1406  ) OR 
        ( cab.id = 1407  ) OR 
        ( cab.id = 1408  ) OR 
        ( cab.id = 1409  ) OR 
        ( cab.id = 1410  ) OR 
        ( cab.id = 1411  ) OR 
        ( cab.id = 1412  ) OR 
        ( cab.id = 1413  ) OR 
        ( cab.id = 1414  ) OR 
        ( cab.id = 1415  ) OR 
        ( cab.id = 1416  ) OR 
        ( cab.id = 1417  ) OR 
        ( cab.id = 1418  ) OR 
        ( cab.id = 1419  ) OR 
        ( cab.id = 1420  ) OR 
        ( cab.id = 1421  ) OR 
        ( cab.id = 1422  ) OR 
        ( cab.id = 1423  ) OR 
        ( cab.id = 1424  ) OR 
        ( cab.id = 1425  ) OR 
        ( cab.id = 1426  ) OR 
        ( cab.id = 1427  ) OR 
        ( cab.id = 1428  ) OR 
        ( cab.id = 1429  ) OR 
        ( cab.id = 1430  ) OR 
        ( cab.id = 1431  ) OR 
        ( cab.id = 1432  ) OR 
        ( cab.id = 1433  ) OR 
        ( cab.id = 1434  ) OR 
        ( cab.id = 1435  ) OR 
        ( cab.id = 1436  ) OR 
        ( cab.id = 1437  ) OR 
        ( cab.id = 1438  ) OR 
        ( cab.id = 1439  ) OR 
        ( cab.id = 1440  ) OR 
        ( cab.id = 1441  ) OR 
        ( cab.id = 1442  ) OR 
        ( cab.id = 1443  ) OR 
        ( cab.id = 1444  ) OR 
        ( cab.id = 1445  ) OR 
        ( cab.id = 1446 ) OR 
        ( cab.id = 1447 ) OR 
        ( cab.id = 1448 ) OR 
        ( cab.id = 1449 ) OR 
        ( cab.id = 1450 ) OR 
        ( cab.id = 1451 ) OR 
        ( cab.id = 1452 ) OR 
        ( cab.id = 1453 ) OR 
        ( cab.id = 1454 ) OR 
        ( cab.id = 1455 ) OR 
        ( cab.id = 1456 ) OR 
        ( cab.id = 1457 ) OR 
        ( cab.id = 1458 ) OR 
        ( cab.id = 1459 ) OR 
        ( cab.id = 1460 ) OR 
        ( cab.id = 1461 ) OR 
        ( cab.id = 1462 ) OR 
        ( cab.id = 1463 ) OR 
        ( cab.id = 1464 ) OR 
        ( cab.id = 1465 ) OR 
        ( cab.id = 1466 ) OR 
        ( cab.id = 1467 ) OR 
        ( cab.id = 1468 ) OR 
        ( cab.id = 1469 ) OR 
        ( cab.id = 1470 ) OR 
        ( cab.id = 1471 ) OR 
        ( cab.id = 1472 ) OR 
        ( cab.id = 1473 ) OR 
        ( cab.id = 1474 ) OR 
        ( cab.id = 1475 ) OR 
        ( cab.id = 1476 ) OR 
        ( cab.id = 1477 ) OR 
        ( cab.id = 1478 ) OR 
        ( cab.id = 1479 ) OR 
        ( cab.id = 1480 ) OR 
        ( cab.id = 1481 ) 
)
ORDER BY CAB.ID

//CPPE
INSERT INTO PLAN_DEMANDA(id_planilha,id_cab,id_demanda)
 SELECT COALESCE(REG.ID,0) AS ID_PLANILHA,ID_CAB,900 AS ID_DEMANDA
    FROM   NFE_CAB CAB
    LEFT JOIN registros reg on reg.nome = cab.planilha 
    WHERE       (
            ( cab.id = 4     ) OR 
            ( cab.id = 9     ) OR 
            ( cab.id = 190   ) OR 
            ( cab.id = 191   ) OR 
            ( cab.id = 192   ) OR 
            ( cab.id = 193   ) OR 
            ( cab.id = 194   ) OR 
            ( cab.id = 195   ) OR 
            ( cab.id = 196   ) OR 
            ( cab.id = 197   ) OR 
            ( cab.id = 198   ) OR 
            ( cab.id = 199   ) OR 
            ( cab.id = 200   ) OR 
            ( cab.id = 201   ) OR 
            ( cab.id = 202   ) OR 
            ( cab.id = 203   ) OR 
            ( cab.id = 204   ) OR 
            ( cab.id = 205   ) OR 
            ( cab.id = 206   ) OR 
            ( cab.id = 207   ) OR 
            ( cab.id = 208   ) OR 
            ( cab.id = 209   ) OR 
            ( cab.id = 210   ) OR 
            ( cab.id = 211   ) OR 
            ( cab.id = 212   ) OR 
            ( cab.id = 213   ) OR 
            ( cab.id = 214   ) OR 
            ( cab.id = 215   ) OR 
            ( cab.id = 216   ) OR 
            ( cab.id = 217   ) OR 
            ( cab.id = 218   ) OR 
            ( cab.id = 219   ) OR 
            ( cab.id = 220   ) OR 
            ( cab.id = 221   ) OR 
            ( cab.id = 222   ) OR 
            ( cab.id = 223   ) OR 
            ( cab.id = 224   ) OR 
            ( cab.id = 225   ) OR 
            ( cab.id = 226   ) OR 
            ( cab.id = 227   ) OR 
            ( cab.id = 228   ) OR 
            ( cab.id = 229   ) OR 
            ( cab.id = 230   ) OR 
            ( cab.id = 231   ) OR 
            ( cab.id = 232   ) OR 
            ( cab.id = 233   ) OR 
            ( cab.id = 234   ) OR 
            ( cab.id = 235   ) OR 
            ( cab.id = 236   ) OR 
            ( cab.id = 237   ) OR 
            ( cab.id = 238   ) OR 
            ( cab.id = 239   ) OR 
            ( cab.id = 240   ) OR 
            ( cab.id = 241   ) OR 
            ( cab.id = 242   ) OR 
            ( cab.id = 243   ) OR 
            ( cab.id = 244   ) OR 
            ( cab.id = 245   ) OR 
            ( cab.id = 246   ) OR 
            ( cab.id = 247   ) OR 
            ( cab.id = 248   ) OR 
            ( cab.id = 249   ) OR 
            ( cab.id = 250   ) OR 
            ( cab.id = 251   ) OR 
            ( cab.id = 252   ) OR 
            ( cab.id = 253   ) OR 
            ( cab.id = 254   ) OR 
            ( cab.id = 255   ) OR 
            ( cab.id = 256   ) OR 
            ( cab.id = 257   ) OR 
            ( cab.id = 258   ) OR 
            ( cab.id = 259   ) OR 
            ( cab.id = 260   ) OR 
            ( cab.id = 261   ) OR 
            ( cab.id = 262   ) OR 
            ( cab.id = 263   ) OR 
            ( cab.id = 264   ) OR 
            ( cab.id = 265   ) OR 
            ( cab.id = 266   ) OR 
            ( cab.id = 267   ) OR 
            ( cab.id = 268   ) OR 
            ( cab.id = 269   ) OR 
            ( cab.id = 270   ) OR 
            ( cab.id = 271   ) OR 
            ( cab.id = 272   ) OR 
            ( cab.id = 273   ) OR 
            ( cab.id = 274   ) OR 
            ( cab.id = 275   ) OR 
            ( cab.id = 276   ) OR 
            ( cab.id = 1311  ) OR 
            ( cab.id = 1363  ) OR 
            ( cab.id = 1364  ) OR 
            ( cab.id = 1365  ) OR 
            ( cab.id = 1366  ) OR 
            ( cab.id = 1367  ) OR 
            ( cab.id = 1368  ) OR 
            ( cab.id = 1369  ) OR 
            ( cab.id = 1370  ) OR 
            ( cab.id = 1371  ) OR 
            ( cab.id = 1372  ) OR 
            ( cab.id = 1373  ) OR 
            ( cab.id = 1374  ) OR 
            ( cab.id = 1375  ) OR 
            ( cab.id = 1376  ) OR 
            ( cab.id = 1377  ) OR 
            ( cab.id = 1378  ) OR 
            ( cab.id = 1379  ) OR 
            ( cab.id = 1380  ) OR 
            ( cab.id = 1381  ) OR 
            ( cab.id = 1382  ) OR 
            ( cab.id = 1383  ) OR 
            ( cab.id = 1384  ) OR 
            ( cab.id = 1385  ) OR 
            ( cab.id = 1386  ) OR 
            ( cab.id = 1387  ) OR 
            ( cab.id = 1388  ) OR 
            ( cab.id = 1389  ) OR 
            ( cab.id = 1390  ) OR 
            ( cab.id = 1391  ) OR 
            ( cab.id = 1392  ) OR 
            ( cab.id = 1393  ) OR 
            ( cab.id = 1394  ) OR 
            ( cab.id = 1395  ) OR 
            ( cab.id = 1396  ) OR 
            ( cab.id = 1397  ) OR 
            ( cab.id = 1398  ) OR 
            ( cab.id = 1399  ) OR 
            ( cab.id = 1400  ) OR 
            ( cab.id = 1401  ) OR 
            ( cab.id = 1402  ) OR 
            ( cab.id = 1403  ) OR 
            ( cab.id = 1404  ) OR 
            ( cab.id = 1405  ) OR 
            ( cab.id = 1406  ) OR 
            ( cab.id = 1407  ) OR 
            ( cab.id = 1408  ) OR 
            ( cab.id = 1409  ) OR 
            ( cab.id = 1410  ) OR 
            ( cab.id = 1411  ) OR 
            ( cab.id = 1412  ) OR 
            ( cab.id = 1413  ) OR 
            ( cab.id = 1414  ) OR 
            ( cab.id = 1415  ) OR 
            ( cab.id = 1416  ) OR 
            ( cab.id = 1417  ) OR 
            ( cab.id = 1418  ) OR 
            ( cab.id = 1419  ) OR 
            ( cab.id = 1420  ) OR 
            ( cab.id = 1421  ) OR 
            ( cab.id = 1422  ) OR 
            ( cab.id = 1423  ) OR 
            ( cab.id = 1424  ) OR 
            ( cab.id = 1425  ) OR 
            ( cab.id = 1426  ) OR 
            ( cab.id = 1427  ) OR 
            ( cab.id = 1428  ) OR 
            ( cab.id = 1429  ) OR 
            ( cab.id = 1430  ) OR 
            ( cab.id = 1431  ) OR 
            ( cab.id = 1432  ) OR 
            ( cab.id = 1433  ) OR 
            ( cab.id = 1434  ) OR 
            ( cab.id = 1435  ) OR 
            ( cab.id = 1436  ) OR 
            ( cab.id = 1437  ) OR 
            ( cab.id = 1438  ) OR 
            ( cab.id = 1439  ) OR 
            ( cab.id = 1440  ) OR 
            ( cab.id = 1441  ) OR 
            ( cab.id = 1442  ) OR 
            ( cab.id = 1443  ) OR 
            ( cab.id = 1444  ) OR 
            ( cab.id = 1445  ) OR 
            ( cab.id = 1446 ) OR 
            ( cab.id = 1447 ) OR 
            ( cab.id = 1448 ) OR 
            ( cab.id = 1449 ) OR 
            ( cab.id = 1450 ) OR 
            ( cab.id = 1451 ) OR 
            ( cab.id = 1452 ) OR 
            ( cab.id = 1453 ) OR 
            ( cab.id = 1454 ) OR 
            ( cab.id = 1455 ) OR 
            ( cab.id = 1456 ) OR 
            ( cab.id = 1457 ) OR 
            ( cab.id = 1458 ) OR 
            ( cab.id = 1459 ) OR 
            ( cab.id = 1460 ) OR 
            ( cab.id = 1461 ) OR 
            ( cab.id = 1462 ) OR 
            ( cab.id = 1463 ) OR 
            ( cab.id = 1464 ) OR 
            ( cab.id = 1465 ) OR 
            ( cab.id = 1466 ) OR 
            ( cab.id = 1467 ) OR 
            ( cab.id = 1468 ) OR 
            ( cab.id = 1469 ) OR 
            ( cab.id = 1470 ) OR 
            ( cab.id = 1471 ) OR 
            ( cab.id = 1472 ) OR 
            ( cab.id = 1473 ) OR 
            ( cab.id = 1474 ) OR 
            ( cab.id = 1475 ) OR 
            ( cab.id = 1476 ) OR 
            ( cab.id = 1477 ) OR 
            ( cab.id = 1478 ) OR 
            ( cab.id = 1479 ) OR 
            ( cab.id = 1480 ) OR 
            ( cab.id = 1481 ) 
    ) AND REG.ID IS NOT NULL
    ORDER BY CAB.ID

  
//CPPO

INSERT INTO PLAN_DEMANDA(id_planilha,id_cab,id_demanda)
 SELECT COALESCE(REG.ID,0) AS ID_PLANILHA,ID_CAB,900 AS ID_DEMANDA
    FROM   NFE_CAB CAB
    LEFT JOIN registros reg on reg.nome = cab.planilha 
    WHERE       (
        ( cab.id = 1158     ) OR
        ( cab.id = 1159     ) OR
        ( cab.id = 1160     ) OR
        ( cab.id = 1161     ) OR
        ( cab.id = 1162     ) OR
        ( cab.id = 1163     ) OR
        ( cab.id = 1164     ) OR
        ( cab.id = 1165     ) OR
        ( cab.id = 1166     ) OR
        ( cab.id = 1167     ) OR
        ( cab.id = 1168     ) OR
        ( cab.id = 1169     ) OR
        ( cab.id = 1170     ) OR
        ( cab.id = 1171     ) OR
        ( cab.id = 1172     ) OR
        ( cab.id = 1173     ) OR
        ( cab.id = 1174     ) OR
        ( cab.id = 1175     ) OR
        ( cab.id = 1176     ) OR
        ( cab.id = 1177     ) OR
        ( cab.id = 1178     ) OR
        ( cab.id = 1179     ) OR
        ( cab.id = 1180     ) OR
        ( cab.id = 1181     ) OR
        ( cab.id = 1182     ) OR
        ( cab.id = 1183     ) OR
        ( cab.id = 1184     ) OR
        ( cab.id = 1185     ) OR
        ( cab.id = 1186     ) OR
        ( cab.id = 1187     ) OR
        ( cab.id = 1188     ) OR
        ( cab.id = 1189     ) OR
        ( cab.id = 1190     ) OR
        ( cab.id = 1191     ) OR
        ( cab.id = 1192     ) OR
        ( cab.id = 1193     ) OR
        ( cab.id = 1194     ) OR
        ( cab.id = 1195     ) OR
        ( cab.id = 1196     ) OR
        ( cab.id = 1197     ) OR
        ( cab.id = 1198     ) OR
        ( cab.id = 1199     ) OR
        ( cab.id = 1200     ) OR
        ( cab.id = 1201     ) OR
        ( cab.id = 1202     ) OR
        ( cab.id = 1203     ) OR
        ( cab.id = 1204     ) OR
        ( cab.id = 1205     ) OR
        ( cab.id = 1206     ) OR
        ( cab.id = 1207     ) OR
        ( cab.id = 1208     ) OR
        ( cab.id = 1209     ) OR
        ( cab.id = 1210     ) OR
        ( cab.id = 1211     ) OR
        ( cab.id = 1212     ) OR
        ( cab.id = 1213     ) OR
        ( cab.id = 1214     ) OR
        ( cab.id = 1215     ) OR
        ( cab.id = 1216     ) OR
        ( cab.id = 1217     ) OR
        ( cab.id = 1218     ) OR
        ( cab.id = 1219     ) OR
        ( cab.id = 1220     ) OR
        ( cab.id = 1221     ) OR
        ( cab.id = 1222     ) OR
        ( cab.id = 1223     ) OR
        ( cab.id = 1224     ) OR
        ( cab.id = 1225     ) OR
        ( cab.id = 1226     ) OR
        ( cab.id = 1227     ) OR
        ( cab.id = 1228     ) OR
        ( cab.id = 1229     ) OR
        ( cab.id = 1230     ) OR
        ( cab.id = 1231     ) OR
        ( cab.id = 1232     ) OR
        ( cab.id = 1233     ) OR
        ( cab.id = 1234     ) OR
        ( cab.id = 1235     ) OR
        ( cab.id = 1236     ) OR
        ( cab.id = 1237     ) OR
        ( cab.id = 1238     ) OR
        ( cab.id = 1239     ) OR
        ( cab.id = 1240     ) OR
        ( cab.id = 1241     ) OR
        ( cab.id = 1242     ) OR
        ( cab.id = 1243     ) OR
        ( cab.id = 1244     ) OR
        ( cab.id = 1245     ) OR
        ( cab.id = 1246     ) OR
        ( cab.id = 1247     ) OR
        ( cab.id = 1248     ) OR
        ( cab.id = 1249     ) OR
        ( cab.id = 1250     ) OR
        ( cab.id = 1251     ) OR
        ( cab.id = 1252     ) OR
        ( cab.id = 1253     ) OR
        ( cab.id = 1254     ) OR
        ( cab.id = 1255     ) OR
        ( cab.id = 1256     ) OR
        ( cab.id = 1257     ) OR
        ( cab.id = 1258     ) OR
        ( cab.id = 1259     ) OR
        ( cab.id = 1260     ) OR
        ( cab.id = 1261     ) OR
        ( cab.id = 1262     ) OR
        ( cab.id = 1263     ) OR
        ( cab.id = 1264     ) OR
        ( cab.id = 1265     ) OR
        ( cab.id = 1266     ) OR
        ( cab.id = 1267     ) OR
        ( cab.id = 1268     ) OR
        ( cab.id = 1269     ) OR
        ( cab.id = 1270     ) OR
        ( cab.id = 1271     ) OR
        ( cab.id = 1272     ) OR
        ( cab.id = 1273     ) OR
        ( cab.id = 1274     ) OR
        ( cab.id = 1275     ) OR
        ( cab.id = 1276     ) OR
        ( cab.id = 1277     ) OR
        ( cab.id = 1278     ) OR
        ( cab.id = 1279     ) OR
        ( cab.id = 1280     ) OR
        ( cab.id = 1281     ) OR
        ( cab.id = 1282     ) OR
        ( cab.id = 1283     ) OR
        ( cab.id = 1284     ) OR
        ( cab.id = 1285     ) OR
        ( cab.id = 1286     ) OR
        ( cab.id = 1287     ) OR
        ( cab.id = 1288     ) OR
        ( cab.id = 1289     ) OR
        ( cab.id = 1290     ) OR
        ( cab.id = 1291     ) OR
        ( cab.id = 1292     ) OR
        ( cab.id = 1293     ) OR
        ( cab.id = 1316     ) OR
        ( cab.id = 1317     ) OR
        ( cab.id = 1482     ) OR
        ( cab.id = 1484     ) OR
        ( cab.id = 1485     ) OR
        ( cab.id = 1486     ) OR
        ( cab.id = 1487     ) OR
        ( cab.id = 1488     ) OR
        ( cab.id = 1489     ) OR
        ( cab.id = 1490     ) OR
        ( cab.id = 1491     ) OR
        ( cab.id = 1492     ) OR
        ( cab.id = 1493     ) OR
        ( cab.id = 1494     ) OR
        ( cab.id = 1495     ) OR
        ( cab.id = 1496     ) OR
        ( cab.id = 1497     ) OR
        ( cab.id = 1498     ) OR
        ( cab.id = 1499     ) OR
        ( cab.id = 1500     ) OR
        ( cab.id = 1501     ) OR
        ( cab.id = 1502     ) OR
        ( cab.id = 1503     ) OR
        ( cab.id = 1504     ) OR
        ( cab.id = 1505     ) OR
        ( cab.id = 1506     ) OR
        ( cab.id = 1507     ) OR
        ( cab.id = 1508     ) OR
        ( cab.id = 1509     ) OR
        ( cab.id = 1510     ) OR
        ( cab.id = 1511     ) OR
        ( cab.id = 1512     ) OR
        ( cab.id = 1513     ) OR
        ( cab.id = 1514     ) OR
        ( cab.id = 1515     ) OR
        ( cab.id = 1516     ) OR
        ( cab.id = 1517     ) OR
        ( cab.id = 1518     ) OR
        ( cab.id = 1519     ) OR
        ( cab.id = 1520     ) OR
        ( cab.id = 1521     ) OR
        ( cab.id = 1522     ) OR
        ( cab.id = 1523     ) OR
        ( cab.id = 1524     ) OR
        ( cab.id = 1525     ) OR
        ( cab.id = 1526     ) OR
        ( cab.id = 1527     ) OR
        ( cab.id = 1528     ) OR
        ( cab.id = 1529     ) OR
        ( cab.id = 1530     ) OR
        ( cab.id = 1531     ) OR
        ( cab.id = 1532     ) OR
        ( cab.id = 1533     ) OR
        ( cab.id = 1534     ) OR
        ( cab.id = 1535     ) OR
        ( cab.id = 1536     ) OR
        ( cab.id = 1537     ) OR
        ( cab.id = 1538     ) OR
        ( cab.id = 1539     ) OR
        ( cab.id = 1540     ) OR
        ( cab.id = 1541     ) OR
        ( cab.id = 1542     ) OR
        ( cab.id = 1543     ) OR
        ( cab.id = 1544     ) OR
        ( cab.id = 1545     ) OR
        ( cab.id = 1546     ) OR
        ( cab.id = 1547     ) OR
        ( cab.id = 1548     ) OR
        ( cab.id = 1549     ) OR
        ( cab.id = 1550     ) OR
        ( cab.id = 1551     ) OR
        ( cab.id = 1552     ) OR
        ( cab.id = 1553     ) OR
        ( cab.id = 1554     ) OR
        ( cab.id = 1555     ) OR
        ( cab.id = 1556     ) OR
        ( cab.id = 1557     ) OR
        ( cab.id = 1558     ) OR
        ( cab.id = 1559     ) OR
        ( cab.id = 1560     ) OR
        ( cab.id = 1561     ) OR
        ( cab.id = 1562     ) OR
        ( cab.id = 1563     ) OR
        ( cab.id = 1564     ) OR
        ( cab.id = 1565     ) OR
        ( cab.id = 1566     ) OR
        ( cab.id = 1567     ) OR
        ( cab.id = 1568     ) OR
        ( cab.id = 1569     ) OR
        ( cab.id = 1570     ) OR
        ( cab.id = 1571     ) OR
        ( cab.id = 1572     ) OR
        ( cab.id = 1573     ) OR
        ( cab.id = 1574     ) OR
        ( cab.id = 1575     ) OR
        ( cab.id = 1576     ) OR
        ( cab.id = 1577     ) OR
        ( cab.id = 1578     ) OR
        ( cab.id = 1579     ) OR
        ( cab.id = 1580     ) OR
        ( cab.id = 1581     ) OR
        ( cab.id = 1582     ) OR
        ( cab.id = 1583     ) OR
        ( cab.id = 1584     ) OR
        ( cab.id = 1585     ) OR
        ( cab.id = 1586     ) OR
        ( cab.id = 1587     ) OR
        ( cab.id = 1588     ) OR
        ( cab.id = 1589     ) OR
        ( cab.id = 1590     ) OR
        ( cab.id = 1591     ) OR
        ( cab.id = 1592     ) OR
        ( cab.id = 1593     ) OR
        ( cab.id = 1594     ) OR
        ( cab.id = 1595     ) OR
        ( cab.id = 1596     ) OR
        ( cab.id = 1597     ) OR
        ( cab.id = 1598     ) OR
        ( cab.id = 1599     ) OR
        ( cab.id = 1600     ) OR
        ( cab.id = 1601     ) OR
        ( cab.id = 1602     ) OR
        ( cab.id = 1603     ) OR
        ( cab.id = 1604     ) OR
        ( cab.id = 1605     ) OR
        ( cab.id = 1606     ) OR
        ( cab.id = 1607     ) OR
        ( cab.id = 1608     ) OR
        ( cab.id = 1609     ) OR
        ( cab.id = 1610     ) OR
        ( cab.id = 1611     ) OR
        ( cab.id = 1612     ) OR
        ( cab.id = 1613     ) OR
        ( cab.id = 1614     ) OR
        ( cab.id = 1615     ) OR
        ( cab.id = 1616     ) OR
        ( cab.id = 1617     ) OR
        ( cab.id = 1618     ) OR
        ( cab.id = 1619     ) OR
        ( cab.id = 1620     ) OR
        ( cab.id = 1621     ) OR
        ( cab.id = 1622     ) OR
        ( cab.id = 1623     ) OR
        ( cab.id = 1624     ) OR
        ( cab.id = 1625     ) OR
        ( cab.id = 1626     ) OR
        ( cab.id = 1627     ) OR
        ( cab.id = 1628     ) OR
        ( cab.id = 1629     ) OR
        ( cab.id = 1630     ) OR
        ( cab.id = 1631     ) OR
        ( cab.id = 1632     ) OR
        ( cab.id = 1633     ) OR
        ( cab.id = 1634     ) OR
        ( cab.id = 1635     ) OR
        ( cab.id = 1636     ) OR
        ( cab.id = 1637     ) OR
        ( cab.id = 1638     ) OR
        ( cab.id = 1639     ) OR
        ( cab.id = 1640     ) OR
        ( cab.id = 1641     ) OR
        ( cab.id = 1642     ) OR
        ( cab.id = 1643     ) OR
        ( cab.id = 1644     ) OR
        ( cab.id = 1645     ) OR
        ( cab.id = 1646     ) OR
        ( cab.id = 1647     ) OR
        ( cab.id = 1648     ) OR
        ( cab.id = 1649     ) OR
        ( cab.id = 1652     ) OR
        ( cab.id = 1653     ) OR
        ( cab.id = 1654     ) OR
        ( cab.id = 1655     ) OR
        ( cab.id = 1656     ) OR
        ( cab.id = 1657     ) OR
        ( cab.id = 1680     )
) AND REG.ID IS NOT NULL
    ORDER BY CAB.ID


 UPDATE REGISTROS SET(id_cab) =  (SELECT id FROM nfe_cab  WHERE nfe_cab.planilha = registros.nome)  WHERE ID = 1 

SELECT * FROM NFE_CAB WHERE PLANILHA  = 'BA01 - 012018 á 062018.XLSX'
GO
SELECT * FROM REGISTROS WHERE NOME  = 'BA01 - 012018 á 062018.XLSX'
GO
BA01 - 012018 á 062018.XLSX
BA01 - 012018 á 062018.XLSX
BA01 - 012018 á 062018.XLSX


UPDATE REGISTROS SET (id_cab) =
    (SELECT id FROM nfe_cab 
     WHERE trim(nfe_cab.planilha) = trim(registros.nome))
WHERE ID = 1319

SELECT * FROM REGISTROS 


SELECT CAB.PLANILHA,CAB.DATA_CRIACAO,CAB.ID
       --,COALESCE(REG.ID,0),REG.nome,REG.ID_CAB
FROM   NFE_CAB CAB
LEFT JOIN registros reg on reg.nome = cab.planilha 
WHERE CAB.ID = 1319
ORDER BY CAB.ID




SELECT     REG.ID,REG.PASTA,REG.NOME,DP.EMPRESA,DP.CNPJ,DEMA.PASTA_DESTINO 
FROM       REGISTROS REG  
INNER JOIN NFE_CAB         CAB ON CAB.ID = REG.ID_CAB 
INNER JOIN PLAN_DEMANDA DEMA   ON DEMA.ID_PLANILHA = REG.ID 
INNER JOIN DEPARA          DP  ON DP.CNPJ = CAB.CNPJ 
WHERE DEMA.ID_DEMANDA = 900
ORDER BY REG.PASTA,REG.NOME 

id     pasta                                                                          nome                                                                         empresa     cnpj            pasta_destino    
