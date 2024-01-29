drop database aulavirtual;
Create database aulavirtual;
use aulavirtual;
create table USUARIO ( 
usuarioespol varchar(255) primary key, 
nombre varchar(255) not null, 
apellido varchar(255) not null 
); 

create table CURSO ( 
idcurso int primary key, 
paralelo int, 
materia varchar(255) not null, 
periodoacademico varchar(255) not null
); 

create table CARRERA ( 
id_carrera int not null primary key, 
nombrecarrera varchar(255) not null
); 

create table ESTUDIANTE ( 
usuarioespol varchar(255) primary key,
nombre varchar(255) not null, 
apellido varchar(255) not null, 
matricula int not null, 
carrera int  not null, 
foreign key (usuarioespol) references usuario (usuarioespol),
foreign key (carrera) references carrera (id_carrera) 
); 

create table FACULTAD ( 
id_facultad int primary key, 
nombre_facultad varchar(255)
);  


create table PROFESOR ( 
usuarioespol varchar(255) primary key, 
nombre varchar(255) not null, 
apellido varchar(255) not null, 
facultad int,
foreign key (usuarioespol) references usuario (usuarioespol),
foreign key (facultad) references facultad (id_facultad)
); 




create table FORO ( 
idforo int not null, 
titulo varchar(255) not null, 
archivo varchar(255),  
texto varchar(255) not null, 
fecha datetime not null, 
tiempodisponibilidad varchar(255) not null, 
idcurso int not null, 
primary key(idforo,idcurso),
foreign key (idcurso) references curso(idcurso) 
); 

create table MODULO ( 
idcurso int not null, 
idmodulo int not null, 
contenidodelcurso varchar(255) not null, 
primary key (idmodulo,idcurso), 
foreign key (idcurso) references curso(idcurso)
);  

create table PERTENECE( 
idcurso int not null, 
usuarioespol varchar(255) not null, 
primary key (usuarioespol,idcurso), 
foreign key (idcurso) references curso(idcurso), 
foreign key (usuarioespol) references usuario(usuarioespol) 
); 

create table COMENTARIO ( 
idcomentario int not null, 
descripcion varchar(255), 
foro int not null, 
primary key(idcomentario,foro),
foreign key (foro) references foro(idforo) 
);  

create table PERTENECEUF( 
usuarioespol varchar(255) not null, 
idforo int not null, 
primary key (usuarioespol,idforo), 
foreign key (usuarioespol) references usuario(usuarioespol),
foreign key (idforo) references foro (idforo) 
); 

create table MENSAJE ( 
idmensaje int primary key, 
texto varchar(255) not null, 
fechaenvio datetime not null, 
destinatario varchar(255) not null, 
autor varchar(255) not null, 
user varchar(255) not null, 
foreign key (user) references usuario (usuarioespol) 
);  

create table ENVIADO ( 
idenviado int primary key, 
texto varchar(255) not null, 
fechaenvio datetime not null, 
destinatario varchar(255) not null, 
autor varchar(255) not null, 
foreign key (idenviado) references mensaje (idmensaje) 
);  

create table RECIBIDO ( 
idrecibido int primary key, 
texto varchar(255) not null, 
fechaenvio datetime not null, 
destinatario varchar(255) not null, 
autor varchar(255), 
foreign key (idrecibido) references mensaje (idmensaje) 
); 

create table ANUNCIO ( 
idanuncio int primary key, 
fechapublicacion datetime, 
idcurso int, 
profesor varchar(255),
autor varchar(255), 
titulo varchar(255), 
texto varchar(255), 
foreign key (idcurso) references curso (idcurso), 
foreign key (profesor) references profesor(usuarioespol)
); 

create table EVALUACION ( 
idevaluacion int, 
tipo varchar(255), 
titulo varchar(255), 
comentario varchar(255), 
calificacion float, 
profesor varchar(255), 
idcurso int, 
primary key (idevaluacion,idcurso), 
foreign key (profesor) references profesor (usuarioespol), 
foreign key (idcurso) references curso (idcurso)
);  

create table ENTREGA ( 
identrega int not null, 
fechaentrega datetime not null, 
fechapublicacion datetime not null, 
tiempodisponibilidad varchar(255), 
fechasubida datetime not null, 
estapendiente boolean not null, 
ideval int not null, 
primary key(identrega, ideval), 
foreign key (ideval) references evaluacion (idevaluacion)
); 