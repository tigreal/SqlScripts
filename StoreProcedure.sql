/*
--------------------------------------------------------------------
© 2017 sqlservertutorial.net All Rights Reserved
--------------------------------------------------------------------
Name   : BikeStores
Link   : http://www.sqlservertutorial.net/load-sample-database/
Version: 1.0
--------------------------------------------------------------------
*/

use Northwind
--se usa el go para para indicar que de aqui en adelante usamos la base de datos y creamo los procedimientos
go
create procedure selectAllCustomers
as 
select * from Customers
--para borrar los procedimientos almacenados
drop procedure selectAllCustomers

go
create procedure SelectAllCustomersCity @City nvarchar(30)
as
select * from Customers where City=@City
go;
--para ejecutar el procedimiento ejecutado 
exec SelectAllCustomersCity @City = 'London';


go
create procedure selectAllContactTitle @ContactTitle varchar(30)
as
select * from Customers where ContactTitle=@ContactTitle

--exec selectAllContactTitle @ContactTitle ='Owner'
go

create procedure selectAllCustomersCityPostalCode @City nvarchar(20), @PostalCode nvarchar(10)
as 
select * from Customers where City=@City and PostalCode=@PostalCode
go;

execute selectAllCustomersCityPostalCode @City = 'London', @PostalCode='Wa1 1DP'
go





create procedure PruductSumary
as
select * from Products

execute PruductSumary

create procedure addNewProduct
@name nvarchar(30),
@manufacturer nvarchar(20),
@productCount int,
@price MONEY
as
begin
	insert into Products(ProductName,Manufacture,ProductCount,Price)
	values(@name,@manufacturer,@productCount,@price)
end;

declare @productNname nvarchar(30), @company nvarchar(20)
declare @productCount int, @price money 
set @productNname='IPhone 7'
set @company = 'Apple'
set @price=99
set @productCount = 150
 
 execute addNewProduct @productNname,@company,@productCount,@price
 select * from Products

 go
 create procedure selectProductByManufacturer
 @manufacturer nvarchar(20)
 as 
	begin

		select * from Products
		where Manufacture = @manufacturer
	end;
--se puede pasar el valor del parametro directamente
	execute selectProductByManufacturer 'Apple'
--tambien se puede pasar el valor del parametro con su nombre
	execute selectProductByManufacturer @manufacturer = 'Apple'

--si olvidamos pasar un parametro sale un error pero si lo ponemos opcional dandole un valor predeterminado
create procedure AddNewProductWithOptionalCount
	@name nvarchar(20),
	@manufacturer nvarchar(20),
	@price money,
	@count int=1
as
	begin
		insert into Products(ProductName,Manufacture,Price,ProductCount) 
		values(@name,@manufacturer,@price,@count)

	end;

--un parametro optional es mejor ponerlo al final del lista de pramentros 	
execute AddNewProductWithOptionalCount 'Lenovo K12','Lenovo',399
select * from Products

--los parametros tambien pueden devolver datos, devolviendo algun resultado del procedimiento almacenado usando la palabra clave
--OUTPUT

go

use LearStoreProcedures
GO
create procedure GetMinMaxPruductPrice
	@minPrice money OUTPUT,
	@maxPrice money OUTPUT

as
	begin
	--cuando llamamos al procedimiento por los paramentros OUTPUT, las variables son pasadas a ellos
		select @minPrice=MIN(Price), @maxPrice=MAX(Price) from Products
	end;


declare @minPrice money,@maxPrice money;
execute GetMinMaxPruductPrice @minPrice OUTPUT, @maxPrice OUTPUT
print 'Min Price '+convert(varchar,@minPrice)
print 'max price '+convert(varchar,@maxPrice)

-- se puede combinar parametros de salida y entrada en los procedimientos

--procedimiento para borrar el un articulo de los productos por nombre

select * from Products

create procedure borrarProducto 
@nombreProducto nvarchar(30)
as
	begin

	delete from Products where ProductName = @nombreProducto
	end;

declare @nombreProducto nvarchar(20) 
set @nombreProducto='Mi 10S'
execute borrarProducto @nombreProducto
SELECT * from Products


select avg(Price) as Media from Products

create procedure CalcularMedia 
@media int OUTPUT
as
	begin
	select @media=avg(Price) from Products
	end;

declare @media int;
execute CalcularMedia @media OUTPUT
print 'Media '+convert(varchar,@media)


-- cambiando el procedimiento haciendole una actualizacion 
go
alter procedure CalcularMedia 
@media float OUTPUT
as
	begin
		select @media=avg(Price) from Products
	end;

declare @media float;
execute CalcularMedia @media OUTPUT
print 'Media '+convert(varchar,@media)

--Bucle de procedimientos almacenados

--bucle while

declare @ConditionalVariable int set @ConditionalVariable=10

While @ConditionalVariable < 10
	begin
		print 'iteraciones: ' +convert(varchar,@ConditionalVariable)
		set @ConditionalVariable=@ConditionalVariable+1
	end


declare @variableCondicional int set @variableCondicional=1
while @variableCondicional<10
	begin
		print 'vuelta numero '+convert(varchar,@variableCondicional)
		set @variableCondicional=@variableCondicional+1
	end

--usando un brake para que salga de la interacion 

declare @varCondicional int set @varCondicional=1

while @varCondicional<10
	begin
		if @varCondicional=8
			begin
			print 'es el numero '+convert(varchar,@varCondicional)
			break
			end
			set @varCondicional= @varCondicional+1
	end
--Muestra todas las tablas de la base de datos
select * from INFORMATION_SCHEMA.TABLES
--usando declaraciones de control if else
declare @condicion1 int
set @condicion1= (select count(*) from dbo.Products)
if @condicion1 < 10
	begin
	print 'es menor a 10'
	end
else
	begin
	print 'es mayor a 10'
	end
--usaremos la sentencia de if anidados

declare @condicionalAnidados int
set @condicionalAnidados= (select count(*) from Products)
if @condicionalAnidados < 10
	begin
		if @condicionalAnidados <5 
			begin
				print 'ahora si es menor a 5'
			end
		else 
			begin 
				print 'todavia no es menor a 5'
			end
	end
else 
	begin
		print 'no es menor a 10'
	end

--usando el if/else en un procedimiento almacenado
Select * from Products
go
create procedure sp_conditional_return
@parametro int
as
	begin 
		if @parametro = 1
			begin
				select  ProductName from Products
			end
		if @parametro = 2
			begin
				select Price from Products
			end
		select 'enter parameter value to be equal to 1 or 2' as [Error Message]
	end
	
execute sp_conditional_return 2
--borrar procedimientos almacenados
drop procedure sp_conditional_return 

go
use Northwind;
Drop procedure if exists select_employees;