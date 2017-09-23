CREATE TABLE Oficinas (
  CodigoOficina varchar(10) NOT NULL,
  Ciudad varchar(30) NOT NULL,
  Pais varchar(50) NOT NULL,
  Region varchar(50) DEFAULT NULL,
  CodigoPostal varchar(10) NOT NULL,
  Telefono varchar(20) NOT NULL,
  LineaDireccion1 varchar(50) NOT NULL,
  LineaDireccion2 varchar(50) DEFAULT NULL,
  PRIMARY KEY (CodigoOficina)
) ;

INSERT INTO Oficinas VALUES ('BCN-ES','Barcelona','Espa�a','Barcelona','08019','+34 93 3561182','Avenida Diagonal, 38','3A escalera Derecha');
INSERT INTO Oficinas VALUES ('BOS-USA','Boston','EEUU','MA','02108','+1 215 837 0825','1550 Court Place','Suite 102');
INSERT INTO Oficinas VALUES ('LON-UK','Londres','Inglaterra','EMEA','EC2N 1HN','+44 20 78772041','52 Old Broad Street','Ground Floor');
INSERT INTO Oficinas VALUES ('MAD-ES','Madrid','Espa�a','Madrid','28032','+34 91 7514487','Bulevar Indalecio Prieto, 32','');
INSERT INTO Oficinas VALUES ('PAR-FR','Paris','Francia','EMEA','75017','+33 14 723 4404','29 Rue Jouffroy d''abbans','');
INSERT INTO Oficinas VALUES ('SFC-USA','San Francisco','EEUU','CA','94080','+1 650 219 4782','100 Market Street','Suite 300');
INSERT INTO Oficinas VALUES ('SYD-AU','Sydney','Australia','APAC','NSW 2010','+61 2 9264 2451','5-11 Wentworth Avenue','Floor #2');
INSERT INTO Oficinas VALUES ('TAL-ES','Talavera de la Reina','Espa�a','Castilla-LaMancha','45632','+34 925 867231','Francisco Aguirre, 32','5� piso (exterior)');
INSERT INTO Oficinas VALUES ('TOK-JP','Tokyo','Jap�n','Chiyoda-Ku','102-8578','+81 33 224 5000','4-1 Kioicho','');

CREATE TABLE Empleados2 (
  CodigoEmpleado integer NOT NULL,
  Nombre varchar(50) NOT NULL,
  Apellido1 varchar(50) NOT NULL,
  Apellido2 varchar(50) DEFAULT NULL,
  Extension varchar(10) NOT NULL,
  Email varchar(100) NOT NULL,
  CodigoOficina varchar(10) NOT NULL,
  CodigoJefe integer DEFAULT NULL,
  Puesto varchar(50) DEFAULT NULL,
  PRIMARY KEY (CodigoEmpleado),
  CONSTRAINT Empleados_OficinasFK FOREIGN KEY (CodigoOficina) REFERENCES Oficinas (CodigoOficina),
  CONSTRAINT Empleados_EmpleadosFK FOREIGN KEY (CodigoJefe) REFERENCES Empleados2 (CodigoEmpleado)
);

INSERT INTO Empleados2 VALUES (1,'Marcos','Maga�a','Perez','3897','marcos@jardineria.es','TAL-ES',NULL,'Director General');
INSERT INTO Empleados2 VALUES (2,'Ruben','L�pez','Martinez','2899','rlopez@jardineria.es','TAL-ES',1,'Subdirector Marketing');
INSERT INTO Empleados2 VALUES (3,'Alberto','Soria','Carrasco','2837','asoria@jardineria.es','TAL-ES',2,'Subdirector Ventas');
INSERT INTO Empleados2 VALUES (4,'Maria','Sol�s','Jerez','2847','msolis@jardineria.es','TAL-ES',2,'Secretaria');
INSERT INTO Empleados2 VALUES (5,'Felipe','Rosas','Marquez','2844','frosas@jardineria.es','TAL-ES',3,'Representante Ventas');
INSERT INTO Empleados2 VALUES (6,'Juan Carlos','Ortiz','Serrano','2845','cortiz@jardineria.es','TAL-ES',3,'Representante Ventas');
INSERT INTO Empleados2 VALUES (7,'Carlos','Soria','Jimenez','2444','csoria@jardineria.es','MAD-ES',3,'Director Oficina');
INSERT INTO Empleados2 VALUES (8,'Mariano','L�pez','Murcia','2442','mlopez@jardineria.es','MAD-ES',7,'Representante Ventas');
INSERT INTO Empleados2 VALUES (9,'Lucio','Campoamor','Mart�n','2442','lcampoamor@jardineria.es','MAD-ES',7,'Representante Ventas');
INSERT INTO Empleados2 VALUES (10,'Hilario','Rodriguez','Huertas','2444','hrodriguez@jardineria.es','MAD-ES',7,'Representante Ventas');
INSERT INTO Empleados2 VALUES (11,'Emmanuel','Maga�a','Perez','2518','manu@jardineria.es','BCN-ES',3,'Director Oficina');
INSERT INTO Empleados2 VALUES (12,'Jos� Manuel','Martinez','De la Osa','2519','jmmart@hotmail.es','BCN-ES',11,'Representante Ventas');
INSERT INTO Empleados2 VALUES (13,'David','Palma','Aceituno','2519','dpalma@jardineria.es','BCN-ES',11,'Representante Ventas');
CREATE TABLE GamasProductos (
  Gama varchar(50) NOT NULL,
  DescripcionTexto clob,
  DescripcionHTML clob,
  Imagen blob,
  PRIMARY KEY (Gama)
);
INSERT INTO GamasProductos VALUES ('Herbaceas','Plantas para jardin decorativas',NULL,NULL);
INSERT INTO GamasProductos VALUES ('Herramientas','Herramientas para todo tipo de acci�n',NULL,NULL);
INSERT INTO GamasProductos VALUES ('Arom�ticas','Plantas arom�ticas',NULL,NULL);
INSERT INTO GamasProductos VALUES ('Frutales','�rboles peque�os de producci�n frutal',NULL,NULL);
INSERT INTO GamasProductos VALUES ('Ornamentales','Plantas vistosas para la decoraci�n del jard�n',NULL,NULL);



CREATE TABLE Clientes (
  CodigoCliente integer NOT NULL,
  NombreCliente varchar(50) NOT NULL,
  NombreContacto varchar(30) DEFAULT NULL,
  ApellidoContacto varchar(30) DEFAULT NULL,
  Telefono varchar(15) NOT NULL,
  Fax varchar(15) NOT NULL,
  LineaDireccion1 varchar(50) NOT NULL,
  LineaDireccion2 varchar(50) DEFAULT NULL,
  Ciudad varchar(50) NOT NULL,
  Region varchar(50) DEFAULT NULL,
  Pais varchar(50) DEFAULT NULL,
  CodigoPostal varchar(10) DEFAULT NULL,
  CodigoEmpleadoRepVentas integer DEFAULT NULL,
  LimiteCredito number(15,2) DEFAULT NULL,
  PRIMARY KEY (CodigoCliente),
  CONSTRAINT Clientes_EmpleadosFK FOREIGN KEY (CodigoEmpleadoRepVentas) REFERENCES Empleados2 (CodigoEmpleado)
) ;

INSERT INTO Clientes VALUES (1,'DGPRODUCTIONS GARDEN','Daniel G','GoldFish','5556901745','5556901746','False Street 52 2 A',NULL,'San Francisco',NULL,'USA','24006',9,3000);
INSERT INTO Clientes VALUES (3,'Gardening Associates','Anne','Wright','5557410345','5557410346','Wall-e Avenue',NULL,'Miami','Miami','USA','24010',9,6000);
INSERT INTO Clientes VALUES (4,'Gerudo Valley','Link','Flaute','5552323129','5552323128','Oaks Avenue n�22',NULL,'New York',NULL,'USA','85495',2,12000);
INSERT INTO Clientes VALUES (5,'Tendo Garden','Akane','Tendo','55591233210','55591233211','Null Street n�69',NULL,'Miami',NULL,'USA','696969',2,600000);
INSERT INTO Clientes VALUES (6,'Lasas S.A.','Antonio','Lasas','34916540145','34914851312','C/Leganes 15',NULL,'Fuenlabrada','Madrid','Spain','28945',8,154310);
INSERT INTO Clientes VALUES (7,'Beragua','Jose','Bermejo','654987321','916549872','C/pintor segundo','Getafe','Madrid','Madrid','Espa�a','28942',1,20000);
INSERT INTO Clientes VALUES (8,'Club Golf Puerta del hierro','Paco','Lopez','62456810','919535678','C/sinesio delgado','Madrid','Madrid','Madrid','Espa�a','28930',1,40000);
INSERT INTO Clientes VALUES (9,'Naturagua','Guillermo','Rengifo','689234750','916428956','C/majadahonda','Boadilla','Madrid','Madrid','Espa�a','28947',1,32000);

CREATE TABLE Pedidos2 (
  CodigoPedido integer NOT NULL,
  FechaPedido date NOT NULL,
  FechaEsperada date NOT NULL,
  FechaEntrega date DEFAULT NULL,
  Estado varchar(15) NOT NULL,
  Comentarios CLOB,
  CodigoCliente integer NOT NULL,
  PRIMARY KEY (CodigoPedido),
  CONSTRAINT Pedidos_Cliente FOREIGN KEY (CodigoCliente) REFERENCES Clientes (CodigoCliente)
);


