# Pinterested (Clon de Pinterest)

Cuando comencé este proyecto siguiendo los pasos del libro me encontré con varios problemas, sobre todo de compatibilidad de las versiones de **RoR** que utilizo. El principal fue en el ***Capítulo VI***, donde la gema ***paperclip*** estaba obsoleta y al intentar utilizar otra rompí algo en el proyecto.

Cuando decidí rehacer el proyecto me di cuenta de que no había guardado los pasos adicionales que tuve que hacer, por lo que ahora lo dejaré documentado acá.

El proyecto descrito acá sólo considera el desarrollo local, por lo que obviaré configuraciones en **AWS** y/o **Heroku**.

## Capítulo I (Entorno de desarrollo)

En mi caso voy a utilizar lo que utilizo siempre como base:
- Ubuntu hirsute 21.04
- Ruby 3.0.0p0
- Rails 6.1.4.1
- sqlite

Creación de proyecto:

```rails new pinterested```

Verificación de server:

```rails s -b 0.0.0.0```

Para gestionar imágenes utilizaremos (descomentar):
~~~
# Use Active Storage variant
gem 'image_processing', '~> 1.2'
~~~

Para visualizar mejor la base de datos (agregar en group :development do):
~~~
#group :development do
  gem 'hirb'
~~~

Instalar gemas en el proyecto:
```bundle install```

Agregar página de inicio al proyecto:

```rails generate controller home index```

Para poder visualizar hay que eliminar la linea 10 de *app/views/layouts/application.html.erb*.

```<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>```

***Nota: eliminar esta linea puede traer problemas con bootstrap***

Cambiar la ruta para que sea lo primero que aparezca al iniciar al aplicación:

```/config/routes.rb```
~~~
Rails.application.routes.draw do
root 'home#index'
.
.
end
~~~

Para subir a github estoy utilizando github desktop, ver el sgte enlace:
https://docs.github.com/es/desktop

## Capítulo II (Construyendo nuestra aplicación)

Creación de un archivo llamado ```about.html.erb``` en ```app/views/home/```.

Dentro de él, escribir información sobre el desarrollador.

En ```app/controllers/home_controller.rb``` escribir el método asociado a la nueva vista:

~~~
class HomeController < ApplicationController
  def index
  end

  def about
  end
end
~~~

Agregar la ruta a *about* en ```/config/routes.rb``` para que el controlador permita acceder a la vista.

~~~
Rails.application.routes.draw do
  root 'home#index'
  get 'home/about'
  .
  .
end
~~~
 
 ***Nota: para ver las rutas ordenadas ejecutar en la terminal usar ```rails routes --expanded```***

Ahora vamos a crear enlaces para movernos entre vistas.
Lo primero es crear el archivo *_header.html.erb* en ```app/views/home/``` y agregar los enlaces:

~~~
<%= button_to 'Home', root_path, method: :get %>
<%= button_to 'About Us', home_about_path, method: :get %>
~~~

***Nota: En mi caso utilicé botones para los links***

En el archivo *application.html.erb*, dentro de ```app/views/layouts/``` agregar:

~~~
<body>
    <%= render 'home/header' %>
    .
</body>
~~~

## Capítulo III (Agregando Bootstrap)


