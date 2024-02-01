/*

*/

DROP TABLE acumulado_cnpj_data_ipi_cppe_cpco;
GO

--
CREATE TABLE public.acumulado_cnpj_data_ipi_cppe_cpco  ( 
	cnpj             	char(14) NOT NULL,
	ano              	char(4) NOT NULL,
	mes              	char(2) NOT NULL,
    sistema             char(10) NOT NULL,
    produto             char(20) NOT NULL,
	origem              varchar(60) NOT NULL,
    classificacao    	varchar(50) NOT NULL,
    vlr_ipi          	numeric(15,4) NULL,
	vlr_ipi_corrigido	numeric(15,4) NULL,
    --PRIMARY KEY(cnpj,ano,mes,sistema,classificacao)
	PRIMARY KEY(cnpj,ano,mes,sistema,produto,origem,classificacao)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


INSERT INTO 
      acumulado_cnpj_data_ipi_cppe_cpco(
        cnpj, 
        ano, 
        mes, 
        sistema,
        produto,
        origem,
        classificacao, 
        vlr_ipi, 
        vlr_ipi_corrigido
     )
    SELECT 
     CAB.CNPJ                       AS   CNPJ  
    ,to_char(val.dtnfe, 'YYYY')     AS   ANO        
	,to_char(val.dtnfe, 'MM')       AS   MES  
    ,CAB.SISTEMA                    AS   SISTEMA
    ,CASE 
         WHEN VE.MATERIAL  = DET.MATERIAL              THEN 'MESMO PRODUTO'
         WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'     THEN 'SEM VENDA'
         ELSE                                              'OUTRO PRODUTO' 
     END AS PRODUTO 
    ,CASE
        WHEN (CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2') AND CFOP.TAG = '03' THEN 'REMESSA DISTRIBUIÇÃO DE BRINDES'
        WHEN (CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2') AND CFOP.TAG = '02' THEN 'REMESSA EM DOAÇÃO'  
        ELSE                                                                        'REMESSA DE BONIFICACAO'          
    END  AS ORIGEM 
    ,CASE 
         WHEN SUBSTR(VE.DESCRICAO,1,1) = '*'        THEN 'VENDA EM OUTRA NOTA' 
         WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'  THEN 'NAO ENCONTRADO VENDA' 
           ELSE                                            'VENDA NA NOTA' 
     END AS CLASSFICACAO
    ,SUM(VAL.VLR_IPI)               AS   VLR_IPI
    ,SUM(VAL.VLR_IPI_CORRIGIDO)     AS   VLR_IPI_CORRIGIDO
    FROM NFE_VALORES_IPI VAL
    INNER JOIN NFE_CAB      CAB  ON CAB.ID = VAL.ID
    INNER JOIN NFE_DET      DET  ON DET.ID = VAL.ID AND DET.NRO_LINHA = VAL.NRO_LINHA 
    INNER JOIN NFE_DET_COMP COMP ON COMP.ID = VAL.ID AND COMP.NRO_LINHA = VAL.NRO_LINHA AND COMP.BEBIDA = 'S'
    INNER JOIN NFE_DET_NOTA_VENDA VE ON VE.ID = DET.ID    AND VE.NRO_LINHA = DET.NRO_LINHA 
    INNER JOIN nfe_det_cfop CFOP     ON CFOP.ID = DET.ID  AND CFOP.nro_linha = DET.NRO_LINHA
    WHERE VAL.VLR_IPI > 0 AND 
        (
        ( val.id = 4     ) OR 
        ( val.id = 9     ) OR 
        ( val.id = 190   ) OR 
        ( val.id = 191   ) OR 
        ( val.id = 192   ) OR 
        ( val.id = 193   ) OR 
        ( val.id = 194   ) OR 
        ( val.id = 195   ) OR 
        ( val.id = 196   ) OR 
        ( val.id = 197   ) OR 
        ( val.id = 198   ) OR 
        ( val.id = 199   ) OR 
        ( val.id = 200   ) OR 
        ( val.id = 201   ) OR 
        ( val.id = 202   ) OR 
        ( val.id = 203   ) OR 
        ( val.id = 204   ) OR 
        ( val.id = 205   ) OR 
        ( val.id = 206   ) OR 
        ( val.id = 207   ) OR 
        ( val.id = 208   ) OR 
        ( val.id = 209   ) OR 
        ( val.id = 210   ) OR 
        ( val.id = 211   ) OR 
        ( val.id = 212   ) OR 
        ( val.id = 213   ) OR 
        ( val.id = 214   ) OR 
        ( val.id = 215   ) OR 
        ( val.id = 216   ) OR 
        ( val.id = 217   ) OR 
        ( val.id = 218   ) OR 
        ( val.id = 219   ) OR 
        ( val.id = 220   ) OR 
        ( val.id = 221   ) OR 
        ( val.id = 222   ) OR 
        ( val.id = 223   ) OR 
        ( val.id = 224   ) OR 
        ( val.id = 225   ) OR 
        ( val.id = 226   ) OR 
        ( val.id = 227   ) OR 
        ( val.id = 228   ) OR 
        ( val.id = 229   ) OR 
        ( val.id = 230   ) OR 
        ( val.id = 231   ) OR 
        ( val.id = 232   ) OR 
        ( val.id = 233   ) OR 
        ( val.id = 234   ) OR 
        ( val.id = 235   ) OR 
        ( val.id = 236   ) OR 
        ( val.id = 237   ) OR 
        ( val.id = 238   ) OR 
        ( val.id = 239   ) OR 
        ( val.id = 240   ) OR 
        ( val.id = 241   ) OR 
        ( val.id = 242   ) OR 
        ( val.id = 243   ) OR 
        ( val.id = 244   ) OR 
        ( val.id = 245   ) OR 
        ( val.id = 246   ) OR 
        ( val.id = 247   ) OR 
        ( val.id = 248   ) OR 
        ( val.id = 249   ) OR 
        ( val.id = 250   ) OR 
        ( val.id = 251   ) OR 
        ( val.id = 252   ) OR 
        ( val.id = 253   ) OR 
        ( val.id = 254   ) OR 
        ( val.id = 255   ) OR 
        ( val.id = 256   ) OR 
        ( val.id = 257   ) OR 
        ( val.id = 258   ) OR 
        ( val.id = 259   ) OR 
        ( val.id = 260   ) OR 
        ( val.id = 261   ) OR 
        ( val.id = 262   ) OR 
        ( val.id = 263   ) OR 
        ( val.id = 264   ) OR 
        ( val.id = 265   ) OR 
        ( val.id = 266   ) OR 
        ( val.id = 267   ) OR 
        ( val.id = 268   ) OR 
        ( val.id = 269   ) OR 
        ( val.id = 270   ) OR 
        ( val.id = 271   ) OR 
        ( val.id = 272   ) OR 
        ( val.id = 273   ) OR 
        ( val.id = 274   ) OR 
        ( val.id = 275   ) OR 
        ( val.id = 276   ) OR 
        ( val.id = 1311  ) OR 
        ( val.id = 1363  ) OR 
        ( val.id = 1364  ) OR 
        ( val.id = 1365  ) OR 
        ( val.id = 1366  ) OR 
        ( val.id = 1367  ) OR 
        ( val.id = 1368  ) OR 
        ( val.id = 1369  ) OR 
        ( val.id = 1370  ) OR 
        ( val.id = 1371  ) OR 
        ( val.id = 1372  ) OR 
        ( val.id = 1373  ) OR 
        ( val.id = 1374  ) OR 
        ( val.id = 1375  ) OR 
        ( val.id = 1376  ) OR 
        ( val.id = 1377  ) OR 
        ( val.id = 1378  ) OR 
        ( val.id = 1379  ) OR 
        ( val.id = 1380  ) OR 
        ( val.id = 1381  ) OR 
        ( val.id = 1382  ) OR 
        ( val.id = 1383  ) OR 
        ( val.id = 1384  ) OR 
        ( val.id = 1385  ) OR 
        ( val.id = 1386  ) OR 
        ( val.id = 1387  ) OR 
        ( val.id = 1388  ) OR 
        ( val.id = 1389  ) OR 
        ( val.id = 1390  ) OR 
        ( val.id = 1391  ) OR 
        ( val.id = 1392  ) OR 
        ( val.id = 1393  ) OR 
        ( val.id = 1394  ) OR 
        ( val.id = 1395  ) OR 
        ( val.id = 1396  ) OR 
        ( val.id = 1397  ) OR 
        ( val.id = 1398  ) OR 
        ( val.id = 1399  ) OR 
        ( val.id = 1400  ) OR 
        ( val.id = 1401  ) OR 
        ( val.id = 1402  ) OR 
        ( val.id = 1403  ) OR 
        ( val.id = 1404  ) OR 
        ( val.id = 1405  ) OR 
        ( val.id = 1406  ) OR 
        ( val.id = 1407  ) OR 
        ( val.id = 1408  ) OR 
        ( val.id = 1409  ) OR 
        ( val.id = 1410  ) OR 
        ( val.id = 1411  ) OR 
        ( val.id = 1412  ) OR 
        ( val.id = 1413  ) OR 
        ( val.id = 1414  ) OR 
        ( val.id = 1415  ) OR 
        ( val.id = 1416  ) OR 
        ( val.id = 1417  ) OR 
        ( val.id = 1418  ) OR 
        ( val.id = 1419  ) OR 
        ( val.id = 1420  ) OR 
        ( val.id = 1421  ) OR 
        ( val.id = 1422  ) OR 
        ( val.id = 1423  ) OR 
        ( val.id = 1424  ) OR 
        ( val.id = 1425  ) OR 
        ( val.id = 1426  ) OR 
        ( val.id = 1427  ) OR 
        ( val.id = 1428  ) OR 
        ( val.id = 1429  ) OR 
        ( val.id = 1430  ) OR 
        ( val.id = 1431  ) OR 
        ( val.id = 1432  ) OR 
        ( val.id = 1433  ) OR 
        ( val.id = 1434  ) OR 
        ( val.id = 1435  ) OR 
        ( val.id = 1436  ) OR 
        ( val.id = 1437  ) OR 
        ( val.id = 1438  ) OR 
        ( val.id = 1439  ) OR 
        ( val.id = 1440  ) OR 
        ( val.id = 1441  ) OR 
        ( val.id = 1442  ) OR 
        ( val.id = 1443  ) OR 
        ( val.id = 1444  ) OR 
        ( val.id = 1445  ) OR 
        ( val.id = 1446 ) OR 
        ( val.id = 1447 ) OR 
        ( val.id = 1448 ) OR 
        ( val.id = 1449 ) OR 
        ( val.id = 1450 ) OR 
        ( val.id = 1451 ) OR 
        ( val.id = 1452 ) OR 
        ( val.id = 1453 ) OR 
        ( val.id = 1454 ) OR 
        ( val.id = 1455 ) OR 
        ( val.id = 1456 ) OR 
        ( val.id = 1457 ) OR 
        ( val.id = 1458 ) OR 
        ( val.id = 1459 ) OR 
        ( val.id = 1460 ) OR 
        ( val.id = 1461 ) OR 
        ( val.id = 1462 ) OR 
        ( val.id = 1463 ) OR 
        ( val.id = 1464 ) OR 
        ( val.id = 1465 ) OR 
        ( val.id = 1466 ) OR 
        ( val.id = 1467 ) OR 
        ( val.id = 1468 ) OR 
        ( val.id = 1469 ) OR 
        ( val.id = 1470 ) OR 
        ( val.id = 1471 ) OR 
        ( val.id = 1472 ) OR 
        ( val.id = 1473 ) OR 
        ( val.id = 1474 ) OR 
        ( val.id = 1475 ) OR 
        ( val.id = 1476 ) OR 
        ( val.id = 1477 ) OR 
        ( val.id = 1478 ) OR 
        ( val.id = 1479 ) OR 
        ( val.id = 1480 ) OR 
        ( val.id = 1481 ) OR
     --   ( cab.id = 3        ) OR
     --   ( cab.id = 7        ) OR
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
) 
    GROUP BY CAB.CNPJ,to_char(val.dtnfe, 'YYYY'),to_char(val.dtnfe, 'MM')
    ,CAB.SISTEMA
    ,CASE 
         WHEN VE.MATERIAL = DET.MATERIAL              THEN 'MESMO PRODUTO'
         WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'    THEN 'SEM VENDA'
         ELSE                                              'OUTRO PRODUTO' 
     END 
    ,CASE
        WHEN (CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2') AND CFOP.TAG = '03' THEN 'REMESSA DISTRIBUIÇÃO DE BRINDES'
        WHEN (CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2') AND CFOP.TAG = '02' THEN 'REMESSA EM DOAÇÃO'  
        ELSE                                                                        'REMESSA DE BONIFICACAO'          
     END 
    ,CASE
        WHEN SUBSTR(VE.DESCRICAO,1,1) = '*'        THEN 'VENDA EM OUTRA NOTA'
        WHEN VE.DESCRICAO = 'SEM VENDA NESTA NOTA' THEN 'NAO ENCONTRADO VENDA'
        ELSE                                            'VENDA NA NOTA' 
     END      
/*  ORDER BY CAB.CNPJ,to_char(val.dtnfe, 'YYYY'),to_char(val.dtnfe, 'MM') ,CAB.SISTEMA
    ,CASE
         WHEN VE.MATERIAL = DET.MATERIAL  THEN 'MESMO PRODUTO'
         ELSE                                  'OUTRO PRODUTO'
     END
     ,CASE
        WHEN (CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2') AND CFOP.TAG = '03' THEN 'REMESSA DISTRIBUIÇÃO DE BRINDES'
        WHEN (CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2') AND CFOP.TAG = '02' THEN 'REMESSA EM DOAÇÃO'  
        ELSE                                                                        'REMESSA DE BONIFICACAO'          
     END 
    ,CASE 
         WHEN SUBSTR(VE.DESCRICAO,1,1) = '*'        THEN 'VENDA EM OUTRA NOTA' 
         WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'  THEN 'NAO ENCONTRADO VENDA' 
         ELSE                                            'VENDA NA NOTA' 
    END  
*/
GO


//RELATORIO RESUMO GERAL
SELECT dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao,acu.vlr_ipi,acu.vlr_ipi_corrigido
  FROM   acumulado_cnpj_data_ipi_cppe_cpco ACU
  LEFT   JOIN depara dp on dp.cnpj = acu.cnpj
  ORDER BY dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao
  GO


//iNCLUCÃO DE 3 COLUNAS  bonificação na mesma NF  -  bonificação na mesma NF + bonificação em Outra NF - bonificação de produto diferente.

SELECT dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.origem,acu.vlr_ipi
-- Mesma Nota
  ,case
        when acu.classificacao = 'VENDA NA NOTA' then acu.vlr_ipi
        else                                     0
  end as  "IPI - Venda Na Mesma Nota"
  ,case
        when acu.classificacao = 'VENDA NA NOTA' then acu.vlr_ipi_corrigido
        else                                     0
  end as  "IPI CORRIGIDO - Venda Na Mesma Nota"
-- Venda Outra Nota
 ,case
        when acu.classificacao = 'VENDA EM OUTRA NOTA' then acu.vlr_ipi
        else                                     0
  end as  "IPI - Venda Em Outra Nota"
 ,case
        when acu.classificacao = 'VENDA EM OUTRA NOTA' then acu.vlr_ipi_corrigido
        else                                     0
  end as  "IPI CORRIGIDO - Venda Em Outra Nota"
-- Venda Na Mesma Nota + Venda Em Outra Nota
 ,case
        when ((acu.classificacao = 'VENDA NA NOTA') OR (acu.classificacao = 'VENDA EM OUTRA NOTA')) then acu.vlr_ipi
        else                                     0
  end as  "IPI - Venda Na Mesma Nota + Venda Em Outra Nota"
 ,case
        when ((acu.classificacao = 'VENDA NA NOTA') OR (acu.classificacao = 'VENDA EM OUTRA NOTA')) then acu.vlr_ipi_corrigido
        else                                     0
  end as  "IPI CORRIGIDO - Venda Na Mesma Nota  + Venda Em Outra Nota"
-- Valores finais do IPI de bonificação de produto diferente
 ,case
        when ((acu.produto = 'OUTRO PRODUTO')) then acu.vlr_ipi
        else                                     0
  end as  "IPI - bonificação de produto diferente"
 ,case
        when ((acu.produto = 'OUTRO PRODUTO')) then acu.vlr_ipi_corrigido
        else                                     0
  end as  "IPI CORRIGIDO - bonificação de produto diferente"
  --Valores finais do IPI de bonificação sem venda
 ,case
        when ((acu.produto = 'SEM VENDA')) then acu.vlr_ipi
        else                                     0
  end as  "IPI - bonificação sem venda"
 ,case
        when ((acu.produto = 'SEM VENDA')) then acu.vlr_ipi_corrigido
        else                                     0
  end as  "IPI CORRIGIDO - bonificação sem venda"
  FROM   acumulado_cnpj_data_ipi_cppe_cpco ACU
  LEFT   JOIN depara dp on dp.cnpj = acu.cnpj
  WHERE  acu.origem = 'REMESSA DE BONIFICACAO'
  ORDER BY dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao
  GO




//SOMENTE BONIFICACAO
SELECT dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao,acu.vlr_ipi,acu.vlr_ipi_corrigido
  FROM   acumulado_cnpj_data_ipi_cppe_cpco ACU
  LEFT   JOIN depara dp on dp.cnpj = acu.cnpj
  WHERE  acu.origem = 'REMESSA DE BONIFICACAO'
  ORDER BY dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao
  GO


//TUDO DIFERENTE DE  BONIFICACAO
SELECT dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao,acu.vlr_ipi,acu.vlr_ipi_corrigido
  FROM   acumulado_cnpj_data_ipi_cppe_cpco ACU
  LEFT   JOIN depara dp on dp.cnpj = acu.cnpj
  WHERE  acu.origem <> 'REMESSA DE BONIFICACAO'
  ORDER BY dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao
  GO


SELECT * from nfe_det where id = 3 order by nro_linha