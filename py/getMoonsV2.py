#-->Import pyswisseph portable
import os
import sys
import platform

script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, script_dir)

system_name = platform.system()

if system_name == "Windows":
    import swisseph as swe
else:
    import pyswisseph_lin_2_10_3_2_portable.swisseph as swe

#<--Import pyswisseph portable

import datetime
import sys
import json


def float_to_time(hour_float):
    hours = int(hour_float)  # Obtener las horas
    minutes = int((hour_float - hours) * 60)  # Obtener los minutos
    seconds = int((hour_float - hours - minutes / 60) * 3600)  # Obtener los segundos
    return [hours, minutes, seconds]

def find_eclipses(year):
    resultado = {
        'solar':[],
        'lunar':[]
    }
    jd_start = swe.julday(year, 1, 1)
    jd_end = swe.julday(year + 1, 1, 1)
    eclipses = []

    # Buscar eclipses solares
    jd = jd_start
    while jd < jd_end:
        res, tret = swe.sol_eclipse_when_glob(jd)  # Para eclipses solares

        # El momento del máximo eclipse es tret[0]
        jd_max = tret[0]
        if jd_max < jd_end:
            date = swe.revjul(jd_max)  # Convertir a fecha gregoriana
            #eclipses.append(f"Eclipse solar: {date[0]}-{date[1]:02d}-{date[2]:02d}")
            item = {
                'a': date[0],
                'm': date[1],
                'd': date[2],
                'h': float_to_time(date[3])[0],
                'min': float_to_time(date[3])[1],
                'sec': float_to_time(date[3])[2]
            }
            resultado['solar'].append(item)

        jd = jd_max + 30  # Saltar 30 días después del último eclipse para buscar el siguiente

    # Buscar eclipses lunares
    jd = jd_start
    while jd < jd_end:
        retflag, tret = swe.lun_eclipse_when(jd)  # Para eclipses lunares

        # El momento del máximo eclipse es tret[0]
        jd_max = tret[0]
        if jd_max < jd_end:
            date = swe.revjul(jd_max)  # Convertir a fecha gregoriana
            #eclipses.append(f"Eclipse lunar: {date[0]}-{date[1]:02d}-{date[2]:02d}")
            item = {
                'a': int(date[0]),
                'm': int(date[1]),
                'd': int(date[2]),
                'h': float_to_time(date[3])[0],
                'min': float_to_time(date[3])[1],
                'sec': float_to_time(date[3])[2]
            }
            resultado['lunar'].append(item)
        jd = jd_max + 30  # Saltar 30 días después del último eclipse para buscar el siguiente

    return resultado
    #return eclipses

def convertir_julian_day(jd):
    """Convierte un día juliano a formato gregoriano (día, mes, año, hora, minuto)."""
    year, month, day, hour = swe.revjul(jd)  # Convertir jd a año, mes, día y hora (en decimal)

    # Extraer la hora y los minutos a partir de la parte decimal de la hora
    hora = int(hour)
    minuto = int((hour - hora) * 60)

    return int(day), int(month), int(year), hora, minuto

def calcular_evento_lunar(jd):
    """Calcula si hay un evento lunar en un día juliano específico."""
    # Obtener la posición del Sol y la Luna
    lon_sol, _ = swe.calc_ut(jd, swe.SUN)  # Solo tomamos la longitud del Sol
    lon_luna, _ = swe.calc_ut(jd, swe.MOON)  # Solo tomamos la longitud de la Luna
    # Convertir las longitudes a grados y minutos
    grado_sol = int(lon_sol[0])
    minuto_sol = int((lon_sol[0] - grado_sol) * 60)

    grado_luna = int(lon_luna[0])
    minuto_luna = int((lon_luna[0] - grado_luna) * 60)

    # Comparar las posiciones
    diferencia = abs(lon_sol[0] - lon_luna[0])
    diferencia=round(diferencia, 1)
    #print(str(diferencia))
    #print(str(round(diferencia, 1)))

    resultado={
        'gs': grado_sol,
        'ms': minuto_sol,
        'gl': grado_luna,
        'ml': minuto_luna,
        'e': -1
    }

    # Detectar eventos
    if diferencia == 0.0:  # Aproximadamente en conjunción (luna nueva)
        resultado['e']=0
        #return 0
    elif diferencia == 90.0:  # Cuarto creciente
        resultado['e']=1
        #return 1
    elif diferencia == 180.0:  # Luna Llena
        resultado['e']=2
        #return 2
    elif diferencia == 270.0:  # Cuarto menguante
        resultado['e']=3
        #return 3
    else:
        resultado['e']=-1
        #return -1
    return resultado

