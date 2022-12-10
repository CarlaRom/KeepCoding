-- Práctica SQL
-- Alumna: Carla Romero Sansano

-- CREACIÓN DEL ESQUEMA DE TRABAJO --

create schema carla_romero_sansano authorization kafwbsft;


-- CREACIÓN DE TABLAS --

-- Grupo empresarial de la marca de coche. En un mismo grupo pueden haber varias marcas.

create table carla_romero_sansano.grupo_empresarial_marca(
	id_grupo_empresarial varchar(20) not null, --PK
	nombre varchar(200) not null,
	descripcion varchar(512) null
);

alter table carla_romero_sansano.grupo_empresarial_marca
add constraint grupo_empresarial_marca_PK primary key (id_grupo_empresarial);



-- Marcas de coche. Una misma marca tiene distintos modelos de coche.

create table carla_romero_sansano.marcas(
	id_marca varchar(20) not null, --PK
	nombre varchar(200) not null,
	id_grupo_empresarial varchar(20) not null, --FK -> grupo_empresarial_marca -> id_grupo_empresarial
	descripcion varchar(512) null
);

alter table carla_romero_sansano.marcas
add constraint marcas_PK primary key (id_marca);

alter table carla_romero_sansano.marcas
add constraint marcas_FK foreign key (id_grupo_empresarial)
references carla_romero_sansano.grupo_empresarial_marca(id_grupo_empresarial);



-- Modelos de coche.

create table carla_romero_sansano.modelos(
	id_modelo varchar(20) not null, --PK
	nombre varchar(200) not null,
	id_marca varchar(20) not null, --FK -> marcas -> id_marca
	descripcion varchar(512) null
);

alter table carla_romero_sansano.modelos
add constraint modelos_PK primary key (id_modelo);

alter table carla_romero_sansano.modelos
add constraint modelos_FK foreign key (id_marca)
references carla_romero_sansano.marcas(id_marca);



-- Colores de coche.

create table carla_romero_sansano.colores(
	id_color varchar(20) not null, --PK
	nombre varchar(200) not null,
	descripcion varchar(512) null
);

alter table carla_romero_sansano.colores
add constraint colores_PK primary key (id_color);



-- TABLA DE VEHÍCULOS

create table carla_romero_sansano.vehiculos(
	id_vehiculo varchar(20) not null, --PK
	fecha_compra date not null, --PK
	id_modelo varchar(20) not null, --FK
	id_color varchar(20) not null, --FK
	num_total_km integer not null
);

-- PK's

alter table carla_romero_sansano.vehiculos
add constraint vehiculos_PK primary key (id_vehiculo, fecha_compra);


-- FK's

alter table carla_romero_sansano.vehiculos
add constraint vehiculos_id_modelo_FK foreign key (id_modelo)
references carla_romero_sansano.modelos(id_modelo);

alter table carla_romero_sansano.vehiculos
add constraint vehiculos_id_color_FK foreign key (id_color)
references carla_romero_sansano.colores(id_color);




-- Aseguradoras. Compañías aseguradoras.

create table carla_romero_sansano.aseguradoras(
	id_aseguradora varchar(100) not null, --PK
	nombre varchar(256) not null,
	cif varchar(20) not null,
	descripcion varchar(512) null
);

alter table carla_romero_sansano.aseguradoras
add constraint aseguradoras_PK primary key (id_aseguradora);



-- Histórico de aseguradoras.

create table carla_romero_sansano.hist_aseguradoras_vehiculo(
	id_vehiculo varchar(20) not null, --PK, FK
	fecha_compra date not null, --PK, FK
	num_poliza integer not null, --PK
	fecha_inicio date not null, 
	fecha_fin date not null default '4000-01-01',
	id_aseguradora varchar(100) not null, --FK
	descripcion varchar(512) null
);

-- PK's
alter table carla_romero_sansano.hist_aseguradoras_vehiculo
add constraint hist_aseguradoras_vehiculo_PK primary key(id_vehiculo, fecha_compra, num_poliza);


-- FK's
alter table carla_romero_sansano.hist_aseguradoras_vehiculo
add constraint hist_aseguradoras_vehiculo_vehiculos_FK foreign key (id_vehiculo,fecha_compra)
references carla_romero_sansano.vehiculos(id_vehiculo,fecha_compra);


