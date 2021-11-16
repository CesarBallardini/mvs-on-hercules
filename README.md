# README - MVS 3.8j Tur(n)key 4- System on Hercules

MVS 3.8j (24-bit, liberado en 1981) es un sistema operativo IBM que en la actualidad se puede usar libremente. 

Hercules es un emulador de la arquitectura IBM mainframe.

En las versiones de z/OS actuales se puede ver todavía los trazos de diseño de MVS  de la arquitectura OS/370.

Aprender a usar esta clase de sistemas es un hobby para aquellos que jamás los utilizamos, y es una añoranza para los que trabajaron 
en su juventud con ellos.

Voy a presentar el uso cotidiano desde el punto de vista de un desarrollador de mediados de los '80.
En cada documento tendremos una consigna y veremos lo necesario para poder cumplirla.

Primero lo primero: 

1. levantar el emulador Hercules
2. realizar el arranque de MVS
3. Login en MVS
4. Logoff de MVS
5. Apagar MVS
6. Apagar Hercules


## 1. Levantar la VM Ubuntu con emulador Hercules y Turnkey MVS instalados

```bash
time vagrant up
```

## 2. Levantar MVS

Ingresar a la VM y hacer:

```bash
vagrant ssh

# una vez en la VM:
cd ~/mvs/
./mvs
```

La terminal asociada a el último mandato quedará capturada mostrando la consola de Hercules.
Se puede pasar del la vista de consola de MVS a consola Hercules apretando la tecla Escape.

Para conectarnos ahora con el MVS, vamos a utilizar otra sesión en la VM, y vamos a correr el mandato:

```bash
c3270 -port 3270 127.0.0.1 
# o bien:
c3270 -port 3270 192.168.56.11 
```

## 3. Logon en MVS

En el sistema Tur(n)key hay ciertas cuentas de usuario predefinidas:

| Nombre de cuenta | Contraseña | Capacidades |
|------------------|------------|-------------|
| `HERC01`         | `CUL8TR`   | Todos los permisos. Acceso total a tablas de usuarios y perfiles. |
| `HERC02`         | `CUL8TR`   | Todos los permisos. Acceso total a tablas de usuarios y perfiles. |
| `HERC03`         | `PASS4U`   | Usuario normal. |
| `HERC04`         | `PASS4U`   | Usuario normal. |
| `IBMUSER`        | `IBMPASS`  | Todos los permisos. Acceso total a tablas de usuarios y perfiles. Se debe usar sólo para tareas de recuperación. |


El **LOGON** en TSO se hace escribiendo el nombre de usuario y apretando ENTER.  Si pide la contraseña, debe ingresarla y luego apretar ENTER.

El sistema da la bienvenida con `Welcome to TSO`, aprete ENTER.

El sistema muestra un *fortune cookie*, aprete ENTER.

El sistema muestra ahora el menú de las `TSO Applications`. Desde allí puede seleccionar la aplicación que desea ejecutar ingresando el número del ítem
en el campo `Option==>`.  Desde el menú de las aplicaciones TSO, para salir nuevamente a la consola TSO, debe apretar la tecla `PF3` --- `F3` en la mayoría de los teclados físicos, o bien puede usar el teclado virtual del emulador de terminal. El *prompt* de TSO es `READY`: puede escribir mandatos TSO allí.


## 4. Logoff de MVS

Una vez en el sistema TSO (aprete `F3` hasta salir de todos los menúes), escriba `logoff` y aprete ENTER.

La terminal no se desconectará, sino que va a mostrar nuevamente la pantalla de `LOGON`

Si no va a reingresar, puede desconectar y apagar (el emulador de) la terminal.

## 5. Apagar MVS

1. Ingresar con la cuenta `HERC01` ó `HERC02`.
2. Apretar `PF3` desde el menú de aplicaciones TSO para ir al *prompt* `READY` de TSO.
3. Escriba `shutdown` y aprete ENTER.
4. Escriba `logoff` y aprete ENTER.

Luego de una pausa de 30 segundos, el procedimiento automático de `shutdown` baja el sistema MVS y luego apaga el emulador Hercules, lo cual es equivalente a quitar la energía al mainframe IBM 3033.

Cualquier usuario con acceso de lectura al perfil `DIAG8CMD` en la clase `RAKF FACILITY` puede iniciar la secuancia de *shutdown*.

## 6. Apagar Hercules

Si desea apagar Hercules, sin cuidado del sistema operativo, en la consola de Hercules, escribir:

```
quit
```

El sistema operativo no pudo cerrarse ordenadamente, y es muy posible que se haya dañado la instalación del mismo.


Luego del apagado, nos devuelve al _prompt_ de la VM.

# Referencias

* https://en.wikipedia.org/wiki/MVS historia del sistema operativo y relación con predecesores y sucesores.
* http://wotho.ethz.ch/tk4-/ The MVS 3.8j Tur(n)key 4- System / OS/VS2 MVS 3.8j Service Level 8505 / Tur(n)key Level 4- Version 1.00: el sistema que estaremos usndo
* http://wotho.ethz.ch/tk4-/MVS_TK4-_v1.00_Users_Manual.pdf : referencias al `logon`, `logoff`

* https://media.ccc.de/v/vcfb18_-_96_-_en_-_201810141000_-_running_your_own_mainframe_on_linux_for_fun_and_profit_-_jeroen_baten Running your own mainframe on Linux (for fun and profit) <br/>
  Yes, this talk is about running your own mainframe on your own hardware. Mainframes are old, yes, but they are still very much alive. New hardware is still being developed and there are a lot of fresh jobs in this area too. A lot of mainframes run COBOL workloads. COBOL is far from a dead language. It processes an estimated 85% of all business transactions, and 5 billion lines of new COBOL code are written every year. In this session the speaker will help you take your first steps towards running your own mainframe. If you like then after this session you can continue to build your knowledge of mainframe systems using the links provided during the talk. Come on in and learn the basics of a completely different computer system! And it will take you less than an hour to do that!


* My Own Mainframe: serie de artículos
  * https://kevindurant.be/2019/03/17/mom-part-1-setting-up-my-own-mainframe/ MOM Pt. 001: Setting up my own Mainframe!
  * https://kevindurant.be/2019/03/21/mom-pt-002-custom-netsol-sign-on-screen/ MOM Pt. 002: Custom NETSOL Sign-On Screen
  * https://kevindurant.be/2019/05/03/mom-pt-003-getting-to-know-cobol-compiling/ MOM Pt. 003: Getting to know COBOL – Compiling
  * https://kevindurant.be/2019/07/12/mom-pt-004-writing-simple-cobol-on-mvs3-8-tk4/ MOM Pt. 004: Writing simple COBOL on MVS3.8 tk4-

# Bibliografía

* https://web.archive.org/web/20160512175419/http://tk3.comlu.com/mvs380/Vintage_Manuals.html
