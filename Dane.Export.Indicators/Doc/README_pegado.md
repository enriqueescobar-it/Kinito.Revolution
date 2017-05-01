# PROGRAMA PARA PEGAR BASES DE DATOS DE LOS REGISTROS DE LA GEIH

## Kinito Revolution

## PEGADO CABECERAS

### Ano 1-Mes 1

1. Abrir el archivo del registro 10 y pegarle horizontalmente las bases de los registros 50, 60, 70, 80, 90 y 95:

merge 1:1 directorio secuencia_p orden using "_rea_desocupados.dta"
drop _merge

merge 1:1 directorio secuencia_p orden using "_rea_fuerza_de_trabajo.dta"
drop _merge

merge 1:1 directorio secuencia_p orden using "_rea_inactivos.dta"
drop _merge

merge 1:1 directorio secuencia_p orden using "_rea_ocupados.dta"
drop _merge

merge 1:1 directorio secuencia_p orden using "_rea_otras_actividades_y_ayudas_en_la_semana.dta"
drop _merge

merge 1:1 directorio secuencia_p orden using "_rea_otros_ingresos.dta"
drop _merge

2. Pegar el registro 01 correspondiente a las viviendas:

merge m:1 directorio secuencia_p using "_rea_vivienda_y_hogares.dta"
drop _merge

3. Guardar la base de datos final:

save "C:\Users\DIES10\Desktop\Cartagena\Ano1-Mes3.dta"

### Ano 1-Mes 2

...

### Ano 1-Mes 3

...

### Ano 1-Trimestre 1

open   "C:\Users\DIES10\Desktop\Cartagena\Ano1-Mes1.dta"
append "C:\Users\DIES10\Desktop\Cartagena\Ano1-Mes2.dta"
append "C:\Users\DIES10\Desktop\Cartagena\Ano1-Mes3.dta"

save  "C:\Users\DIES10\Desktop\Cartagena\Ano1-Q1.dta"
