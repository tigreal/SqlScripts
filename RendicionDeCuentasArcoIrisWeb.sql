use RendicionGasto
create table personal(
nombre nvarchar(100) not null,
apellido nvarchar(100) not null,
cargo nvarchar(50),
ci int not null, primary key(ci));

create table proyectos(
nombre_proy nvarchar(100) not null,
direcion nvarchar(100),
ci_personal int not null,
foreign key(ci_personal) references personal(ci) on delete cascade

);

--MS SQL identity ~ MYSQL auto_increment
alter table proyectos add cod int not null primary key identity(1,1);


create table areas(
nombre_area nvarchar(100) not null,
cod_proy int not null,
foreign key(cod_proy) references proyectos(cod) on delete cascade);
alter table areas add cod int not null primary key identity(1,1);

--referencia de on delete cascade para multiples llaves foranias en el evernote en ms sql
create table detalle_gastos(
nombre_gastos nvarchar(200) not null,
monto int not null,
fecha smalldatetime not null,
ci_personal int not null,
cod_proy int not null,
cod_areas int not null,
foreign key(ci_personal) references personal(ci) ON DELETE NO ACTION ON UPDATE NO ACTION,
foreign key(cod_proy) references proyectos(cod) ON DELETE NO ACTION ON UPDATE NO ACTION, 
foreign key(cod_areas) references areas(cod) ON DELETE NO ACTION ON UPDATE NO ACTION
);

create table lista_gastos(
nombre_gasto nvarchar(500) not null
);



--insertando datos
insert into  personal(nombre, apellido,cargo,ci) values('osmar','alvarez','sistemas',6134475);
insert into proyectos(nombre_proy,direcion,ci_personal) values('Esperanza','Alto Obrajes C. Gombles',6134475);
insert into areas(nombre_area,cod_proy) values('Educador',1);
insert into lista_gastos(nombre_gasto) values('Compra de tintas de color');
insert into detalle_gastos(ci_personal,cod_areas,cod_proy,fecha,monto,nombre_gastos) values(6134475,1,1,'01-01-2022 13:00:00',2100,'Compra de tintas de color');





select * from personal
select * from INFORMATION_SCHEMA.TABLES
