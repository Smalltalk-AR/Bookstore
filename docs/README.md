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


# Creando una API RESTful

Vamos a explorar en un playground (o un test) un poco el micro framework [Teapot](https://github.com/zeroflag/Teapot) con el que vamos a hacer la API.

Para agregar Teapot a la imagen, ejecutar en cualquier lado 

```smalltalk
Metacello new
	baseline: 'Teapot';
	repository: 'github://zeroflag/Teapot:v2.6.0/source';
	load
```

Ahora vamos a hacer rápido un servicio que nos devuelva todos los autores. Un `GET /authors`.

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
						body: (authors collect: [:author | { #name -> author firstName } asDictionary ]);
						headers: {('Access-Control-Allow-Origin' -> '*')} ];
		start.
	authors
		add: author1;
		add: author2.
	authors
```

¿Se te ocurren más pruebas? ¿Cómo crearías un nuevo recurso?

# ¿Y la aplicación web?

Carguemos el back end...
```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore:api/source';
	load
```

Y ahora vamos a servir el frontend desde la imagen, primero lo vamos a clonar desde github. Ejecuta el siguiente código en una consola

```bash
$ git clone git@github.com:Smalltalk-AR/Bookstore-Frontend.git
```
Esto debería haber creado un sub-directorio `Bookstore-Frontend` en el directorio en el que estabas, entra y copia la ruta así

```shell
$ cd Bookstore-Frontend
$ pwd | pbcopy
```

Listo, ahora en la imagen, en un Playground, copia el siguiente texto reemplazando `'/Users/...'` por el directorio en el cual está el sitio.

```smalltalk
| server directory delegate |

directory := FileSystem disk / 'Users/...'.
delegate := ZnStaticFileServerDelegate new directory: directory.

server := ZnServer on: 8888.
server delegate: delegate.
server start.
```

Ok, ahora abrí un navegador y andá a la url `http://localhost:8888/` para ver el sitio.

# Agregándole persistencia

Para el ejercicio vamos a detallar como utilizar una base de *Postgres SQL* pero hay soporte para varios otros motores de bases de datos relacionales. También los hay bases NoSQL, como MongoDB o Redis.

## Instalando la base de datos

Para facilitar su instalación vamos a usar [Docker](https://docs.docker.com/get-started/) para la base de datos.

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

Ahora si, ya teemos la base configurada, agreguemos a la imagen [Sagan](https://github.com/ba-st/Sagan)

```smalltalk
Metacello new
	baseline: 'Sagan';
	repository: 'github://ba-st/Sagan:release-candidate/source';
	load
```

Una vez finalizado la carga en la imagen estaremos listos para hacer una pequeña prueba de conectividad. Copia y peqa el siguiente código e inspeccionalo para obtener una sesión a la base de datos.

```smalltalk
| login accessor session repository |

DatabaseAccessor classForThisPlatform DefaultDriver: P3DatabaseDriver.
	
login := Login new
		database: PostgreSQLPlatform new;
		username: 'postgres';
		password: 'secret';
		host: 'localhost';
		port: 5432;
		databaseName: 'bookstore';
		yourself.

accessor := DatabaseAccessor forLogin: login.

session := GlorpSession new
		accessor: accessor;
		system: ConfigurableDescriptorSystem new;
		yourself.
```

Algo así
![Alt Text](login.png)

`session login` nos dará un objeto que nos permite trabajar con la base a la que nos conectamos. 

# Hora de sacar la persistencia terminada del repositorio 

```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore:master/source';
	load
```
 Esto cargará el proyecto terminado, ¿se animan a hacer los cambios que faltan para persitir los libros?

