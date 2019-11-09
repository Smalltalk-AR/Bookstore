# Paso a paso

## Cargar el modelo
Para empezar vamos a cargar el modelo, para ello deberán ejecutar en el Playground el siguiente código

```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:model/source'
	load
```
![Alt Text](load-model.png)

* aca la idea es explorar un poco el ambiente y el lenguaje 
Tambien ver un baseline *

## Cargar Teapot 
```smalltalk
Metacello new
	baseline: 'Teapot'
	repository: 'github://zeroflag/Teapot:2.6.0/source'
	load
```

Aca la idea es agregar hacer algun ejercio listando los libros o las personas.
Se podría hacer dentro de un test.

GET /people

## Cargar el modelo + api
```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:api/source'
	load
```

Mostrar como queda el baseline y las otras rutas.

*estria bien levantar aca la app si es estatica y pegarle al modelo*


## Cargar el modelo + persistencia
```smalltalk
Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:api/source'
	load
```

mostrar que se persiste, no usaria el driver de alvaro.. pongamos postgre 


