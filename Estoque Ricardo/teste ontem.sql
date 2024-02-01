SELECT *
      FROM NFE_DET_E DET
      WHERE  id_grupo = 1  and det.operacao = 'V' and det.status = '0' and (det.dtnf >=  '2019-01-01' and  det.dtnf <= '2021-12-31')  
      ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.DTNF,DET.SERIE,DET.NRO,DET.NR_ITEM limit 1000