database name: 'WorldEvents'
Ejercicio:'af-877'
descripcion: 'seleccionar la base de datos mediante una variable'
Ejercicio : 1
go
create procedure seleccionarTabla
@nombreTabla varchar(max)
as
	begin 
		declare @sqlQuery varchar(max)= 'select * from '+@nombreTabla;
		execute(@sqlQuery)
	end

go
declare @nombreTabla varchar(max)
execute seleccionarTabla @nombreTabla = 'tblCountry'

database name: 'WorldEvents'
Ejercicio:'af-863'
descripcion: 'seleccionar los paises segun el codigo de continente'
Ejercicio : 2

go 

create procedure seleccionarPaisPorContinente 
@codigoContinente int
as
	begin
		select ContinentID,CountryName 
		from tblCountry where ContinentID =@codigoContinente order by CountryName asc 
	end
go
declare @codigoContinente int
execute seleccionarPaisPorContinente @codigoContinente=2

database name: 'DoctorWho'
Ejercicio:'af-696'
descripcion: ''
Ejercicio : 3

go
create procedure buscarEnemigo
@nombreEnemigo varchar(max)
as 
	begin

		select SeriesNumber,EpisodeNumber,title from tblEpisode
		inner join tblEpisodeEnemy on tblEpisode.EpisodeId = tblEpisodeEnemy.EpisodeId 
		inner join tblEnemy on tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId where tblEnemy.EnemyName like '%'+@nombreEnemigo+'%'
	end
go
declare @nombreEnemigo varchar(max)
execute buscarEnemigo @nombreEnemigo = 'ood'


