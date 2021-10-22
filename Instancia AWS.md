# Configuración y Conexión de Servidor en AWS

En el panel EC2 vamos a dar clic en el botón azul grande que dice "Lanzar Instancia"

Seleccionar Ubuntu Server 20.04 LTS

El tipo de instancia es la t2.micro (la única apta para la cuenta gratuita)

Luego ir a configurar el grupo se seguridad, crear *SSH*, *HTTP* y *HTTPS* con sus valores por default.

Generar la <key_name>.pem y guardarla.

Lanzar la instancia.

Cambiar los permisos de <key_name>.pem en la terminal ```chmod 400 <key_name>.pem```

Luego conectarse a *AWS* ```ssh -i <key_name>.pem ubuntu@<public.ip.address>```

Instalar desde terminal de acuerdo a los siguientes archivos:

- ***Instalacion_01_Passenger.sh***
- ***Instalacion_02_Passenger.sh***
- ***Instalacion_03_Passenger.sh***
- ***Instalacion_04_Passenger.sh*** hasta linea 20
- Seguir los siguientes pasos:
    * ```cd /var/www/pinterested/ && yarn add bootstrap jquery popper.js```
    * ```sudo apt-get install imagemagick```
    * ```cd /var/www/pinterested/ && rails active_storage:install```
- ***Instalacion_04_Passenger.sh*** desde linea 22
- ***Instalacion_05_Passenger.sh***

***Nota 1: Hay algunos problemas de instalación de bootstrap***
***Nota 2: Por temas del tipo de instancia algunas imágenes no se cargan, evitar cargar imágenes muy pesadas***


# Configurar VSCode con AWS

Para configurar un canal ssh entre *VSCode* y *AWS* seguir los pasos del siguiente video:

[![Usar instancia EC2 de AWS con Visual studio code en Windows 10 - Remote SSH.](https://img.youtube.com/vi/cMGCvdayJYM/0.jpg)](https://www.youtube.com/watch?v=cMGCvdayJYM)


Utilizo *Windows 10* y me funcionó. Al principio no conectaba, por lo que tuve que copiar el keyname.pem (necesario para la conexión ssh) a la carpeta C:/users/<User> (considera la carpeta de acuerdoa tu configuración).













