# Pinterested (Clon de Pinterest)

Cuando comencé este proyecto siguiendo los pasos del libro me encontré con varios problemas, sobre todo de compatibilidad de las versiones de **RoR** que utilizo. El principal fue en el ***Capítulo VI***, donde la gema ***paperclip*** estaba obsoleta y al intentar utilizar otra rompí algo en el proyecto.

Cuando decidí rehacer el proyecto me di cuenta de que no había guardado los pasos adicionales que tuve que hacer, por lo que ahora lo dejaré documentado acá.

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

Agregar página de incio al proyecto:

```rails generate controller home index```

Para poder visualizar hay que eliminar la linea 10 de *app/views/layouts/application.html.erb*.
```<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>```

***Nota: eliminar esta linea puede traer problemas con bootstrap***

Cambiar la ruta:
```/config/routes.rb```
~~~
Rails.application.routes.draw do
root 'home#index'
.
.
end
~~~


## Capítulo II ()

