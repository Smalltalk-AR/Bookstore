¡Bienvenido! Esta guía te servirá para aprender cada tema realizado pequeñas exploraciones.

# El problema

La biblioteca finalmente va a difitalizar su catálogo. Se requiere un sistema para administrar el catálogo que permita agregar, editar y borrar libros.
De los libros se conoce su identificador único, título, autor, año de edición y editorial.
Del autor su nombre, apellido y país de nacimiento.


# Sacando del horno modelo listo

Para empezar vamos a cargar el modelo, para ello deberán ejecutar en el Playground el siguiente código

```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore:model/source';
	load
```

![Alt Text](load-model.png)

*Nota:* aca la idea es explorar un poco el ambiente y la solución. Tambien ver un baseline.*

# Creando una API RESTful

Vamos a explorar en un playground (o un test) un poco el micro framework [Teapot](https://github.com/zeroflag/Teapot) con el que vamos a hacer la API.

Para agregar Teapot a la imagen, ejecutar en cualquier lado 

```smalltalk
Metacello new
	baseline: 'Teapot';
	repository: 'github://zeroflag/Teapot:v2.6.0/source';
	load
```

Ahora vamos a hacer rápido un servicio que nos devuelva todos los autores. 
GET /authors

Ejecutando el siguiente script, podemos ver como se crea un server con una sola ruta /authors que nos devuelve una lista con los autores previamente definidos.

```smalltalk
| authors server author1 author2 |
	authors := OrderedCollection new.
	author1 := BookAuthor
		named: 'Seymour'
		lastName: 'Skinner'
		bornIn: 'Springfield'.
	author2 := BookAuthor
		named: 'Armando'
		lastName: 'Barreda'
		bornIn: 'Springfield'.
	server := (Teapot configure: {(#defaultOutput -> #json)})
		GET:
			'/authors'
				-> [ :request | 
					TeaResponse ok
						body: authors;
						headers: {('Access-Control-Allow-Origin' -> '*')} ];
		start.
	authors
		add: author1;
		add: author2.
	authors
```

# Agregándole persistencia

Es hora de agregar persistencia al ejercicio. 


## Instalando postgres

```bash
$ docker pull postgres:11
$ docker run -d --name db-tests -p 5432:5432 -e POSTGRES_PASSWORD=secret postgres:11
```

Vamos a crear la base

```bash 
$ docker exec -it db-tests bash

$ psql -U postgres
# CREATE DATABASE bookstore;
# \c bookstore
```

Vamos a probar que todo está en orden, para ello vamos a intentar establecer una conexión desde la imagen
```smalltalk
| login accessor session repository |

DatabaseAccessor classForThisPlatform DefaultDriver: P3DatabaseDriver.
	
login := Login new
		database: PostgreSQLPlatform new;
		username: 'postgres';
		password: 'secret';
		host: 'localhost';
		port: 5432;
		databaseName: 'test';
		yourself.

accessor := DatabaseAccessor forLogin: login.

session := GlorpSession new
		accessor: accessor;
		system: ConfigurableDescriptorSystem new;
		yourself.
```

Ahora Antes vamos a explorar algunos conceptos en un Playground. Para eso vamos a cargar primero 

```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:api/source';
	load
```
Ahora si, agreguemos a la imagen [Sagan](http)

```smalltalk
Metacello new
	baseline: 'Sagan';
	repository: 'github://ba-st/Sagan:release-candidate/source';
	load
```

Ya tenemos la base de datos y tenemos Sagan en la imagen, hagamos una pequeña prueba de conectividad. Copia y peqa el siguiente código e inspeccionalo para obtener una sesión a la base de datos.



### Cargar el modelo + persistencia
```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:persistence/source';
	load
```

mostrar que se persiste, no usaria el driver de alvaro.. pongamos postgre 