def iterar_julian_day(jd):
    hayEvento=False
    """Iterar sobre un día juliano, avanzando cada cierta cantidad de minutos durante 24 horas."""
    #incremento = 0.01041667  # Incremento de 15 minutos en días julianos (1/97 de un día)
    incremento = 0.01041667*0.25  # Incremento de 7.5 minutos en días julianos (1/97*4 de un día)

    # Iteramos durante 24 horas en intervalos de 15 minutos (97 pasos para incluir 00:00 del día siguiente)
    for i in range(97*4):
        jd_actual = jd + i * incremento
        dia, mes, anio, hora, minuto = convertir_julian_day(jd_actual)

        # Calcular evento lunar
        evento = calcular_evento_lunar(jd_actual)

        if evento['e'] >=0:
            resultado ={
                'isEvent': evento['e'],
                'd':int(f"{dia}"),
                'm':int(f"{mes}"),
                'a':int(f"{anio}"),
                'h':int(f"{hora}"), # hora del tiempo del evento
                'min':int(f"{minuto}"), # minuto del tiempo del evento
                'gs': int(evento['gs']), # grado solar
                'ms': int(evento['ms']), # minuto solar
                'gl': int(evento['gl']), # grado lunar
                'ml': int(evento['ml']) # minuto lunar
                #'eclipse': find_eclipses(2024)
            }
            #print(json.dumps(resultado, indent=4))
            hayEvento=True
            break
        #else:
            #print(f"Fecha: {dia}-{mes}-{anio}, Hora: {hora}:{minuto:02d} - No hay evento lunar.")
    if(hayEvento==False):
        resultado ={
            'isEvent': -1
        }
    return resultado
    #print(json.dumps(resultado, indent=4))

def iterar_dias_del_mes(mes, anio):
        """Itera todos los días válidos del mes y año especificados."""
        # Definir la cantidad de días en cada mes
        dias_en_mes = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        resultados={
            'ciclos':[]
        }

        # Verificar si el año es bisiesto y ajustar febrero
        if (anio % 4 == 0 and anio % 100 != 0) or (anio % 400 == 0):
            dias_en_mes[1] = 29  # Febrero tiene 29 días en un año bisiesto

        # Validar el mes
        if mes < 1 or mes > 12:
            print("Mes inválido. Debe estar entre 1 y 12.")
            return

        # Iterar a través de los días del mes
        for dia in range(1, dias_en_mes[mes - 1] + 1):
            jd_inicial = swe.julday(anio, mes, dia, 0.0)
            #print(json.dumps(iterar_julian_day(jd_inicial), indent=4))
            resultados['ciclos'].append(iterar_julian_day(jd_inicial))
            #print(f"{dia}-{mes}-{anio}")
        return resultados

def iterar_meses(anio):
    resultados = {
        'meses': [],
        'eclipses': {}
    }
    for mes in range(1, 12+1):
        #print(str(mes))
        resultados['meses'].append(iterar_dias_del_mes(mes, anio))
    resultados['eclipses']=find_eclipses(anio)
    return resultados


swePath=sys.argv[2]
swe.set_ephe_path(swePath)
# Ejemplo de uso
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Error: Debes proporcionar una fecha en el formato día-mes-año.")
        sys.exit(1)

    # Calcular el día juliano correspondiente a la fecha proporcionada
    #jd_inicial = swe.julday(anio, mes, dia, 0.0)

    # Iterar el día juliano cada 15 minutos
    #iterar_julian_day(jd_inicial)
    #print(json.dumps(iterar_julian_day(jd_inicial), indent=4))
    #iterar_dias_del_mes(10, 2024)
    #print(json.dumps(iterar_dias_del_mes(mes, anio), indent=4))
    #iterar_meses(anio)
    print(json.dumps(iterar_meses(int(sys.argv[1])), indent=4))

    #print(json.dumps(find_eclipses(2024), indent=4))
    #print(find_eclipses(2024))
    #help(swe)
