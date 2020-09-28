**Photo Album**\

![](https://raw.githubusercontent.com/Gabriel2793/Photo_Album/master/images/react.png)

![](https://raw.githubusercontent.com/Gabriel2793/Photo_Album/master/images/nodejs.png)

![](https://raw.githubusercontent.com/Gabriel2793/Photo_Album/master/images/mysql.png)

Este sistema fue creado para fines demostrativos de mis habilidades con ReactJS y NodeJS, sin fines de lucro, el presente sistema es un album de fotos para que los usuarios almacenen imagenes y las visualicen.

Este sistema está hecho con el siguiente software:

1. ReactJS
2. NodeJS
3. MySQL
4. Bootstrap 4

El sistema almacena la información del usuario en la base de datos, incluidas las imágenes. 

El usuario solamente tiene que ingresar al sistema y seleccionar en la barra superior el link que indica "Sign Up", este link mostrará un formulario en el cual tiene que ingresar su correo, contraseña e imagen de perfil para crear una cuenta.

![](https://raw.githubusercontent.com/Gabriel2793/Photo_Album/master/images/reactapp.png)

Después el usuario debe ingresar al sistema al dar click en el link "Sign in ", éste mostrara un formulario, en el cual se debera ingresar correo y contraseña.

![](https://raw.githubusercontent.com/Gabriel2793/Photo_Album/master/images/react2.png)

Por último, al usuario se le mostrará su imagen de perfil y un botón para agregar las imagenes que desee en su album de fotos.

![](https://raw.githubusercontent.com/Gabriel2793/Photo_Album/master/images/ReactApp3.png)

Para utilizar el sistema, se debe seguir los siguientes pasos:

1. Instalar NodeJS, el siguiente link te llevara a la página de descarga:

   https://nodejs.org/es/

2. Posterior a la instalación de NodeJS, se debe clonar el repositorio con el siguiente comando:

   git clone https://github.com/Gabriel2793/Photo_Album.git

3. Ingresa al directorio Photo_Album y ejecuta el siguiente comando para instalar todas las dependencias:

   $npm install

4. Después se inicia el servidor de NodeJS con el archivo server.js que se encuentra en la carpeta Photo_Album/**photo_album_nodejs**/ con el siguiente comando:

   $node ./server.js

5. Luego se debe ingresar a la carpeta Photo_Album/photo_album y ejecutar el siguiente comando para poder iniciar el servidor de React, se solicitara el inicio del servidor en otro puerto, indicar que si:

   $npm install && npm start

6. Luego se debe cargar la base de datos de respaldo, que se encuentra en la carpeta Photo_Album/photo_album  con el siguiente comando:

   $mysql -u [user] -p [database_name] < photoAlbum.sql.sql

   la base de datos se debe llamar "photoalbum"

   