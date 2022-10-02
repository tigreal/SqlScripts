/*
--------------------------------------------------------------------
© SQL Server TRY CATCH
--------------------------------------------------------------------
Name   : BikeStores
Link   : 
Version: 
--------------------------------------------------------------------
*/
go
begin try
end try
begin catch
end catch

/*
ERROR_LINE() devuelve el numero de linea donde esta el error
ERROR_MESSAGE() devuelve un texto generado por el error
ERROR_PROCEDURE()  devuelve el nombre de procedimiento almacenado
o el triger donde ocurrio el error
ERROR_NUMBER() devuelve el numero de error que ocurio
ERROR_SEVERITY() retorna el nivel de severidad del error ocurrido
ERROR_STATE() retorna el numero de estado del error ocurrido

solo se pueden usar estas funciones dentro del bloque CATCH si se usa fuera
de este bloque solo retornan NULL 
*/

--Bloques Try Catch anidadas
BEGIN TRY
	--declaracion
END TRY
BEGIN CATCH
	--declaracion
	BEGIN TRY
		--declaracion
	END TRY
	BEGIN CATCH
		--declaracion
	END CATCH
END CATCH

USE BikeStores
go
create procedure usp_divide
	@a decimal,
	@b decimal,
	@c decimal OUTPUT
AS
BEGIN
	BEGIN TRY
		SET @c=@a/@b;
	END TRY
	BEGIN CATCH
		select  
			ERROR_LINE() as numeroLinea,
			ERROR_MESSAGE() as severidadError,
			ERROR_PROCEDURE() as procedureError,
			ERROR_NUMBER() as numeroError,
			ERROR_SEVERITY() as severidadError,
			ERROR_STATE() as estadoError;
	END CATCH
END;
go

declare @r decimal;
execute usp_divide 10,2, @r output;
print @r;

--TRY CATCH con transacciones es bueno practica testear tus estados de trasaccion
--antes de usar COMMIT TRANSACTION o un ROLLBACK TRANSACTION detro de un CATCH block
-- usando XACT_STATE() 
--si
--XACT_STATE retorna -1 se debe aplicar ROLLBACK TRANSACTION
--XACT_STATE retorna 1 se debe aplicar COMMIT TRANSACTION
--XACT_STATE retorna 0 se debe aplicar nada no hay trasacciones pendientes de ningun tipo

go

create table sales.persons
(
	person_id int
	primary key identity,
	first_name nvarchar(100) not null,
	last_name nvarchar(100) not null
);

create table sales.deals
(
	deal_id int 
	primary key identity,
	person_id int not null,
	deal_note nvarchar(100),
	foreign key(person_id) references sales.persons(person_id)
);

insert into 
    sales.persons(first_name, last_name)
values
    ('John','Doe'),
    ('Jane','Doe');
--PARA VERIFICAR LO QUE HAY EN TABLA
select * from sales.persons

insert into 
    sales.deals(person_id, deal_note)
values
    (1,'Deal for John Doe');
go
create procedure usp_report_error
as
	select
		ERROR_LINE() as numeroLinea,
		ERROR_MESSAGE() as severidadError,
		ERROR_PROCEDURE() as procedureError,
		ERROR_NUMBER() as numeroError,
		ERROR_SEVERITY() as severidadError,
		ERROR_STATE() as estadoError;
go

create procedure usp_delete_person
	@person_id int
as
	begin
		begin try
			begin transaction
			delete from sales.persons
			where person_id = @person_id;
			commit transaction;
		end try
		begin catch
			execute usp_report_error;
			if XACT_STATE()=-1
			begin
				print 'la transaccion es uncommittable'+
					  'rolling back trasaction.'
				ROLLBACK TRANSACTION
			end
			if XACT_STATE()=1
			begin
				print 'la transaccion es comittable'+' comitting trasacion'
				COMMIT TRANSACTION;
			end;
		end catch
	end;
	go

execute usp_delete_person 2;



	

				





	

