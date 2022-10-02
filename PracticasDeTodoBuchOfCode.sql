USE BikeStores

SELECT  * from INFORMATION_SCHEMA.TABLES
select * from sales.customers
select * from sales.orders

execute sp_help 'sales.orders'
execute sp_help 'sales.customers'
go
 create procedure borrarClienteCustomers
@customer_id nvarchar(max)
as
begin		
	begin try
		begin transaction
		delete from sales.customers
		where 
			customer_id=@customer_id;
		commit transaction;

	end try
	begin catch
		select  
			ERROR_LINE() as numeroLinea,
			ERROR_MESSAGE() as severidadError,
			ERROR_PROCEDURE() as procedureError,
			ERROR_NUMBER() as numeroError,
			ERROR_SEVERITY() as severidadError,
			ERROR_STATE() as estadoError;
		if XACT_STATE()=-1
			begin
				print 'la operacion no puede continuar';
				rollback transaction 
			end
		if XACT_STATE()=1
			begin
				print 'la operacion puede realizarse'
				commit transaction;
			end;
	END CATCH
end;
go
select * from sales.customers
execute borrarClienteCustomers 3;

go
create procedure PrintCustomers_Cursor

as
begin 
	set nocount on
	declare
		@customer_id int,
		@first_name nvarchar(100),
		@city nvarchar(100);
	declare 
		@counter int 
		set @counter=1;
	declare printCustomers cursor read_only
	for
		select 
			customer_id,
			first_name,
			city
		from
			sales.customers
	open printCustomers

	fetch next from PrintCustomers into 
	@customer_id,
	@first_name,
	@city

	while @@FETCH_STATUS=0
	begin
		if @counter=1
		begin
			print 'CustomerID'+char(9)+'Name'+char(9)+char(9)+char(9)+'country'
			print '-----------------------------------------'
		end

		print cast(@customer_id as varchar(10))+char(9)+char(9)+char(9)+@first_name+char(9)+@city

		set @counter=@counter+1

		fetch next from printCustomers into
		@customer_id,
		@first_name,
		@city
		end
		close printCustomers
		deallocate printCustomers
	end
go

execute PrintCustomers_Cursor

select * from INFORMATION_SCHEMA.TABLES
select * from production.products
sp_help 'production.products'

go
create procedure busqueda_precios
@precio decimal
as 
	begin
		declare 
			@nombre_producto nvarchar(200),
			@anio smallint,
			@lista_precio decimal;
		declare 
			@contador int 
			set @contador=1;

			declare recorrer_precios cursor read_only
			for
				select 
					product_name,
					model_year,
					list_price
				from production.products where list_price>=@precio
			open recorrer_precios
			fetch next from recorrer_precios into
			@nombre_producto,
			@anio,
			@lista_precio
				while @@FETCH_STATUS=0
					begin
					if @contador=1
						begin
							print 'Anio'+char(9)+char(9)+char(9)+char(9)+char(9)+'precio'+char(9)+char(9)+char(9)+'Nombre';
							print '--------------------------------------------------------------------------------'
						end
					print cast(@anio as varchar)+char(9)+cast(@lista_precio as varchar)+char(9)+@nombre_producto;
					set @contador=@contador+1
					fetch next from recorrer_precios into
					@nombre_producto,
					@anio,
					@lista_precio;
					end
				close recorrer_precios
				deallocate recorrer_precios
			end

select * from production.products
sp_help 'production.products'

drop procedure busqueda_precios
select  * from INFORMATION_SCHEMA.TABLES
execute busqueda_precios  5000
go
create procedure calculadora_ganancia
@indica_ganancia numeric(10,2)
as
	begin
		declare 
			@nombre_producto nvarchar(100),
			@anio smallint,
			@precio_lista numeric(10,2),
			@ganacia numeric(10,2)
		declare 
			@contador int
			set @contador=1;
		declare incrementador_ganacias cursor
		for
			select 
				product_name,
				model_year,
				list_price
			from
				production.products
		open incrementador_ganacias
		fetch next from incrementador_ganacias into
			@nombre_producto,
			@anio,
			@precio_lista;

			while @@FETCH_STATUS=0
			begin
				if @contador=1
					begin
						
						print 'Anio'+char(9)+'Precio'+char(9)+'Precio&Ganancia'+char(9)+'Nombre'
						print '---------------------------------------------'
					end
					set @ganacia= @precio_lista * @indica_ganancia;
					set @ganacia=@ganacia+@precio_lista
				print cast(@anio as nvarchar(100))+char(9)+cast(@precio_lista as nvarchar(100))+char(9)+
					  cast(@ganacia as nvarchar(100))+char(9)+char(9)+char(9)+@nombre_producto

				set @contador=@contador+1
				fetch next from incrementador_ganacias into
				@nombre_producto,
				@anio,
				@precio_lista			
			end
			
			close incrementador_ganacias
			deallocate incrementador_ganacias
		end
drop procedure calculadora_ganancia 
select * from production.products
-379.99
declare 
	@valor decimal(10,8)
	set @valor=0.50

execute calculadora_ganancia @valor 

	










		
						
					





		
		
	









	














