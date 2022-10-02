use BikeStores
--SE declara las variables
declare
@product_name varchar(max),
@list_price decimal;

--se declara el cursor
declare cursor_product CURSOR
for select 
		product_name,
		list_price
	from
		production.products;
--abrimos en cursor
open cursor_product;
--FETCH extraemos las filas desde el cursor dentro de una o mas variables


FETCH NEXT FROM cursor_product INTO

	@product_name,
	@list_price;

WHILE @@fetch_status=0
	begin
		print @product_name+' Precio:'+cast(@list_price as  varchar)
		fetch next from cursor_product INTO
		@product_name,
		@list_price;
	end;
--cerramos el cursor una vez se haya recorrido todas las filas
close cursor_product;

DEALLOCATE cursor_product;

select * from production.products
--mi cursor para sacar los datos de nombre de producto y el anio 
--declaramos las variables a usar
declare
@nombreProducto varchar(max),
@anioProducto int;

--declaramos el cursor 1er paso que va ser
declare producto_anio CURSOR
for select 
		product_name,
		model_year
	from
		production.products;
--abrimos el cursor 2do paso 

open producto_anio;

--hacemos el fetch y estraemos las variables como va ser
fetch next from producto_anio into 
@nombreProducto,
@anioProducto;

while @@FETCH_STATUS=0
	begin
		print @nombreProducto+' '+cast(@anioProducto as varchar);
		fetch next from producto_anio into
		@nombreProducto,
		@anioProducto;
	end;
--cerramos el cursor 
close producto_anio;
deallocate producto_anio;

select * from sales.customers

--declaramos variables 
declare
	@lastname varchar(max),
	@email varchar(max),
	@street varchar(max);

--declaramos el cursor
declare nombre_email_street CURSOR
for select
		last_name,
		email,
		street
	from
		sales.customers;
--abrimos el cursor
open nombre_email_street
--fetch donde estraemos los datos
fetch next from nombre_email_street into
	@lastname,
	@email,
	@street;

while @@FETCH_STATUS=0
	begin
		print 'nombre: '+@lastname+' Email: '+@email+' direccion:'+@street;
		fetch next from nombre_email_street into
		@lastname,
		@email,
		@street;
	end;

--cerramos el cursor
close nombre_email_street;
deallocate nombre_email_street;




