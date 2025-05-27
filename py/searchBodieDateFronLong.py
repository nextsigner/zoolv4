
import sys
import swisseph as swe
import datetime
import json
import json
import jdutil

#Parámetros
swePath=sys.argv[1]
planeta_num=int(sys.argv[2])
longitud_objetivo = float(sys.argv[3])
ai = int(sys.argv[4])
mi = int(sys.argv[5])
di = int(sys.argv[6])
af = int(sys.argv[7])
mf = int(sys.argv[8])
df = int(sys.argv[9])
tol = float(sys.argv[10]) #Toleracia de tiempo de rastreo

aBodies=[('Sol', 0), ('Luna', 1), ('Mercurio', 2), ('Venus', 3), ('Marte', 4), ('Júpiter', 5), ('Saturno', 6), ('Urano', 7), ('Neptuno', 8), ('Plutón', 9), ('Nodo Norte', 11), ('Nodo Sur', 10), ('Quirón', 15), ('Selena', 57), ('Lilith', 12), ('Pholus', 16), ('Ceres', 17), ('Pallas', 18), ('Juno', 19), ('Vesta', 20)]



swe.set_ephe_path(swePath+'/swe')


def getJson(fecha_hora, g1, g2, aspIndex):
    datos = {
        "a": fecha_hora.year,
        "m": fecha_hora.month,
        "d": fecha_hora.day,
        "h": fecha_hora.hour,
        "min": fecha_hora.minute,
        "isData": True,
        "ai": ai,
        "mi": mi,
        "di": di,
        "af": af,
        "mf": mf,
        "df": df,
        "tol": tol,
        "b": aBodies[planeta_num][0],
        "numAstro": planeta_num,
        "gb": g1, #Grado Buscado
        "gr": g2, #Grado Retornado
        "aspIndex": aspIndex
    }
    return json.dumps(datos)



def encontrar_fecha_longitud(longitud_deseada):
    # -1 = no hay aspectos. 0 = oposición. 1 = cuadratura. 2 = trígono. 3 = conjunción. 4 = sextil. 5 = semicuadratura. 6 = quincuncio
    aspIndex=-1
    jd_inicio = swe.julday(ai, mi, di, 0.0)
    jd_fin = swe.julday(af, mf, df, 0.0)
    tjd = jd_inicio
    while tjd <= jd_fin:
        pl_pos, _ = swe.calc_ut(tjd, planeta_num, swe.FLG_SPEED)
        longitud_actual = pl_pos[0]
        long_deseadaOp=longitud_deseada + 180.00
        if long_deseadaOp>360.00:
            long_deseadaOp=long_deseadaOp - 360.00

        long_deseadaC1=longitud_deseada + 90.00
        long_deseadaC2=longitud_deseada - 90.00
        if long_deseadaC1>360.00:
            long_deseadaC1=long_deseadaC1 - 360.00

        if long_deseadaC2<360.00:
                long_deseadaC2=long_deseadaC2 + 360.00


        if abs(longitud_actual - longitud_deseada) < tol or abs(longitud_actual - long_deseadaOp) < tol or abs(longitud_actual - long_deseadaC1) < tol or abs(longitud_actual - long_deseadaC2) < tol:
            if abs(longitud_actual - longitud_deseada) < tol:
                aspIndex=3
            if abs(longitud_actual - long_deseadaOp) < tol:
                aspIndex=0
            if abs(longitud_actual - long_deseadaC1) < tol or abs(longitud_actual - long_deseadaC2) < tol:
                aspIndex=1

            fecha_utc = dateEc1=jdutil.jd_to_datetime(tjd)#swe.jdut_to_datetime(tjd[1])
            return getJson(fecha_utc, longitud_deseada, longitud_actual, aspIndex)


        # Incrementa la fecha en un día para la siguiente iteración
        tjd += tol

    return json.dumps({"isData": False, "ai": ai, "mi": mi, "di": di, "af": af, "mf": mf, "df": df, "b": aBodies[planeta_num][0], "gb": longitud_deseada, "gr": -1.0, "tol": tol, "numAstro": planeta_num})

if __name__ == "__main__":
    fecha_encontrada = encontrar_fecha_longitud(longitud_objetivo)
    print(fecha_encontrada)
