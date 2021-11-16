# README - MVS 3.8j Tur(n)key 4- System on Hercules

MVS es un sistema operativo IBM que en la actualidad se puede usar sin licencias privativas restrictivas.

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

## 3. Login en MVS

FIXME

## 4. Logoff de MVS

FIXME

## 5. Apagar MVS

FIXME

## 6. Apagar Hercules

En la consola de Hercules, escribir:

```
quit
```

Esto nos devuelve al _prompt_ de la VM.

# Referencias

* https://media.ccc.de/v/vcfb18_-_96_-_en_-_201810141000_-_running_your_own_mainframe_on_linux_for_fun_and_profit_-_jeroen_baten Running your own mainframe on Linux (for fun and profit) <br/>
  Yes, this talk is about running your own mainframe on your own hardware. Mainframes are old, yes, but they are still very much alive. New hardware is still being developed and there are a lot of fresh jobs in this area too. A lot of mainframes run COBOL workloads. COBOL is far from a dead language. It processes an estimated 85% of all business transactions, and 5 billion lines of new COBOL code are written every year. In this session the speaker will help you take your first steps towards running your own mainframe. If you like then after this session you can continue to build your knowledge of mainframe systems using the links provided during the talk. Come on in and learn the basics of a completely different computer system! And it will take you less than an hour to do that!


* http://wotho.ethz.ch/tk4-/ The MVS 3.8j Tur(n)key 4- System / OS/VS2 MVS 3.8j Service Level 8505 / Tur(n)key Level 4- Version 1.00





* https://kevindurant.be/2019/03/17/mom-part-1-setting-up-my-own-mainframe/ MOM Pt. 001: Setting up my own Mainframe!
* https://kevindurant.be/2019/03/21/mom-pt-002-custom-netsol-sign-on-screen/ MOM Pt. 002: Custom NETSOL Sign-On Screen
* https://kevindurant.be/2019/05/03/mom-pt-003-getting-to-know-cobol-compiling/ MOM Pt. 003: Getting to know COBOL – Compiling
* https://kevindurant.be/2019/07/12/mom-pt-004-writing-simple-cobol-on-mvs3-8-tk4/ MOM Pt. 004: Writing simple COBOL on MVS3.8 tk4-

