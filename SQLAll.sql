use Northwind
go

/*Querying Data
Filtering Data
Grouping Data
Ordering Data
Column Aliases
Table Aliases
Managing Transactions*/
--si esta en ANSI_NULLS ON cuando se use where nombre_columna = null, devolvera 0 filas asi haya nullos en esa columan 
SET ANSI_NULLS ON
create table #tempTable (sn int, ename varchar(50))
 
insert into #tempTable
values (1, 'Manoj'), (2, 'Pankaj'), (3, NULL), (4, 'Lokesh'), (5, 'Gopal')
SET ANSI_NULLS ON

select * from #tempTable where ename is NULL -- (1 row(s) affected)
select * from #tempTable where ename = NULL -- (0 row(s) affected)
select * from #tempTable where ename is not NULL -- (4 row(s) affected)
select * from #tempTable where ename <> NULL -- (0 row(s) affected)
SET ANSI_NULLS OFF

select * from #tempTable where ename is NULL -- (1 row(s) affected)
select * from #tempTable where ename = NULL -- (1 row(s) affected)
select * from #tempTable where ename is not NULL -- (4 row(s) affected)
select * from #tempTable where ename <> NULL -- (4 row(s) affected)

--esto evita que se devuel el mensaje  x filas afectadas por algun transa CRUD, es util si hablamos de miles de registros 
SET NOCOUNT ON;

--para seleccionar todas las tablas de la base de datos
SELECT * FROM INFORMATION_SCHEMA.TABLES
--de aqui sale el sp_help para describir una tabla de la base de datos
database.sys.sp_help
--para describir una tabla de la base datos sin esquema solo el .dbo
sp_help Employee
--para describir una tabla con esquema como ej: data_base.esquema.tabla, se deve encerrar en comas y se puede colocar execute caso contario sale un error 
--que no hay esa tabla por el esquema que lleva 
execute sp_help 'daba_base.sales.customers'

--Es mejor NVARCHAR que VARCHAR porque Varchar is dato no unicode, la colacion de la base
--que determinara que codigo de pagina de datos is usada
--y nvarchar es caracteres de datos unicode de longitud variable, que depende sobre la
--colacion de la base de datos para la comparacion.



select ContactName from Customers 
select GETDATE()
select @@VERSION
select SUSER_NAME()

--Funciones

select upper(ContactName) from Customers
select cast(PostalCode as varchar) from [Orders Qry]

--funciones agregadas
select count(*) from Customers
select max(Subtotal) from [Order Subtotals]
select sum(Subtotal) from [Order Subtotals]
--Filtering 
select * from Orders
select ContactName,Address,City from Customers where Address like '%al%'
select Subtotal from [Summary of Sales by Year] where ShippedDate between '10/07/1996 '

--Cuando se hacer referncia a una llave primaria desde otra tabla esta restricion es una llave foranea, cuando se borra un dato de la tabla donde
--esta la llave primaria indica que otra tabla tiene una llave foranea referenciada a su llave primaria y ese fila no se puede borrar
--para esto se usa el ON DELETE CASCADE

ALTER TABLE [dbo].[States]  WITH CHECK ADD  CONSTRAINT [FK_States_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
ON DELETE CASCADE
--para mostrar el script de una tabla
1)Go to your database
2)click derecho sobre la tabla o vista
3)Choose Script view as > Create To > New query window