alter table carla_romero_sansano.hist_aseguradoras_vehiculo
add constraint hist_aseguradoras_vehiculo_aseguradoras_FK foreign key (id_aseguradora)
references carla_romero_sansano.aseguradoras(id_aseguradora);



-- Histórico de matrículas.

create table carla_romero_sansano.hist_matriculas_vehiculo(
	id_vehiculo varchar(20) not null, --PK, FK
	fecha_compra date not null, --PK, FK
	fecha_matriculacion date not null, --PK
	matricula varchar(20) not null,
	descripcion varchar(512) null
);

-- PK's
alter table carla_romero_sansano.hist_matriculas_vehiculo
add constraint hist_matriculas_vehiculo_PK primary key (id_vehiculo, fecha_compra, fecha_matriculacion);


-- FK's
alter table carla_romero_sansano.hist_matriculas_vehiculo
add constraint hist_matriculas_vehiculo_vehiculos_FK foreign key (id_vehiculo,fecha_compra)
references carla_romero_sansano.vehiculos(id_vehiculo,fecha_compra);






-- Monedas.

create table carla_romero_sansano.monedas(
	id_moneda varchar(20) not null, --PK
	nombre varchar(200) not null,
	descripcion varchar(512) null
);

alter table carla_romero_sansano.monedas
add constraint monedas_PK primary key (id_moneda);




-- Histórico de revisiones.

create table carla_romero_sansano.hist_revisiones_vehiculo(
	id_vehiculo varchar(20) not null, --PK, FK
	fecha_compra date not null, --PK, FK
	fecha_revision date not null, --PK 
	importe numeric(12,2) not null,
	num_km integer not null,
	id_moneda varchar(20) not null, --FK
	descripcion varchar(512) null
);

-- PK's

alter table carla_romero_sansano.hist_revisiones_vehiculo
add constraint hist_revisiones_vehiculo_PK primary key (id_vehiculo, fecha_compra, fecha_revision);


-- FK's
alter table carla_romero_sansano.hist_revisiones_vehiculo
add constraint hist_revisiones_vehiculo_vehiculos_FK foreign key (id_vehiculo,fecha_compra)
references carla_romero_sansano.vehiculos(id_vehiculo,fecha_compra);


alter table carla_romero_sansano.hist_revisiones_vehiculo
add constraint hist_revisiones_vehiculo_monedas_FK foreign key (id_moneda)
references carla_romero_sansano.monedas(id_moneda);








-- CARGA DE DATOS --

-- Grupos empresariales de las marcas de coche

insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G01','BMW Group','Marcas: Mini, Rolls Royce, BMW');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G02','Daimler','Marcas: Maybach, Mercedes-Benz, Smart');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G03','FCA','Marcas: Alfa Romeo, Abarth, Chrysler, Dodge, Fiat, Jeep, Lancia, Maserati, RAM');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G04','Ford','Marcas: Ford, The Lincoln Company, Troller');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G05','Geely','Marcas: Geely, The London Taxi Company, Volvo');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G06','General Motors','Marcas: Baojun, Buick, Cadillac, Chevrolet, GMC, Wuling Motors');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G07','Honda','Marcas: Acura, Honda');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G08','Hyundai','Marcas: Kia, Hyundai, Genesis');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G09','Renault-Nissan','Marcas: Renault, Nissan, Infiniti, Mitsubishi , Renault-Samsung, Alpine, Datsun, Lada, Dacia');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G10','PSA','Marcas: Citroën, DS Automoviles, Peugeot, Opel');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G11','Tata','Marcas: Jaguar, Land Rover, Tata Motors');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G12','Toyota','Marcas: Daihatsu, Lexus,Toyota');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G13','Volkswagen','Marcas: Audi, Bentley, Bugatti, Lamborghini, Porsche, SEAT, Skoda, Volkswagen');
insert into carla_romero_sansano.grupo_empresarial_marca (id_grupo_empresarial, nombre, descripcion) values('G14','Suzuki','Marcas: Suzuki');

--select * from carla_romero_sansano.grupo_empresarial_marca;



-- Marcas de coche

insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M01','Citroen','G10','Modelos: Picasso, C6');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M02','Fiat','G03','Modelos: Bravo, Punto');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M03','Ford','G04','Modelos: Fiesta, Focus');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M04','Hyundai','G08','Modelos: i40, Veloster');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M05','Nissan','G09','Modelos: Qashqai, Pulsar');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M06','Opel','G10','Modelos: Corsa, Astra');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M07','Renault','G09','Modelos: Megane, Scenic');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M08','Seat','G13','Modelos: Ibiza, León');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M09','Toyota','G12','Modelos: Auris, Corolla');
insert into carla_romero_sansano.marcas (id_marca, nombre, id_grupo_empresarial, descripcion) values('M10','Volkswagen','G13','Modelos: Golf, Polo');


--select * from carla_romero_sansano.marcas;



-- Modelos de coche

insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod01','Picasso','M01','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod02','C6','M01','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod03','Bravo','M02','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod04','Punto','M02','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod05','Fiesta','M03','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod06','Focus','M03','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod07','i40','M04','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod08','Veloster','M04','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod09','Qashqai','M05','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod10','Pulsar','M05','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod11','Corsa','M06','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod12','Astra','M06','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod13','Megane','M07','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod14','Scenic','M07','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod15','Ibiza','M08','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod16','León','M08','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod17','Auris','M09','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod18','Corolla','M09','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod19','Golf','M10','');
insert into carla_romero_sansano.modelos (id_modelo, nombre, id_marca, descripcion) values('Mod20','Polo','M10','');


--select * from carla_romero_sansano.modelos;



-- Colores

insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C01','Blanco','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C02','Gris','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C03','Negro','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C04','Plata','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C05','Azul','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C06','Rojo','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C07','Beige','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C08','Verde','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C09','Amarillo','');
insert into carla_romero_sansano.colores (id_color, nombre, descripcion) values('C10','Otro','');


--select * from carla_romero_sansano.colores;




-- VEHÍCULOS

insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V01','2018-01-10','Mod13','C06','80000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V02','2020-06-14','Mod11','C03','20000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V03','2016-03-15','Mod14','C04','100000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V04','2014-05-22','Mod15','C01','130000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V05','2020-09-07','Mod17','C05','12000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V06','2008-10-02','Mod20','C07','180000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V07','2021-11-20','Mod19','C03','6000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V08','2006-04-14','Mod01','C02','190000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V09','2006-06-20','Mod14','C02','189000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V10','2010-12-12','Mod05','C07','145000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V11','2005-07-23','Mod06','C06','195000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V12','2017-02-19','Mod02','C02','95000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V13','2012-05-03','Mod16','C01','121000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V14','2019-04-06','Mod03','C04','21100');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V15','2007-08-29','Mod18','C05','160000');
insert into carla_romero_sansano.vehiculos (id_vehiculo, fecha_compra, id_modelo, id_color, num_total_km) values('V16','2021-02-18','Mod10','C04','5000');


--select * from carla_romero_sansano.vehiculos;




-- Aseguradoras

insert into carla_romero_sansano.aseguradoras (id_aseguradora, nombre, cif, descripcion) values('A01','Mapfre','A08055741','');
insert into carla_romero_sansano.aseguradoras (id_aseguradora, nombre, cif, descripcion) values('A02','Axa','A60917978','');
insert into carla_romero_sansano.aseguradoras (id_aseguradora, nombre, cif, descripcion) values('A03','Generali','A28007268','');
insert into carla_romero_sansano.aseguradoras (id_aseguradora, nombre, cif, descripcion) values('A04','Allianz','A28007748','');
insert into carla_romero_sansano.aseguradoras (id_aseguradora, nombre, cif, descripcion) values('A05','Mutua Madrileña','V28027118','');



--select * from carla_romero_sansano.aseguradoras;



-- Histórico de aseguradoras 

insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V01','2018-01-10','123456','2018-01-10','A01','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V03','2016-03-15','789101','2016-03-15','A02','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V04','2014-05-22','112131','2014-05-22','A03','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V05','2020-09-07','415161','2020-09-07','A04','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V06','2008-10-02','718192','2008-10-02','A01','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V07','2021-11-20','212223','2021-11-20','A01','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V08','2006-04-14','242526','2006-04-14','A03','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V09','2006-06-20','272829','2006-06-20','A05','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V10','2010-12-12','303132','2010-12-12','A02','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V12','2017-02-19','333435','2017-02-19','A02','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V13','2012-05-03','363738','2012-05-03','A03','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V14','2019-04-06','394041','2019-04-06','A04','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V15','2007-08-29','424344','2007-08-29','A01','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V16','2021-02-18','454647','2021-02-18','A03','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V11','2005-07-23','515253','2008-07-24','A02','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, id_aseguradora, descripcion) values('V02','2020-06-14','575859','2021-06-15','A01','');


insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, fecha_fin, id_aseguradora, descripcion) values('V11','2005-07-23','484950','2005-07-23','2008-07-23','A04','');
insert into carla_romero_sansano.hist_aseguradoras_vehiculo (id_vehiculo, fecha_compra, num_poliza, fecha_inicio, fecha_fin, id_aseguradora, descripcion) values('V02','2020-06-14','545556','2020-06-14','2021-06-14','A05','');

select * from carla_romero_sansano.hist_aseguradoras_vehiculo;



--Histórico de matrículas


insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V01','2018-01-10','2018-01-10','2321KGP','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V02','2020-06-14','2020-06-14','1918LDT','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V03','2016-03-15','2016-03-15','4001JLC','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V04','2014-05-22','2014-05-22','3342HXC','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V05','2020-09-07','2020-09-07','4385LMC','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V06','2008-10-02','2008-10-02','1334FYY','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V07','2021-11-20','2021-11-20','4222LTY','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V08','2006-04-14','2006-04-14','2030DVF','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V09','2006-06-20','2006-06-20','2134DVH','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V10','2010-12-12','2010-12-12','1024GSS','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V11','2005-07-23','2005-07-23','1920DHZ','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V12','2017-02-19','2017-02-19','2360HVM','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V13','2012-05-03','2012-05-03','2345HHV','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V14','2019-04-06','2019-04-06','1516KVT','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V15','2007-08-29','2007-08-29','1242FKF','');
insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V16','2021-02-18','2021-02-18','S1746LPC','Matrícula temporal');

insert into carla_romero_sansano.hist_matriculas_vehiculo (id_vehiculo, fecha_compra, fecha_matriculacion, matricula, descripcion) values('V16','2021-02-18','2021-03-18','4399LMV','');

--select * from carla_romero_sansano.hist_matriculas_vehiculo;




--Monedas


insert into carla_romero_sansano.monedas (id_moneda, nombre, descripcion) values('EUR','Euro','');
insert into carla_romero_sansano.monedas (id_moneda, nombre, descripcion) values('USD','Dólar americano','');
insert into carla_romero_sansano.monedas (id_moneda, nombre, descripcion) values('GBP','Libra esterlina','');
insert into carla_romero_sansano.monedas (id_moneda, nombre, descripcion) values('ARS','Peso argentino','');
insert into carla_romero_sansano.monedas (id_moneda, nombre, descripcion) values('CHF','Franco suizo','');
insert into carla_romero_sansano.monedas (id_moneda, nombre, descripcion) values('CNY','Yuan chino','');
insert into carla_romero_sansano.monedas (id_moneda, nombre, descripcion) values('JPY','Yen','');


--select * from carla_romero_sansano.monedas;




--Histórico de revisiones


insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V01','2018-01-10','2019-11-02','60.00','95000','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V03','2016-03-15','2019-03-15','80.00','130000','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V03','2016-03-15','2020-08-11','100.15','130500','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V04','2014-05-22','2016-02-14','165.50','132000','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V04','2014-05-22','2018-05-15','230.20','134000','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V06','2008-10-02','2011-08-01','54.00','182000','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V06','2008-10-02','2013-08-18','200.00','182500','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V06','2008-10-02','2015-07-11','253.00','183000','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V08','2006-04-14','2010-04-10','270.80','192000','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V08','2006-04-14','2011-04-10','180.00','192300','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V08','2006-04-14','2012-04-03','162.00','192400','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V11','2005-07-23','2009-04-20','200.00','198000','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V11','2005-07-23','2010-03-15','250.65','199800','EUR');
insert into carla_romero_sansano.hist_revisiones_vehiculo (id_vehiculo, fecha_compra, fecha_revision, importe, num_km, id_moneda) values('V11','2005-07-23','2012-05-11','180.99','200500','EUR');



--select * from carla_romero_sansano.hist_revisiones_vehiculo;