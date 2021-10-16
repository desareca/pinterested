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

Para instalar Bootstrap 5 en Rails 6 seguir los pasos del siguiente enlace:
https://dev.to/songta17/rails-6-with-bootstrap-5-5c08

En el archivo ```app/stylesheets/config/_bootstrap_variables.scss``` comenté todas las variables, ya qué me generaba un error. Esto lo veré luego, de momento quedará comentado.

Siguiendo con el libro, agregar en *index.html.erb*:

~~~
<div class="jumbotron">
    .
    .
    <%= link_to 'About Us', home_about_path, class: 'btn btn-default' %>
    <%= link_to 'Home', root_path, class: 'btn btn-primary' %>
</div>
~~~

El archivo *_header.html.erb* queda como sigue:

~~~
<nav class="navbar navbar-expand-lg navbar-light bg-success p-2 text-dark bg-opacity-25">
  <div class="container-fluid ">
    <a class="navbar-brand" href="#">Pinterested</a>
    <div class="navbar-right d-inline">
        <%= link_to 'Home', root_path, method: :get, class:"btn btn-dark my-auto"%>
        <%= link_to 'About Us', home_about_path, method: :get, class:"btn btn-dark my-auto"%>
    </div>
  </div>
</nav>
~~~

***Nota: Falta Jugar con estilos, lo dejaré para el final***

## Capítulo IV (Agregando Usuarios con Devise)

Agregar gemas para gestión de password y usuarios en *Gemfile*:

~~~
gem 'bcrypt'
gem 'devise'
~~~

Instalar:

```bundle install```

Corremos el generador de *devise*:

```rails generate devise:install```

Verificamos en */config/environments/development.rb* si se encuentra los sgte (si no lo agregamos):

```config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }```

Agregamos en */app/views/layouts/application.html.erb* lo sgte:

~~~
<div class="container">
  <% flash.each do |name, msg| %>
    <%= content_tag(:div, msg, class: "alert alert-info") %>
  <% end %>
  <%= yield %>
</div>
~~~

Generamos las vistas con devise:

```rails g devise:views```

Ahora creamos el modelo *User* y migramos la base de datos:

~~~
rails generate devise user
rake db:migrate
~~~

Crear Un usuario genérico para hacer pruebas y agregar estilos.

Dentro de las modificaciones de estilo considerar:
- Agregar a los campos de entrada ***class: 'form-control'***
  ```<%= f.email_field :email, autofocus: true, class: 'form-control' %>```
- Agregar a los botones ***class: 'btn bg-success bg-opacity-50 my-2'***
  ```<%= f.submit "Sign up", class: 'btn btn-primary' %>```
- Agregar header y footer de cada formulario
  ~~~
  <div class="panel panel-default">
  <div class="panel-heading"><h2>Sign up</h2></div>
  <div class="panel-body">
  .
  .
  </div>
    <div class="panel-footer"><%= render "devise/shared/links" %></div>
  </div>
  ~~~

Esto para las siguientes vistas:
- /app/views/devise/registrations/new.html.erb
- /app/views/devise/registrations/edit.html.erb
- /app/views/devise/sessions/new.html.erb
- /app/views/devise/passwords/new.html.erb

En */app/views/home/_header.html.erb* agregar los enlaces a las vistas de los nuevos formularios de devise:
~~~
<div class="nav navbar-nav navbar-right">
    <%= button_to 'Home', root_path, method: :get, class:"btn btn-dark my-auto mx-1"%>
    <%= button_to 'About Us', home_about_path, method: :get, class:"btn btn-dark my-auto mx-1"%>

    <% if user_signed_in? %>
      <%= button_to 'Edit Profile', edit_user_registration_path, method: :get, class:"btn btn-dark my-auto mx-1" %>
      <%= button_to 'Logout', destroy_user_session_path, method: :delete, class:"btn btn-dark my-auto mx-1" %>
    <% else %>
      <%= button_to "Login", new_user_session_path, method: :get, class:"btn btn-dark my-auto mx-1" %>
      <%= button_to "Join", new_user_registration_path, method: :get, class:"btn btn-dark my-auto mx-1" %>
    <% end %>
</div>
~~~

Realicé algunas modificaciones de estilo más y luego realizaré más, pero las anteriores son las que están asociadas al libro.


## Capítulo V (Construyendo un Scaffold)

Generar modelo, controlador y vistas para cada entrada:

```rails g scaffold pins description:string````
```rails db:migrate````

Modificar estilos de formularios de acuerdo a los capítulos anteriores.

Agregar en el navbar los enlaces a las vistas de pins de acuerdo a lo sgte:

~~~
<div class="nav navbar-nav navbar-right">
    <%= button_to 'Home', root_path, method: :get, class:"btn btn-dark my-auto mx-1"%>
    <%= button_to 'About Us', home_about_path, method: :get, class:"btn btn-dark my-auto mx-1"%>
    <%= button_to 'List Pins', pins_path, method: :get, class:"btn btn-dark my-auto mx-1" %>

    <% if user_signed_in? %>
      <%= button_to 'Edit Profile', edit_user_registration_path, method: :get, class:"btn btn-dark my-auto mx-1" %>
      <%= button_to 'Logout', destroy_user_session_path, method: :delete, class:"btn btn-dark my-auto mx-1" %>
      <%= button_to 'Add Pin', new_pin_path, method: :get, class:"btn btn-dark my-auto mx-1"  %>
    <% else %>
      <%= button_to "Login", new_user_session_path, method: :get, class:"btn btn-dark my-auto mx-1" %>
      <%= button_to "Join", new_user_registration_path, method: :get, class:"btn btn-dark my-auto mx-1" %>
    <% end %>
</div>
~~~

## Capítulo VI (Autenticando Usuarios)


