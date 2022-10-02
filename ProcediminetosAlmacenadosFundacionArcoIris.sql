--esta PA devuelve las fechas y horas separadas
create procedure separaraFechaYHora
as
	begin 
		SELECT	 cod_asistencia,ID,
	 
		 CONVERT(VARCHAR(20), [hora_entrada], 103) AS Fecha_Entrada,
		 CONVERT(VARCHAR(20), [hora_entrada], 108) AS hora_Entrada,
         CONVERT(VARCHAR(20), [hora_salida], 103) AS Fecha_Salida,
		 CONVERT(VARCHAR(20), [hora_salida], 108) AS hora_Salida,
		 S_salida,
		 Motivo_salida
FROM     [Puntualidad]
	END




--este script make a procedimiento almacenado para enlazar la DB prueba y acceso

use Prueba
select * from OHEM where govID like '2150206-1E'

select * from Acceso.dbo.Puntualidad

select * from OHEM
inner join Acceso.dbo.Puntualidad on cast(Acceso.dbo.Puntualidad.ID as nvarchar(max)) = CAST( Prueba.dbo.OHEM.govID as nvarchar(max))
go
create procedure LinkDbAccesoSap
as
	begin
		select * from OHEM
		inner join Acceso.dbo.Puntualidad 
		on cast(Acceso.dbo.Puntualidad.ID as nvarchar(max)) = CAST( Prueba.dbo.OHEM.govID as nvarchar(max))
	end

execute LinkDbAccesoSap


--Calcular la jornada laboral segun el time
select * from Puntualidad
declare @jornada int, @fecha_top date, @fecha_down date
set @jornada = 8
set @fecha_top= '2022-03-01'
set @fecha_down = '2022-03-31'

SELECT	 cod_asistencia,ID,
	 
		 CONVERT(VARCHAR(20), [hora_entrada], 103) AS Fecha_Entrada,
		 CONVERT(VARCHAR(20), [hora_entrada], 108) AS hora_Entrada,
         CONVERT(VARCHAR(20), [hora_salida], 103) AS Fecha_Salida,
		 CONVERT(VARCHAR(20), [hora_salida], 108) AS hora_Salida,
		 DATEDIFF(SECOND,CONVERT(time, [hora_entrada], 108), CONVERT(TIME, [hora_salida], 108)) as tiempo_trabajado_en_segundos,
		 S_salida,
		 Motivo_salida
FROM     [Puntualidad] where hora_entrada between @fecha_top and @fecha_down

h_fin - h_ Inicio
select * from Puntualidad
delete from Puntualidad where cod_asistencia=8
insert into Puntualidad(ID, hora_entrada,hora_salida,S_salida,Motivo_salida)
values (6134475,'2022-01-03 08:00:00.763','2022-01-03 17:30:00.763',4444,'')



