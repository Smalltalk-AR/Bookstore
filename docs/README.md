# Guía paso a paso para crear una aplicación web con Smalltalk

La guía consiste en ir haciendo pequeñas exploraciones a medida que vamos viendo los distintos temas. 

## Cargar el modelo

Lo primero que vamos a hacer es  Para empezar vamos a cargar el modelo, para ello deberán ejecutar en el Playground el siguiente código

```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:model/source';
	load
```
![Alt Text](load-model.png)

* aca la idea es explorar un poco el ambiente y el lenguaje. Tambien ver un baseline *

## Crear una API RESTful

Vamos a explorar 

### Cargar Teapot 

```smalltalk
Metacello new
	baseline: 'Teapot';
	repository: 'github://zeroflag/Teapot:2.6.0/source';
	load
```

Aca la idea es agregar hacer algun ejercio listando los libros o las personas.
Se podría hacer dentro de un test.

GET /authors

### Cargar el modelo + api

```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:api/source';
	load
```

Mostrar como queda el baseline y las otras rutas.

*estria bien levantar aca la app si es estatica y pegarle al modelo*

### Persistencia

Es hora de agregar persistencia al ejercicio. Antes vamos a explorar algunos conceptos en un Playground.

```smalltalk
Metacello new
	baseline: 'Sagan';
	repository: 'github://ba-st/Sagan:release-candidate/source';
	load
```

```bash
$ docker pull postgres:11
$ docker run -d --name db-tests -p 5432:5432 -e POSTGRES_PASSWORD=secret postgres:11
```

Esto nos va permitir levantar la base

```bash 
$ docker exec -it db-tests bash

$ psql -U postgres
$ CREATE DATABASE bookstore;
```

Vamos a probar que todo está en orden, para ello vamos a intentar establecer una conexión

```smalltak



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

repository := RDBMSRepository
		storingObjectsOfType: BookAuthor
		checkingConflictsAccordingTo: DoNotCheckForConflictsStrategy new
		workingWith: [:action | action value: session ].

repository configureMappingsIn: [ :rdbmsRepository |
			rdbmsRepository
				beAwareOfTableDefinedBy:
					( RealTableDefinition
						named: 'AUTHORS'
						fieldsDefinedBy:
							{SequentialNumberFieldDefinition new.
							( CharacterFieldDefinition named: 'first_name' sized: 100 ).
							( CharacterFieldDefinition named: 'last_name' sized: 100 )} );
				beAwareOfClassModelDefinedBy:
					( ClassModelDefinition
						for: BookAuthor 
						attributesDefinedBy:
							{"( BasicAttributeDefinition named: RDBMSConstants sequentialNumberAttribute )."
							( BasicAttributeDefinition named: #firstName ).
							( BasicAttributeDefinition named: #lastName )} );
				beAwareOfDescriptorDefinedBy:
					( ConcreteDescriptorDefinition
						for: BookAuthor
						onTableNamed: 'AUTHORS'
						mappingsDefinedBy:
							{"( SequentialNumberMappingDefinition onTableNamed: 'AUTHORS' )."
							( DirectMappingDefinition
								fromAttributeNamed: #firstName
								toFieldNamed: 'first_name'
								onTableNamed: 'AUTHORS' ).
							( DirectMappingDefinition
								fromAttributeNamed: #lastName
								toFieldNamed: 'last_name'
								onTableNamed: 'AUTHORS' )} )
			].
		
session
		loginIfError: [ :error | self fail: error messageText ];
		recreateTablesIfError: [ :error | self fail: error messageText ];
		logout.

session loginIfError: [ :error | self fail: error messageText ].

session inspect.
repository inspect

```


### Cargar el modelo + persistencia
```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:persistence/source';
	load
```

mostrar que se persiste, no usaria el driver de alvaro.. pongamos postgre 