INSERT INTO Pedidos2 VALUES (1,'17-1-2006','19-1-2006','19-1-2006','Entregado','Pagado a plazos',5);
INSERT INTO Pedidos2 VALUES (2,'23-10-2007','28-10-2007','26-10-2007','Entregado','La entrega llego antes de lo esperado',5);
INSERT INTO Pedidos2 VALUES (3,'20-6-2008','25-5-2008',NULL,'Rechazado','Limite de credito superado',5);
INSERT INTO Pedidos2 VALUES (4,'20-1-2009','26-1-2009',NULL,'Pendiente',NULL,5);
INSERT INTO Pedidos2 VALUES (8,'09-11-2008','14-11-2008','14-11-2008','Entregado','El cliente paga la mitad con tarjeta y la otra mitad con efectivo, se le realizan dos facturas',1);
INSERT INTO Pedidos2 VALUES (9,'22-12-2008','27-12-2008','28-12-2008','Entregado','El cliente comprueba la integridad del paquete, todo correcto',1);
INSERT INTO Pedidos2 VALUES (10,'15-01-2009','20-01-2009',NULL,'Pendiente','El cliente llama para confirmar la fecha - Esperando al proveedor',3);
INSERT INTO Pedidos2 VALUES (11,'20-1-2009','27-01-2009',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 16:00h a 22:00h',1);
INSERT INTO Pedidos2 VALUES (12,'22-01-2009','27-1-2009',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 9:00h a 13:00h',1);
INSERT INTO Pedidos2 VALUES (13,'12-1-2009','14-1-2009','15-1-2009','entregado',NULL,7);
INSERT INTO Pedidos2 VALUES (14,'2-1-2009','2-1-2009',null,'rechazado','mal pago',7);
INSERT INTO Pedidos2 VALUES (15,'9-1-2009','12-1-2009','11-1-2009','entregado',NULL,7);
INSERT INTO Pedidos2 VALUES (16,'6-1-2009','7-1-2009','15-1-2009','entregado',NULL,7);
INSERT INTO Pedidos2 VALUES (17,'08-1-2009','9-1-2009','11-1-2009','entregado','mal estado',7);
INSERT INTO Pedidos2 VALUES (18,'5-1-2009','6-1-2009','7-1-2009','entregado',NULL,9);
INSERT INTO Pedidos2 VALUES (19,'18-1-2009','12-2-2009',NULL,'pendiente','entregar en murcia',9);
INSERT INTO Pedidos2 VALUES (20,'20-1-2009','15-2-2009',NULL,'pendiente',NULL,9);

CREATE TABLE Productos (
  CodigoProducto varchar(15) NOT NULL,
  Nombre varchar(70) NOT NULL,
  Gama varchar(50) NOT NULL,
  Dimensiones varchar(25) NULL,
  Proveedor varchar(50) DEFAULT NULL,
  Descripcion clob NULL,
  CantidadEnStock smallint NOT NULL,
  PrecioVenta number(15,2) NOT NULL,
  PrecioProveedor number(15,2) DEFAULT NULL,
  PRIMARY KEY (CodigoProducto),
  CONSTRAINT Productos_gamaFK FOREIGN KEY (Gama) REFERENCES GamasProductos (Gama)
) ;

INSERT INTO Productos VALUES ('11679','Sierra de Poda 400MM','Herramientas','0,258','HiperGarden Tools','Gracias a la poda se consigue manipular un poco la naturaleza, d�ndole la forma que m�s nos guste. Este trabajo b�sico de jardiner�a tambi�n facilita que las plantas crezcan de un modo m�s equilibrado, y que las flores y los frutos vuelvan cada a�o con regularidad. Lo mejor es dar forma cuando los ejemplares son j�venes, de modo que exijan pocos cuidados cuando sean adultos. Adem�s de saber cu�ndo y c�mo hay que podar, tener unas herramientas adecuadas para esta labor es tambi�n de vital importancia.',15,14,11);
INSERT INTO Productos VALUES ('21636','Pala','Herramientas','0,156','HiperGarden Tools','Palas de acero con cresta de corte en la punta para cortar bien el terreno. Buena penetraci�n en tierras muy compactas.',15,14,13);
INSERT INTO Productos VALUES ('22225','Rastrillo de Jard�n','Herramientas','1,064','HiperGarden Tools','Fabuloso rastillo que le ayudar� a eliminar piedras, hojas, ramas y otros elementos inc�modos en su jard�n.',15,12,11);
INSERT INTO Productos VALUES ('30310','Azad�n','Herramientas','0,168','HiperGarden Tools','Longitud:24cm. Herramienta fabricada en acero y pintura epoxi,alargando su durabilidad y preveniendo la corrosi�n.Dise�o pensado para el ahorro de trabajo.',15,12,11);
INSERT INTO Productos VALUES ('AR-001','Ajedrea','Arom�ticas','15-20','Murcia Seasons','Planta arom�tica que fresca se utiliza para condimentar carnes y ensaladas, y seca, para pastas, sopas y guisantes',140,1,0);
INSERT INTO Productos VALUES ('AR-002','Lav�ndula Dentata','Arom�ticas','15-20','Murcia Seasons','Espliego de jard�n, Alhucema rizada, Alhucema dentada, Cantueso rizado. Familia: Lamiaceae.Origen: Espa�a y Portugal. Mata de unos 60 cm de alto. Las hojas son arom�ticas, dentadas y de color verde gris�ceas.  Produce compactas espigas de flores peque�as, ligeramente arom�ticas, tubulares,de color azulado y con br�cteas p�rpuras.  Frutos: nuececillas alargadas encerradas en el tubo del c�liz.  Se utiliza en jardineria y no en perfumeria como otros cantuesos, espliegos y lavandas.  Tiene propiedades aromatizantes y calmantes. Adecuadas para la formaci�n de setos bajos. Se dice que su aroma ahuyenta pulgones y otros insectos perjudiciales para las plantas vecinas.',140,1,0);
INSERT INTO Productos VALUES ('AR-003','Mejorana','Arom�ticas','15-20','Murcia Seasons','Origanum majorana. No hay que confundirlo con el or�gano. Su sabor se parece m�s al tomillo, pero es m�s dulce y arom�tico.Se usan las hojas frescas o secas, picadas, machacadas o en polvo, en sopas, rellenos, quiches y tartas, tortillas, platos con papas y, como aderezo, en ramilletes de hierbas.El sabor delicado de la mejorana se elimina durante la cocci�n, de manera que es mejor agregarla cuando el plato est� en su punto o en aqu�llos que apenas necesitan cocci�n.',140,1,0);
INSERT INTO Productos VALUES ('AR-004','Melissa ','Arom�ticas','15-20','Murcia Seasons','Es una planta perenne (dura varios a�os) conocida por el agradable y caracter�stico olor a lim�n que desprenden en verano. Nunca debe faltar en la huerta o jard�n por su agradable aroma y por los variados usos que tiene: planta olorosa, condimentaria y medicinal. Su cultivo es muy f�cil. Le va bien un suelo ligero, con buen drenaje y riego sin exceso. A pleno sol o por lo menos 5 horas de sol por d�a. Cada a�o, su abonado mineral correspondiente.En oto�o, la melisa pierde el agradable olor a lim�n que desprende en verano sus flores azules y blancas. En este momento se debe cortar a unos 20 cm. del suelo. Brotar� de forma densa en primavera.',140,1,0);
INSERT INTO Productos VALUES ('AR-005','Mentha Sativa','Arom�ticas','15-20','Murcia Seasons','¿Qui�n no conoce la Hierbabuena? Se trata de una plantita muy arom�tica, agradable y cultivada extensamente por toda Espa�a. Es hierba perenne (por tanto vive varios a�os, no es anual). Puedes cultivarla en maceta o plantarla en la tierra del jard�n o en un rinc�n del huerto. Lo m�s importante es que cuente con bastante agua. En primavera debes aportar fertilizantes minerales. Vive mejor en semisombra que a pleno sol.Si ves orugas o los agujeros en hojas consecuencia de su ataque, ret�ralas una a una a mano; no uses insecticidas qu�micos.',140,1,0);
INSERT INTO Productos VALUES ('AR-006','Petrosilium Hortense (Peregil)','Arom�ticas','15-20','Murcia Seasons','Nombre cient�fico o latino: Petroselinum hortense, Petroselinum crispum. Nombre com�n o vulgar: Perejil, Perejil rizado Familia: Umbelliferae (Umbel�feras). Origen: el origen del perejil se encuentra en el Mediterraneo. Esta naturalizada en casi toda Europa. Se utiliza como condimento y para adorno, pero tambi�n en ensaladas. Se suele regalar en las fruter�as y verduler�as.El perejil lo hay de 2 tipos: de hojas planas y de hojas rizadas.',140,1,0);
INSERT INTO Productos VALUES ('AR-007','Salvia Mix','Arom�ticas','15-20','Murcia Seasons','La Salvia es un peque�o arbusto que llega hasta el metro de alto.Tiene una vida breve, de unos pocos a�os.En el jard�n, como otras arom�ticas, queda muy bien en una rocalla o para hacer una bordura perfumada a cada lado de un camino de Salvia. Abona despu�s de cada corte y recorta el arbusto una vez pase la floraci�n.',140,1,0);
INSERT INTO Productos VALUES ('AR-008','Thymus Citriodra (Tomillo lim�n)','Arom�ticas','15-20','Murcia Seasons','Nombre com�n o vulgar: Tomillo, Tremoncillo Familia: Labiatae (Labiadas).Origen: Regi�n mediterr�nea.Arbustillo bajo, de 15 a 40 cm de altura. Las hojas son muy peque�as, de unos 6 mm de longitud; seg�n la variedad pueden ser verdes, verdes gris�ceas, amarillas, o jaspeadas. Las flores aparecen de mediados de primavera hasta bien entrada la �poca estival y se presentan en racimos terminales que habitualmente son de color violeta o p�rpura aunque tambi�n pueden ser blancas. Esta planta despide un intenso y t�pico aroma, que se incrementa con el roce. El tomillo resulta de gran belleza cuando est� en flor. El tomillo atrae a avispas y abejas. En jardiner�a se usa como manchas, para hacer borduras, para aromatizar el ambiente, llenar huecos, cubrir rocas, para jardines en miniatura, etc. Arranque las flores y hojas secas del tallo y a�ad�los a un popurri, introd�zcalos en saquitos de hierbas o en la almohada.Tambi�n puede usar las ramas secas con flores para a�adir aroma y textura a cestos abiertos.',140,1,0);
INSERT INTO Productos VALUES ('AR-009','Thymus Vulgaris','Arom�ticas','15-20','Murcia Seasons','Nombre com�n o vulgar: Tomillo, Tremoncillo Familia: Labiatae (Labiadas). Origen: Regi�n mediterr�nea. Arbustillo bajo, de 15 a 40 cm de altura. Las hojas son muy peque�as, de unos 6 mm de longitud; seg�n la variedad pueden ser verdes, verdes gris�ceas, amarillas, o jaspeadas. Las flores aparecen de mediados de primavera hasta bien entrada la �poca estival y se presentan en racimos terminales que habitualmente son de color violeta o p�rpura aunque tambi�n pueden ser blancas. Esta planta despide un intenso y t�pico aroma, que se incrementa con el roce. El tomillo resulta de gran belleza cuando est� en flor. El tomillo atrae a avispas y abejas.\r\n En jardiner�a se usa como manchas, para hacer borduras, para aromatizar el ambiente, llenar huecos, cubrir rocas, para jardines en miniatura, etc. Arranque las flores y hojas secas del tallo y a�ad�los a un popurri, introd�zcalos en saquitos de hierbas o en la almohada. Tambi�n puede usar las ramas secas con flores para a�adir aroma y textura a cestos abiertos.',140,1,0);
INSERT INTO Productos VALUES ('AR-010','Santolina Chamaecyparys','Arom�ticas','15-20','Murcia Seasons','',140,1,0);
INSERT INTO Productos VALUES ('FR-1','Expositor C�tricos Mix','Frutales','100-120','Frutales Talavera S.A','',15,7,5);
INSERT INTO Productos VALUES ('FR-10','Limonero 2 a�os injerto','Frutales','','NaranjasValencianas.com','El limonero, pertenece al grupo de los c�tricos, teniendo su origen hace unos 20 millones de a�os en el sudeste asi�tico. Fue introducido por los �rabes en el �rea mediterr�nea entre los a�os 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selecci�n natural mediante hibridaciones espont�neas como a las producidas por el hombre, en este caso buscando las necesidades del mercado.',15,7,5);
INSERT INTO Productos VALUES ('FR-100','Nectarina','Frutales','8/10','Frutales Talavera S.A','Se trata de un �rbol derivado por mutaci�n de los melocotoneros comunes, y los �nicos caracteres diferenciales son la ausencia de tomentosidad en la piel del fruto. La planta, si se deja crecer libremente, adopta un porte globoso con unas dimensiones medias de 4-6 metros',50,11,8);
INSERT INTO Productos VALUES ('FR-101','Nogal','Frutales','8/10','Frutales Talavera S.A','',50,13,10);
INSERT INTO Productos VALUES ('FR-102','Olea-Olivos','Frutales','8/10','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',50,18,14);
INSERT INTO Productos VALUES ('FR-103','Olea-Olivos','Frutales','10/12','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',50,25,20);
INSERT INTO Productos VALUES ('FR-104','Olea-Olivos','Frutales','12/4','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',50,49,39);
INSERT INTO Productos VALUES ('FR-105','Olea-Olivos','Frutales','14/16','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',50,70,56);
INSERT INTO Productos VALUES ('FR-106','Peral','Frutales','8/10','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',50,11,8);
INSERT INTO Productos VALUES ('FR-107','Peral','Frutales','10/12','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',50,22,17);
INSERT INTO Productos VALUES ('FR-108','Peral','Frutales','12/14','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',50,32,25);
INSERT INTO Productos VALUES ('FR-11','Limonero 30/40','Frutales','','NaranjasValencianas.com','El limonero, pertenece al grupo de los c�tricos, teniendo su origen hace unos 20 millones de a�os en el sudeste asi�tico. Fue introducido por los �rabes en el �rea mediterr�nea entre los a�os 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selecci�n natural mediante hibridaciones espont�neas como a las producidas por el',15,100,80);
INSERT INTO Productos VALUES ('FR-12','Kunquat ','Frutales','','NaranjasValencianas.com','su nombre cient�fico se origina en honor a un hoticultor escoc�s que recolect� espec�menes en China, (\"Fortunella\"), Robert Fortune (1812-1880), y \"margarita\", del lat�n margaritus-a-um = perla, en alusi�n a sus peque�os y brillantes frutos. Se trata de un arbusto o �rbol peque�o de 2-3 m de altura, inerme o con escasas espinas.Hojas lanceoladas de 4-8 (-15) cm de longitud, con el �pice redondeado y la base cuneada.Tienen el margen crenulado en su mitad superior, el haz verde brillante y el env�s m�s p�lido.Pec�olo ligeramente marginado.Flores perfumadas solitarias o agrupadas en inflorescencias axilares, blancas.El fruto es lo m�s caracter�stico, es el m�s peque�o de todos los c�tricos y el �nico cuya c�scara se puede comer.Frutos peque�os, con semillas, de corteza fina, dulce, arom�tica y comestible, y de pulpa naranja amarillenta y ligeramente �cida.Sus frutos son muy peque�os y tienen un car�cter principalmente ornamental.',15,21,16);
INSERT INTO Productos VALUES ('FR-13','Kunquat  EXTRA con FRUTA','Frutales','150-170','NaranjasValencianas.com','su nombre cient�fico se origina en honor a un hoticultor escoc�s que recolect� espec�menes en China, (\"Fortunella\"), Robert Fortune (1812-1880), y \"margarita\", del lat�n margaritus-a-um = perla, en alusi�n a sus peque�os y brillantes frutos. Se trata de un arbusto o �rbol peque�o de 2-3 m de altura, inerme o con escasas espinas.Hojas lanceoladas de 4-8 (-15) cm de longitud, con el �pice redondeado y la base cuneada.Tienen el margen crenulado en su mitad superior, el haz verde brillante y el env�s m�s p�lido.Pec�olo ligeramente marginado.Flores perfumadas solitarias o agrupadas en inflorescencias axilares, blancas.El fruto es lo m�s caracter�stico, es el m�s peque�o de todos los c�tricos y el �nico cuya c�scara se puede comer.Frutos peque�os, con semillas, de corteza fina, dulce, arom�tica y comestible, y de pulpa naranja amarillenta y ligeramente �cida.Sus frutos son muy peque�os y tienen un car�cter principalmente ornamental.',15,57,45);
INSERT INTO Productos VALUES ('FR-14','Calamondin Mini','Frutales','','Frutales Talavera S.A','Se trata de un peque�o arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son peque�as, el�pticas de 5-10 cm de longitud, con los pec�olos estrechamente alados.Posee 1 o 2 flores en situaci�n axilar, al final de las ramillas.Sus frutos son muy peque�os (3-3,5 cm de di�metro), con pocas semillas, esf�ricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y f�cilmente separable de la pulpa, que es dulce, �cida y comestible..',15,10,8);
INSERT INTO Productos VALUES ('FR-15','Calamondin Copa ','Frutales','','Frutales Talavera S.A','Se trata de un peque�o arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son peque�as, el�pticas de 5-10 cm de longitud, con los pec�olos estrechamente alados.Posee 1 o 2 flores en situaci�n axilar, al final de las ramillas.Sus frutos son muy peque�os (3-3,5 cm de di�metro), con pocas semillas, esf�ricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y f�cilmente separable de la pulpa, que es dulce, �cida y comestible..',15,25,20);
INSERT INTO Productos VALUES ('FR-16','Calamondin Copa EXTRA Con FRUTA','Frutales','100-120','Frutales Talavera S.A','Se trata de un peque�o arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son peque�as, el�pticas de 5-10 cm de longitud, con los pec�olos estrechamente alados.Posee 1 o 2 flores en situaci�n axilar, al final de las ramillas.Sus frutos son muy peque�os (3-3,5 cm de di�metro), con pocas semillas, esf�ricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y f�cilmente separable de la pulpa, que es dulce, �cida y comestible..',15,45,36);
INSERT INTO Productos VALUES ('FR-17','Rosal bajo 1ª -En maceta-inicio brotaci�n','Frutales','','Frutales Talavera S.A','',15,2,1);
INSERT INTO Productos VALUES ('FR-18','ROSAL TREPADOR','Frutales','','Frutales Talavera S.A','',350,4,3);
INSERT INTO Productos VALUES ('FR-19','Camelia Blanco, Chrysler Rojo, Soraya Naranja, ','Frutales','','NaranjasValencianas.com','',350,4,3);
INSERT INTO Productos VALUES ('FR-2','Naranjo -Plant�n joven 1 a�o injerto','Frutales','','NaranjasValencianas.com','El naranjo es un �rbol peque�o, que no supera los 3-5 metros de altura, con una copa compacta, c�nica, transformada en es�rica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, cori�ceas, de un verde intenso y brillante, con forma oval o el�ptico-lanceolada. Poseen, en el caso del naranjo amargo, un t�pico peciolo alado en forma de coraz�n, que en el naranjo dulce es m�s estrecho y menos patente.',15,6,4);
INSERT INTO Productos VALUES ('FR-20','Landora Amarillo, Rose Gaujard bicolor blanco-rojo','Frutales','','Frutales Talavera S.A','',350,4,3);
INSERT INTO Productos VALUES ('FR-21','Kordes Perfect bicolor rojo-amarillo, Roundelay rojo fuerte','Frutales','','Frutales Talavera S.A','',350,4,3);
INSERT INTO Productos VALUES ('FR-22','Pitimini rojo','Frutales','','Frutales Talavera S.A','',350,4,3);
INSERT INTO Productos VALUES ('FR-23','Rosal copa ','Frutales','','Frutales Talavera S.A','',400,8,6);
INSERT INTO Productos VALUES ('FR-24','Albaricoquero Corbato','Frutales','','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
INSERT INTO Productos VALUES ('FR-25','Albaricoquero Moniqui','Frutales','','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
INSERT INTO Productos VALUES ('FR-26','Albaricoquero Kurrot','Frutales','','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
INSERT INTO Productos VALUES ('FR-27','Cerezo Burlat','Frutales','','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',400,8,6);
INSERT INTO Productos VALUES ('FR-28','Cerezo Picota','Frutales','','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',400,8,6);
INSERT INTO Productos VALUES ('FR-29','Cerezo Napole�n','Frutales','','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',400,8,6);
INSERT INTO Productos VALUES ('FR-3','Naranjo 2 a�os injerto','Frutales','','NaranjasValencianas.com','El naranjo es un �rbol peque�o, que no supera los 3-5 metros de altura, con una copa compacta, c�nica, transformada en es�rica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, cori�ceas, de un verde intenso y brillante, con forma oval o el�ptico-lanceolada. Poseen, en el caso del naranjo amargo, un t�pico peciolo alado en forma de coraz�n, que en el naranjo dulce es m�s estrecho y menos patente.',15,7,5);
INSERT INTO Productos VALUES ('FR-30','Ciruelo R. Claudia Verde   ','Frutales','','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO Productos VALUES ('FR-31','Ciruelo Santa Rosa','Frutales','','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO Productos VALUES ('FR-32','Ciruelo Golden Japan','Frutales','','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO Productos VALUES ('FR-33','Ciruelo Friar','Frutales','','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO Productos VALUES ('FR-34','Ciruelo Reina C. De Ollins','Frutales','','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO Productos VALUES ('FR-35','Ciruelo Claudia Negra','Frutales','','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO Productos VALUES ('FR-36','Granado Mollar de Elche','Frutales','','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',400,9,7);
INSERT INTO Productos VALUES ('FR-37','Higuera Napolitana','Frutales','','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',400,9,7);
INSERT INTO Productos VALUES ('FR-38','Higuera Verdal','Frutales','','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',400,9,7);
INSERT INTO Productos VALUES ('FR-39','Higuera Breva','Frutales','','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',400,9,7);
INSERT INTO Productos VALUES ('FR-4','Naranjo calibre 8/10','Frutales','','NaranjasValencianas.com','El naranjo es un �rbol peque�o, que no supera los 3-5 metros de altura, con una copa compacta, c�nica, transformada en es�rica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, cori�ceas, de un verde intenso y brillante, con forma oval o el�ptico-lanceolada. Poseen, en el caso del naranjo amargo, un t�pico peciolo alado en forma de coraz�n, que en el naranjo dulce es m�s estrecho y menos patente.',15,29,23);
INSERT INTO Productos VALUES ('FR-40','Manzano Starking Delicious','Frutales','','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',400,8,6);
INSERT INTO Productos VALUES ('FR-41','Manzano Reineta','Frutales','','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',400,8,6);
INSERT INTO Productos VALUES ('FR-42','Manzano Golden Delicious','Frutales','','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',400,8,6);
INSERT INTO Productos VALUES ('FR-43','Membrillero Gigante de Wranja','Frutales','','Frutales Talavera S.A','',400,8,6);
INSERT INTO Productos VALUES ('FR-44','Melocotonero Spring Crest','Frutales','','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
INSERT INTO Productos VALUES ('FR-45','Melocotonero Amarillo de Agosto','Frutales','','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
INSERT INTO Productos VALUES ('FR-46','Melocotonero Federica','Frutales','','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
INSERT INTO Productos VALUES ('FR-47','Melocotonero Paraguayo','Frutales','','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
INSERT INTO Productos VALUES ('FR-48','Nogal Com�n','Frutales','','Frutales Talavera S.A','',400,9,7);
INSERT INTO Productos VALUES ('FR-49','Parra Uva de Mesa','Frutales','','Frutales Talavera S.A','',400,8,6);
INSERT INTO Productos VALUES ('FR-5','Mandarino -Plant�n joven','Frutales','','Frutales Talavera S.A','',15,6,4);
INSERT INTO Productos VALUES ('FR-50','Peral Castell','Frutales','','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',400,8,6);
INSERT INTO Productos VALUES ('FR-51','Peral Williams','Frutales','','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',400,8,6);
INSERT INTO Productos VALUES ('FR-52','Peral Conference','Frutales','','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',400,8,6);
INSERT INTO Productos VALUES ('FR-53','Peral Blanq. de Aranjuez','Frutales','','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',400,8,6);
INSERT INTO Productos VALUES ('FR-54','N�spero Tanaca','Frutales','','Frutales Talavera S.A','Aunque originario del Sudeste de China, el n�spero lleg� a Europa procedente de Jap�n en el siglo XVIII como �rbol ornamental. En el siglo XIX se inici� el consumo de los frutos en toda el �rea mediterr�nea, donde se adapt� muy bien a las zonas de cultivo de los c�tricos.El cultivo intensivo comenz� a desarrollarse a finales de los a�os 60 y principios de los 70, cuando comenzaron a implantarse las variedades y t�cnicas de cultivo actualmente utilizadas.',400,9,7);
INSERT INTO Productos VALUES ('FR-55','Olivo Cipresino','Frutales','','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',400,8,6);
INSERT INTO Productos VALUES ('FR-56','Nectarina','Frutales','','Frutales Talavera S.A','',400,8,6);
INSERT INTO Productos VALUES ('FR-57','Kaki Rojo Brillante','Frutales','','NaranjasValencianas.com','De crecimiento algo lento los primeros a�os, llega a alcanzar hasta doce metros de altura o m�s, aunque en cultivo se prefiere algo m�s bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte m�s o menos piramidal, aunque con la edad se hace m�s globoso.',400,9,7);
INSERT INTO Productos VALUES ('FR-58','Albaricoquero','Frutales','8/10','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,11,8);
INSERT INTO Productos VALUES ('FR-59','Albaricoquero','Frutales','10/12','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,22,17);
INSERT INTO Productos VALUES ('FR-6','Mandarino 2 a�os injerto','Frutales','','Frutales Talavera S.A','',15,7,5);
INSERT INTO Productos VALUES ('FR-60','Albaricoquero','Frutales','12/14','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,32,25);
INSERT INTO Productos VALUES ('FR-61','Albaricoquero','Frutales','14/16','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,49,39);
INSERT INTO Productos VALUES ('FR-62','Albaricoquero','Frutales','16/18','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,70,56);
INSERT INTO Productos VALUES ('FR-63','Cerezo','Frutales','8/10','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',300,11,8);
INSERT INTO Productos VALUES ('FR-64','Cerezo','Frutales','10/12','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',15,22,17);
INSERT INTO Productos VALUES ('FR-65','Cerezo','Frutales','12/14','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',200,32,25);
INSERT INTO Productos VALUES ('FR-66','Cerezo','Frutales','14/16','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',50,49,39);
INSERT INTO Productos VALUES ('FR-67','Cerezo','Frutales','16/18','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',50,70,56);
INSERT INTO Productos VALUES ('FR-68','Cerezo','Frutales','18/20','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',50,80,64);
INSERT INTO Productos VALUES ('FR-69','Cerezo','Frutales','20/25','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',50,91,72);
INSERT INTO Productos VALUES ('FR-7','Mandarino calibre 8/10','Frutales','','Frutales Talavera S.A','',15,29,23);
INSERT INTO Productos VALUES ('FR-70','Ciruelo','Frutales','8/10','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,11,8);
INSERT INTO Productos VALUES ('FR-71','Ciruelo','Frutales','10/12','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,22,17);
INSERT INTO Productos VALUES ('FR-72','Ciruelo','Frutales','12/14','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,32,25);
INSERT INTO Productos VALUES ('FR-73','Granado','Frutales','8/10','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,13,10);
INSERT INTO Productos VALUES ('FR-74','Granado','Frutales','10/12','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,22,17);
INSERT INTO Productos VALUES ('FR-75','Granado','Frutales','12/14','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,32,25);
INSERT INTO Productos VALUES ('FR-76','Granado','Frutales','14/16','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,49,39);
INSERT INTO Productos VALUES ('FR-77','Granado','Frutales','16/18','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,70,56);
INSERT INTO Productos VALUES ('FR-78','Higuera','Frutales','8/10','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,15,12);
INSERT INTO Productos VALUES ('FR-79','Higuera','Frutales','10/12','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,22,17);
INSERT INTO Productos VALUES ('FR-8','Limonero -Plant�n joven','Frutales','','NaranjasValencianas.com','El limonero, pertenece al grupo de los c�tricos, teniendo su origen hace unos 20 millones de a�os en el sudeste asi�tico. Fue introducido por los �rabes en el �rea mediterr�nea entre los a�os 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selecci�n natural mediante hibridaciones espont�neas como a las producidas por el',15,6,4);
INSERT INTO Productos VALUES ('FR-80','Higuera','Frutales','12/14','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,32,25);
INSERT INTO Productos VALUES ('FR-81','Higuera','Frutales','14/16','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,49,39);
INSERT INTO Productos VALUES ('FR-82','Higuera','Frutales','16/18','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,70,56);
INSERT INTO Productos VALUES ('FR-83','Higuera','Frutales','18/20','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,80,64);
INSERT INTO Productos VALUES ('FR-84','Kaki','Frutales','8/10','NaranjasValencianas.com','De crecimiento algo lento los primeros a�os, llega a alcanzar hasta doce metros de altura o m�s, aunque en cultivo se prefiere algo m�s bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte m�s o menos piramidal, aunque con la edad se hace m�s globoso.',50,13,10);
INSERT INTO Productos VALUES ('FR-85','Kaki','Frutales','16/18','NaranjasValencianas.com','De crecimiento algo lento los primeros a�os, llega a alcanzar hasta doce metros de altura o m�s, aunque en cultivo se prefiere algo m�s bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte m�s o menos piramidal, aunque con la edad se hace m�s globoso.',50,70,56);
INSERT INTO Productos VALUES ('FR-86','Manzano','Frutales','8/10','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',50,11,8);
INSERT INTO Productos VALUES ('FR-87','Manzano','Frutales','10/12','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',50,22,17);
INSERT INTO Productos VALUES ('FR-88','Manzano','Frutales','12/14','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',50,32,25);
INSERT INTO Productos VALUES ('FR-89','Manzano','Frutales','14/16','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',50,49,39);
INSERT INTO Productos VALUES ('FR-9','Limonero calibre 8/10','Frutales','','NaranjasValencianas.com','El limonero, pertenece al grupo de los c�tricos, teniendo su origen hace unos 20 millones de a�os en el sudeste asi�tico. Fue introducido por los �rabes en el �rea mediterr�nea entre los a�os 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selecci�n natural mediante hibridaciones espont�neas como a las producidas por el',15,29,23);
INSERT INTO Productos VALUES ('FR-90','N�spero','Frutales','16/18','Frutales Talavera S.A','Aunque originario del Sudeste de China, el n�spero lleg� a Europa procedente de Jap�n en el siglo XVIII como �rbol ornamental. En el siglo XIX se inici� el consumo de los frutos en toda el �rea mediterr�nea, donde se adapt� muy bien a las zonas de cultivo de los c�tricos.El cultivo intensivo comenz� a desarrollarse a finales de los a�os 60 y principios de los 70, cuando comenzaron a implantarse las variedades y t�cnicas de cultivo actualmente utilizadas.',50,70,56);
INSERT INTO Productos VALUES ('FR-91','N�spero','Frutales','18/20','Frutales Talavera S.A','Aunque originario del Sudeste de China, el n�spero lleg� a Europa procedente de Jap�n en el siglo XVIII como �rbol ornamental. En el siglo XIX se inici� el consumo de los frutos en toda el �rea mediterr�nea, donde se adapt� muy bien a las zonas de cultivo de los c�tricos.El cultivo intensivo comenz� a desarrollarse a finales de los a�os 60 y principios de los 70, cuando comenzaron a implantarse las variedades y t�cnicas de cultivo actualmente utilizadas.',50,80,64);
INSERT INTO Productos VALUES ('FR-92','Melocotonero','Frutales','8/10','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,11,8);
INSERT INTO Productos VALUES ('FR-93','Melocotonero','Frutales','10/12','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,22,17);
INSERT INTO Productos VALUES ('FR-94','Melocotonero','Frutales','12/14','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,32,25);
INSERT INTO Productos VALUES ('FR-95','Melocotonero','Frutales','14/16','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,49,39);
INSERT INTO Productos VALUES ('FR-96','Membrillero','Frutales','8/10','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, gris�cea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas j�venes tomentosas',50,11,8);
INSERT INTO Productos VALUES ('FR-97','Membrillero','Frutales','10/12','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, gris�cea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas j�venes tomentosas',50,22,17);
INSERT INTO Productos VALUES ('FR-98','Membrillero','Frutales','12/14','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, gris�cea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas j�venes tomentosas',50,32,25);
INSERT INTO Productos VALUES ('FR-99','Membrillero','Frutales','14/16','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, gris�cea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas j�venes tomentosas',50,49,39);
INSERT INTO Productos VALUES ('OR-001','Arbustos Mix Maceta','Ornamentales','40-60','Valencia Garden Service','',25,5,4);
INSERT INTO Productos VALUES ('OR-100','Mimosa Injerto CLASICA Dealbata ','Ornamentales','100-110','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,12,9);
INSERT INTO Productos VALUES ('OR-101','Expositor Mimosa Semilla Mix','Ornamentales','170-200','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
INSERT INTO Productos VALUES ('OR-102','Mimosa Semilla Bayleyana  ','Ornamentales','170-200','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
INSERT INTO Productos VALUES ('OR-103','Mimosa Semilla Bayleyana   ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
INSERT INTO Productos VALUES ('OR-104','Mimosa Semilla Cyanophylla    ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
INSERT INTO Productos VALUES ('OR-105','Mimosa Semilla Espectabilis  ','Ornamentales','160-170','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
INSERT INTO Productos VALUES ('OR-106','Mimosa Semilla Longifolia   ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
INSERT INTO Productos VALUES ('OR-107','Mimosa Semilla Floribunda 4 estaciones','Ornamentales','120-140','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
INSERT INTO Productos VALUES ('OR-108','Abelia Floribunda','Ornamentales','35-45','Viveros EL OASIS','',100,5,4);
INSERT INTO Productos VALUES ('OR-109','Callistemom (Mix)','Ornamentales','35-45','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ah� lo de \"llor�n\")..',100,5,4);
INSERT INTO Productos VALUES ('OR-110','Callistemom (Mix)','Ornamentales','40-60','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ah� lo de \"llor�n\")..',100,2,1);
INSERT INTO Productos VALUES ('OR-111','Corylus Avellana \"Contorta\"','Ornamentales','35-45','Viveros EL OASIS','',100,5,4);
INSERT INTO Productos VALUES ('OR-112','Escallonia (Mix)','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-113','Evonimus Emerald Gayeti','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-114','Evonimus Pulchellus','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-115','Forsytia Intermedia \"Lynwood\"','Ornamentales','35-45','Viveros EL OASIS','',120,7,5);
INSERT INTO Productos VALUES ('OR-116','Hibiscus Syriacus  \"Diana\" -Blanco Puro','Ornamentales','35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser f�cilmente moldeadas como bons�i en el transcurso de pocos a�os. Flores de muchos colores seg�n la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 d�a, pero continuamente aparecen nuevas y la floraci�n se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
INSERT INTO Productos VALUES ('OR-117','Hibiscus Syriacus  \"Helene\" -Blanco-C.rojo','Ornamentales','35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser f�cilmente moldeadas como bons�i en el transcurso de pocos a�os. Flores de muchos colores seg�n la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 d�a, pero continuamente aparecen nuevas y la floraci�n se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
INSERT INTO Productos VALUES ('OR-118','Hibiscus Syriacus \"Pink Giant\" Rosa','Ornamentales','35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser f�cilmente moldeadas como bons�i en el transcurso de pocos a�os. Flores de muchos colores seg�n la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 d�a, pero continuamente aparecen nuevas y la floraci�n se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
INSERT INTO Productos VALUES ('OR-119','Laurus Nobilis Arbusto - Ramificado Bajo','Ornamentales','40-50','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-120','Lonicera Nitida ','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-121','Lonicera Nitida \"Maigrum\"','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-122','Lonicera Pileata','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-123','Philadelphus \"Virginal\"','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-124','Prunus pisardii  ','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-125','Viburnum Tinus \"Eve Price\"','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-126','Weigelia \"Bristol Ruby\"','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO Productos VALUES ('OR-127','Camelia japonica','Ornamentales','40-60','Viveros EL OASIS','Arbusto excepcional por su floraci�n oto�al, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el �pice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de diàmetro y tienen 5 s�palos y 5 p�talos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,7,5);
INSERT INTO Productos VALUES ('OR-128','Camelia japonica ejemplar','Ornamentales','200-250','Viveros EL OASIS','Arbusto excepcional por su floraci�n oto�al, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el �pice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de diàmetro y tienen 5 s�palos y 5 p�talos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,98,78);
INSERT INTO Productos VALUES ('OR-129','Camelia japonica ejemplar','Ornamentales','250-300','Viveros EL OASIS','Arbusto excepcional por su floraci�n oto�al, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el �pice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de diàmetro y tienen 5 s�palos y 5 p�talos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,110,88);
INSERT INTO Productos VALUES ('OR-130','Callistemom COPA','Ornamentales','110/120','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ah� lo de \"llor�n\")..',50,18,14);
INSERT INTO Productos VALUES ('OR-131','Leptospermum formado PIRAMIDE','Ornamentales','80-100','Viveros EL OASIS','',50,18,14);
INSERT INTO Productos VALUES ('OR-132','Leptospermum COPA','Ornamentales','110/120','Viveros EL OASIS','',50,18,14);
INSERT INTO Productos VALUES ('OR-133','Nerium oleander-CALIDAD \"GARDEN\"','Ornamentales','40-45','Viveros EL OASIS','',50,2,1);
INSERT INTO Productos VALUES ('OR-134','Nerium Oleander Arbusto GRANDE','Ornamentales','160-200','Viveros EL OASIS','',100,38,30);
INSERT INTO Productos VALUES ('OR-135','Nerium oleander COPA  Calibre 6/8','Ornamentales','50-60','Viveros EL OASIS','',100,5,4);
INSERT INTO Productos VALUES ('OR-136','Nerium oleander ARBOL Calibre 8/10','Ornamentales','225-250','Viveros EL OASIS','',100,18,14);
INSERT INTO Productos VALUES ('OR-137','ROSAL TREPADOR','Ornamentales','','Viveros EL OASIS','',100,4,3);
INSERT INTO Productos VALUES ('OR-138','Camelia Blanco, Chrysler Rojo, Soraya Naranja, ','Ornamentales','','Viveros EL OASIS','',100,4,3);
INSERT INTO Productos VALUES ('OR-139','Landora Amarillo, Rose Gaujard bicolor blanco-rojo','Ornamentales','','Viveros EL OASIS','',100,4,3);
INSERT INTO Productos VALUES ('OR-140','Kordes Perfect bicolor rojo-amarillo, Roundelay rojo fuerte','Ornamentales','','Viveros EL OASIS','',100,4,3);
INSERT INTO Productos VALUES ('OR-141','Pitimini rojo','Ornamentales','','Viveros EL OASIS','',100,4,3);
INSERT INTO Productos VALUES ('OR-142','Solanum Jazminoide','Ornamentales','150-160','Viveros EL OASIS','',100,2,1);
INSERT INTO Productos VALUES ('OR-143','Wisteria Sinensis  azul, rosa, blanca','Ornamentales','','Viveros EL OASIS','',100,9,7);
INSERT INTO Productos VALUES ('OR-144','Wisteria Sinensis INJERTADAS DECÓ','Ornamentales','140-150','Viveros EL OASIS','',100,12,9);
INSERT INTO Productos VALUES ('OR-145','Bougamvillea Sanderiana Tutor','Ornamentales','80-100','Viveros EL OASIS','',100,2,1);
INSERT INTO Productos VALUES ('OR-146','Bougamvillea Sanderiana Tutor','Ornamentales','125-150','Viveros EL OASIS','',100,4,3);
INSERT INTO Productos VALUES ('OR-147','Bougamvillea Sanderiana Tutor','Ornamentales','180-200','Viveros EL OASIS','',100,7,5);
INSERT INTO Productos VALUES ('OR-148','Bougamvillea Sanderiana Espaldera','Ornamentales','45-50','Viveros EL OASIS','',100,7,5);
INSERT INTO Productos VALUES ('OR-149','Bougamvillea Sanderiana Espaldera','Ornamentales','140-150','Viveros EL OASIS','',100,17,13);
INSERT INTO Productos VALUES ('OR-150','Bougamvillea roja, naranja','Ornamentales','110-130','Viveros EL OASIS','',100,2,1);
INSERT INTO Productos VALUES ('OR-151','Bougamvillea Sanderiana, 3 tut. piramide','Ornamentales','','Viveros EL OASIS','',100,6,4);
INSERT INTO Productos VALUES ('OR-152','Expositor �rboles clima continental','Ornamentales','170-200','Viveros EL OASIS','',100,6,4);
INSERT INTO Productos VALUES ('OR-153','Expositor �rboles clima mediterr�neo','Ornamentales','170-200','Viveros EL OASIS','',100,6,4);
INSERT INTO Productos VALUES ('OR-154','Expositor �rboles borde del mar','Ornamentales','170-200','Viveros EL OASIS','',100,6,4);
INSERT INTO Productos VALUES ('OR-155','Acer Negundo  ','Ornamentales','200-225','Viveros EL OASIS','',100,6,4);
INSERT INTO Productos VALUES ('OR-156','Acer platanoides  ','Ornamentales','200-225','Viveros EL OASIS','',100,10,8);
INSERT INTO Productos VALUES ('OR-157','Acer Pseudoplatanus ','Ornamentales','200-225','Viveros EL OASIS','',100,10,8);
INSERT INTO Productos VALUES ('OR-158','Brachychiton Acerifolius  ','Ornamentales','200-225','Viveros EL OASIS','',100,6,4);
INSERT INTO Productos VALUES ('OR-159','Brachychiton Discolor  ','Ornamentales','200-225','Viveros EL OASIS','',100,6,4);
INSERT INTO Productos VALUES ('OR-160','Brachychiton Rupestris','Ornamentales','170-200','Viveros EL OASIS','',100,10,8);
INSERT INTO Productos VALUES ('OR-161','Cassia Corimbosa  ','Ornamentales','200-225','Viveros EL OASIS','',100,6,4);
INSERT INTO Productos VALUES ('OR-162','Cassia Corimbosa ','Ornamentales','200-225','Viveros EL OASIS','',100,10,8);
INSERT INTO Productos VALUES ('OR-163','Chitalpa Summer Bells   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-164','Erytrina Kafra','Ornamentales','170-180','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-165','Erytrina Kafra','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-166','Eucalyptus Citriodora  ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-167','Eucalyptus Ficifolia  ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-168','Eucalyptus Ficifolia   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-169','Hibiscus Syriacus  Var. Injertadas 1 Tallo ','Ornamentales','170-200','Viveros EL OASIS','',80,12,9);
INSERT INTO Productos VALUES ('OR-170','Lagunaria Patersonii  ','Ornamentales','140-150','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-171','Lagunaria Patersonii   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-172','Lagunaria patersonii  calibre 8/10','Ornamentales','200-225','Viveros EL OASIS','',80,18,14);
INSERT INTO Productos VALUES ('OR-173','Morus Alba  ','Ornamentales','200-225','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-174','Morus Alba  calibre 8/10','Ornamentales','200-225','Viveros EL OASIS','',80,18,14);
INSERT INTO Productos VALUES ('OR-175','Platanus Acerifolia   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-176','Prunus pisardii  ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-177','Robinia Pseudoacacia Casque Rouge   ','Ornamentales','200-225','Viveros EL OASIS','',80,15,12);
INSERT INTO Productos VALUES ('OR-178','Salix Babylonica  Pendula  ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-179','Sesbania Punicea   ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-180','Tamarix  Ramosissima Pink Cascade   ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-181','Tamarix  Ramosissima Pink Cascade   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-182','Tecoma Stands   ','Ornamentales','200-225','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-183','Tecoma Stands  ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-184','Tipuana Tipu  ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-185','Pleioblastus distichus-Bamb� enano','Ornamentales','15-20','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-186','Sasa palmata ','Ornamentales','20-30','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-187','Sasa palmata ','Ornamentales','40-45','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-188','Sasa palmata ','Ornamentales','50-60','Viveros EL OASIS','',80,25,20);
INSERT INTO Productos VALUES ('OR-189','Phylostachys aurea','Ornamentales','180-200','Viveros EL OASIS','',80,22,17);
INSERT INTO Productos VALUES ('OR-190','Phylostachys aurea','Ornamentales','250-300','Viveros EL OASIS','',80,32,25);
INSERT INTO Productos VALUES ('OR-191','Phylostachys Bambusa Spectabilis','Ornamentales','180-200','Viveros EL OASIS','',80,24,19);
INSERT INTO Productos VALUES ('OR-192','Phylostachys biseti','Ornamentales','160-170','Viveros EL OASIS','',80,22,17);
INSERT INTO Productos VALUES ('OR-193','Phylostachys biseti','Ornamentales','160-180','Viveros EL OASIS','',80,20,16);
INSERT INTO Productos VALUES ('OR-194','Pseudosasa japonica (Metake)','Ornamentales','225-250','Viveros EL OASIS','',80,20,16);
INSERT INTO Productos VALUES ('OR-195','Pseudosasa japonica (Metake) ','Ornamentales','30-40','Viveros EL OASIS','',80,6,4);
INSERT INTO Productos VALUES ('OR-196','Cedrus Deodara ','Ornamentales','80-100','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-197','Cedrus Deodara \"Feeling Blue\" Novedad','Ornamentales','rastrero','Viveros EL OASIS','',80,12,9);
INSERT INTO Productos VALUES ('OR-198','Juniperus chinensis \"Blue Alps\"','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO Productos VALUES ('OR-199','Juniperus Chinensis Stricta','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO Productos VALUES ('OR-200','Juniperus horizontalis Wiltonii','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO Productos VALUES ('OR-201','Juniperus squamata \"Blue Star\"','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO Productos VALUES ('OR-202','Juniperus x media Phitzeriana verde','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO Productos VALUES ('OR-203','Pinus Canariensis','Ornamentales','80-100','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-204','Pinus Halepensis','Ornamentales','160-180','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-205','Pinus Pinea -Pino Pi�onero','Ornamentales','70-80','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-206','Thuja Esmeralda ','Ornamentales','80-100','Viveros EL OASIS','',80,5,4);
INSERT INTO Productos VALUES ('OR-207','Tuja Occidentalis Woodwardii','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO Productos VALUES ('OR-208','Tuja orientalis \"Aurea nana\"','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO Productos VALUES ('OR-209','Archontophoenix Cunninghamiana','Ornamentales','80 - 100','Viveros EL OASIS','',80,10,8);
INSERT INTO Productos VALUES ('OR-210','Beucarnea Recurvata','Ornamentales','130  - 150','Viveros EL OASIS','',2,39,31);
INSERT INTO Productos VALUES ('OR-211','Beucarnea Recurvata','Ornamentales','180 - 200','Viveros EL OASIS','',5,59,47);
INSERT INTO Productos VALUES ('OR-212','Bismarckia Nobilis','Ornamentales','200 - 220','Viveros EL OASIS','',4,217,173);
INSERT INTO Productos VALUES ('OR-213','Bismarckia Nobilis','Ornamentales','240 - 260','Viveros EL OASIS','',4,266,212);
INSERT INTO Productos VALUES ('OR-214','Brahea Armata','Ornamentales','45 - 60','Viveros EL OASIS','',0,10,8);
INSERT INTO Productos VALUES ('OR-215','Brahea Armata','Ornamentales','120 - 140','Viveros EL OASIS','',100,112,89);
INSERT INTO Productos VALUES ('OR-216','Brahea Edulis','Ornamentales','80 - 100','Viveros EL OASIS','',100,19,15);
INSERT INTO Productos VALUES ('OR-217','Brahea Edulis','Ornamentales','140 - 160','Viveros EL OASIS','',100,64,51);
INSERT INTO Productos VALUES ('OR-218','Butia Capitata','Ornamentales','70 - 90','Viveros EL OASIS','',100,25,20);
INSERT INTO Productos VALUES ('OR-219','Butia Capitata','Ornamentales','90 - 110','Viveros EL OASIS','',100,29,23);
INSERT INTO Productos VALUES ('OR-220','Butia Capitata','Ornamentales','90 - 120','Viveros EL OASIS','',100,36,28);
INSERT INTO Productos VALUES ('OR-221','Butia Capitata','Ornamentales','85 - 105','Viveros EL OASIS','',100,59,47);
INSERT INTO Productos VALUES ('OR-222','Butia Capitata','Ornamentales','130 - 150','Viveros EL OASIS','',100,87,69);
INSERT INTO Productos VALUES ('OR-223','Chamaerops Humilis','Ornamentales','40 - 45','Viveros EL OASIS','',100,4,3);
INSERT INTO Productos VALUES ('OR-224','Chamaerops Humilis','Ornamentales','50 - 60','Viveros EL OASIS','',100,7,5);
INSERT INTO Productos VALUES ('OR-225','Chamaerops Humilis','Ornamentales','70 - 90','Viveros EL OASIS','',100,10,8);
INSERT INTO Productos VALUES ('OR-226','Chamaerops Humilis','Ornamentales','115 - 130','Viveros EL OASIS','',100,38,30);
INSERT INTO Productos VALUES ('OR-227','Chamaerops Humilis','Ornamentales','130 - 150','Viveros EL OASIS','',100,64,51);
INSERT INTO Productos VALUES ('OR-228','Chamaerops Humilis \"Cerifera\"','Ornamentales','70 - 80','Viveros EL OASIS','',100,32,25);
INSERT INTO Productos VALUES ('OR-229','Chrysalidocarpus Lutescens -ARECA','Ornamentales','130 - 150','Viveros EL OASIS','',100,22,17);
INSERT INTO Productos VALUES ('OR-230','Cordyline Australis -DRACAENA','Ornamentales','190 - 210','Viveros EL OASIS','',100,38,30);
INSERT INTO Productos VALUES ('OR-231','Cycas Revoluta','Ornamentales','55 - 65','Viveros EL OASIS','',100,15,12);
INSERT INTO Productos VALUES ('OR-232','Cycas Revoluta','Ornamentales','80 - 90','Viveros EL OASIS','',100,34,27);
INSERT INTO Productos VALUES ('OR-233','Dracaena Drago','Ornamentales','60 - 70','Viveros EL OASIS','',1,13,10);
INSERT INTO Productos VALUES ('OR-234','Dracaena Drago','Ornamentales','130 - 150','Viveros EL OASIS','',2,64,51);
INSERT INTO Productos VALUES ('OR-235','Dracaena Drago','Ornamentales','150 - 175','Viveros EL OASIS','',2,92,73);
INSERT INTO Productos VALUES ('OR-236','Jubaea Chilensis','Ornamentales','','Viveros EL OASIS','',100,49,39);
INSERT INTO Productos VALUES ('OR-237','Livistonia Australis','Ornamentales','100 - 125','Viveros EL OASIS','',50,19,15);
INSERT INTO Productos VALUES ('OR-238','Livistonia Decipiens','Ornamentales','90 - 110','Viveros EL OASIS','',50,19,15);
INSERT INTO Productos VALUES ('OR-239','Livistonia Decipiens','Ornamentales','180 - 200','Viveros EL OASIS','',50,49,39);
INSERT INTO Productos VALUES ('OR-240','Phoenix Canariensis','Ornamentales','110 - 130','Viveros EL OASIS','',50,6,4);
INSERT INTO Productos VALUES ('OR-241','Phoenix Canariensis','Ornamentales','180 - 200','Viveros EL OASIS','',50,19,15);
INSERT INTO Productos VALUES ('OR-242','Rhaphis Excelsa','Ornamentales','80 - 100','Viveros EL OASIS','',50,21,16);
INSERT INTO Productos VALUES ('OR-243','Rhaphis Humilis','Ornamentales','150- 170','Viveros EL OASIS','',50,64,51);
INSERT INTO Productos VALUES ('OR-244','Sabal Minor','Ornamentales','60 - 75','Viveros EL OASIS','',50,11,8);
INSERT INTO Productos VALUES ('OR-245','Sabal Minor','Ornamentales','120 - 140','Viveros EL OASIS','',50,34,27);
INSERT INTO Productos VALUES ('OR-246','Trachycarpus Fortunei','Ornamentales','90 - 105','Viveros EL OASIS','',50,18,14);
INSERT INTO Productos VALUES ('OR-247','Trachycarpus Fortunei','Ornamentales','250-300','Viveros EL OASIS','',2,462,369);
INSERT INTO Productos VALUES ('OR-248','Washingtonia Robusta','Ornamentales','60 - 70','Viveros EL OASIS','',15,3,2);
INSERT INTO Productos VALUES ('OR-249','Washingtonia Robusta','Ornamentales','130 - 150','Viveros EL OASIS','',15,5,4);
INSERT INTO Productos VALUES ('OR-250','Yucca Jewel','Ornamentales','80 - 105','Viveros EL OASIS','',15,10,8);
INSERT INTO Productos VALUES ('OR-251','Zamia Furfuracaea','Ornamentales','90 - 110','Viveros EL OASIS','',15,168,134);
INSERT INTO Productos VALUES ('OR-99','Mimosa DEALBATA Gaulois Astier  ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,14,11);


CREATE TABLE DetallePedidos (
  CodigoPedido integer NOT NULL,
  CodigoProducto varchar(15) NOT NULL,
  Cantidad integer NOT NULL,
  PrecioUnidad number(15,2) NOT NULL,
  NumeroLinea smallint NOT NULL,
  PRIMARY KEY (CodigoPedido,CodigoProducto),
  CONSTRAINT DetallePedidos_PedidoFK FOREIGN KEY (CodigoPedido) REFERENCES Pedidos2 (CodigoPedido),
  CONSTRAINT DetallePedidos_ProductoFK FOREIGN KEY (CodigoProducto) REFERENCES Productos (CodigoProducto)
);

INSERT INTO DetallePedidos VALUES (1,'FR-67',10,70,3);
INSERT INTO DetallePedidos VALUES (1,'OR-127',40,4,1);
INSERT INTO DetallePedidos VALUES (1,'OR-141',25,4,2);
INSERT INTO DetallePedidos VALUES (1,'OR-241',15,19,4);
INSERT INTO DetallePedidos VALUES (1,'OR-99',23,14,5);
INSERT INTO DetallePedidos VALUES (2,'FR-4',3,29,6);
INSERT INTO DetallePedidos VALUES (2,'FR-40',7,8,7);
INSERT INTO DetallePedidos VALUES (2,'OR-140',50,4,3);
INSERT INTO DetallePedidos VALUES (2,'OR-141',20,5,2);
INSERT INTO DetallePedidos VALUES (2,'OR-159',12,6,5);
INSERT INTO DetallePedidos VALUES (2,'OR-227',67,64,1);
INSERT INTO DetallePedidos VALUES (2,'OR-247',5,462,4);
INSERT INTO DetallePedidos VALUES (3,'FR-48',120,9,6);
INSERT INTO DetallePedidos VALUES (3,'OR-122',32,5,4);
INSERT INTO DetallePedidos VALUES (3,'OR-123',11,5,5);
INSERT INTO DetallePedidos VALUES (3,'OR-213',30,266,1);
INSERT INTO DetallePedidos VALUES (3,'OR-217',15,65,2);
INSERT INTO DetallePedidos VALUES (3,'OR-218',24,25,3);
INSERT INTO DetallePedidos VALUES (4,'FR-31',12,8,7);
INSERT INTO DetallePedidos VALUES (4,'FR-34',42,8,6);
INSERT INTO DetallePedidos VALUES (4,'FR-40',42,9,8);
INSERT INTO DetallePedidos VALUES (4,'OR-152',3,6,5);
INSERT INTO DetallePedidos VALUES (4,'OR-155',4,6,3);
INSERT INTO DetallePedidos VALUES (4,'OR-156',17,9,4);
INSERT INTO DetallePedidos VALUES (4,'OR-157',38,10,2);
INSERT INTO DetallePedidos VALUES (4,'OR-222',21,59,1);
INSERT INTO DetallePedidos VALUES (8,'FR-106',3,11,1);
INSERT INTO DetallePedidos VALUES (8,'FR-108',1,32,2);
INSERT INTO DetallePedidos VALUES (8,'FR-11',10,100,3);
INSERT INTO DetallePedidos VALUES (9,'AR-001',80,1,3);
INSERT INTO DetallePedidos VALUES (9,'AR-008',450,1,2);
INSERT INTO DetallePedidos VALUES (9,'FR-106',80,8,1);
INSERT INTO DetallePedidos VALUES (9,'FR-69',15,91,2);
INSERT INTO DetallePedidos VALUES (10,'FR-82',5,70,2);
INSERT INTO DetallePedidos VALUES (10,'FR-91',30,75,1);
INSERT INTO DetallePedidos VALUES (10,'OR-234',5,64,3);
INSERT INTO DetallePedidos VALUES (11,'AR-006',180,1,3);
INSERT INTO DetallePedidos VALUES (11,'OR-247',80,8,1);
INSERT INTO DetallePedidos VALUES (12,'AR-009',290,1,1);
INSERT INTO DetallePedidos VALUES (13,'11679',5,14,1);
INSERT INTO DetallePedidos VALUES (13,'21636',12,14,2);
INSERT INTO DetallePedidos VALUES (13,'FR-11',5,100,3);
INSERT INTO DetallePedidos VALUES (14,'FR-100',8,11,2);
INSERT INTO DetallePedidos VALUES (14,'FR-13',13,57,1);
INSERT INTO DetallePedidos VALUES (15,'FR-84',4,13,3);
INSERT INTO DetallePedidos VALUES (15,'OR-101',2,6,2);
INSERT INTO DetallePedidos VALUES (15,'OR-156',6,10,1);
INSERT INTO DetallePedidos VALUES (15,'OR-203',9,10,4);
INSERT INTO DetallePedidos VALUES (16,'30310',12,12,1);
INSERT INTO DetallePedidos VALUES (16,'FR-36',10,9,2);
INSERT INTO DetallePedidos VALUES (17,'11679',5,14,1);
INSERT INTO DetallePedidos VALUES (17,'22225',5,12,3);
INSERT INTO DetallePedidos VALUES (17,'FR-37',5,9,2);
INSERT INTO DetallePedidos VALUES (17,'FR-64',5,22,4);
INSERT INTO DetallePedidos VALUES (17,'OR-136',5,18,5);
INSERT INTO DetallePedidos VALUES (18,'22225',4,12,2);
INSERT INTO DetallePedidos VALUES (18,'FR-22',2,4,1);
INSERT INTO DetallePedidos VALUES (18,'OR-159',10,6,3);
INSERT INTO DetallePedidos VALUES (19,'30310',9,12,5);
INSERT INTO DetallePedidos VALUES (19,'FR-23',6,8,4);
INSERT INTO DetallePedidos VALUES (19,'FR-75',1,32,2);
INSERT INTO DetallePedidos VALUES (19,'FR-84',5,13,1);
INSERT INTO DetallePedidos VALUES (19,'OR-208',20,4,3);
INSERT INTO DetallePedidos VALUES (20,'11679',14,14,1);
INSERT INTO DetallePedidos VALUES (20,'30310',8,12,2);

CREATE TABLE Pagos (
  CodigoCliente integer NOT NULL,
  FormaPago varchar(40) NOT NULL,
  IDTransaccion varchar(50) NOT NULL,
  FechaPago date NOT NULL,
  Cantidad number(15,2) NOT NULL,
  PRIMARY KEY (CodigoCliente,IDTransaccion),
  CONSTRAINT Pagos_clienteFK FOREIGN KEY (CodigoCliente) REFERENCES Clientes (CodigoCliente)
) ;
INSERT INTO Pagos VALUES (1,'PayPal','ak-std-000001','10-11-2008',2000);
INSERT INTO Pagos VALUES (1,'PayPal','ak-std-000002','12-10-2008',2000);
INSERT INTO Pagos VALUES (3,'PayPal','ak-std-000003','16-1-2009',5000);
INSERT INTO Pagos VALUES (3,'PayPal','ak-std-000004','16-2-2009',5000);
INSERT INTO Pagos VALUES (3,'PayPal','ak-std-000005','19-2-2009',926);
INSERT INTO Pagos VALUES (4,'PayPal','ak-std-000006','8-1-2007',20000);
INSERT INTO Pagos VALUES (4,'PayPal','ak-std-000007','8-1-2007',20000);
INSERT INTO Pagos VALUES (4,'PayPal','ak-std-000008','8-1-2007',20000);
INSERT INTO Pagos VALUES (4,'PayPal','ak-std-000009','8-1-2007',20000);
INSERT INTO Pagos VALUES (4,'PayPal','ak-std-000010','8-1-2007',1849);
INSERT INTO Pagos VALUES (5,'Transferencia','ak-std-000011','18-1-2006',23794);
INSERT INTO Pagos VALUES (7,'Cheque','ak-std-000012','13-1-2009',2390);
INSERT INTO Pagos VALUES (9,'PayPal','ak-std-000013','6-1-2009',929);


SELECT * FROM OFICINAS;
SELECT * FROM CLIENTES;
SELECT * FROM PAGOS;
SELECT * FROM PEDIDOS2;
SELECT * FROM PRODUCTOS;
SELECT * FROM EMPLEADOS2;
/*1*/
SELECT CODIGOOFICINA, CIUDAD FROM OFICINAS;
/*2*/
SELECT COUNT(*) FROM EMPLEADOS2;
/*3*/
SELECT PAIS, COUNT(*) FROM CLIENTES GROUP BY PAIS;
/*4*/
SELECT AVG(CANTIDAD) 
FROM PAGOS 
WHERE FECHAPAGO BETWEEN '01/01/09' AND '31/12/09';
/*5*/
SELECT ESTADO, COUNT(*) 
FROM PEDIDOS2 GROUP BY ESTADO;
/*6*/
SELECT MAX(PRECIOVENTA), MIN(PRECIOVENTA) FROM PRODUCTOS;
/*7*/
SELECT NOMBRECLIENTE, LIMITECREDITO 
FROM CLIENTES 
WHERE LIMITECREDITO=(SELECT MAX(LIMITECREDITO) FROM CLIENTES);
/*8*/
/*OJO, QUE NO REPRESENTAN!!!*/SELECT DISTINCT NOMBRE, APELLIDO1, APELLIDO2, PUESTO FROM EMPLEADOS2 E, CLIENTES C 
                              WHERE E.CODIGOEMPLEADO = C.CODIGOEMPLEADOREPVENTAS;
SELECT DISTINCT NOMBRE, APELLIDO1, APELLIDO2, PUESTO 
FROM EMPLEADOS2 E 
WHERE NOT EXISTS(SELECT 'X' FROM CLIENTES C WHERE E.CODIGOEMPLEADO=C.CODIGOEMPLEADOREPVENTAS);
/*9*/
SELECT C.NOMBRECLIENTE, NOMBRE, APELLIDO1, APELLIDO2  
FROM EMPLEADOS2 E, CLIENTES C 
WHERE E.CODIGOEMPLEADO = C.CODIGOEMPLEADOREPVENTAS;
/*10*/
SELECT C.NOMBRECLIENTE, NOMBRE, APELLIDO1, APELLIDO2  FROM EMPLEADOS2 E, CLIENTES C 
WHERE E.CODIGOEMPLEADO = C.CODIGOEMPLEADOREPVENTAS 
AND NOT EXISTS (SELECT CODIGOCLIENTE FROM PAGOS P WHERE C.CODIGOCLIENTE=P.CODIGOCLIENTE);