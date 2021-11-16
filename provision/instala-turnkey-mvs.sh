#!/usr/bin/env bash

instala_requisitos() {
  sudo apt-get install unzip -y
}


preconfigura_x3270() {
  cat  > ~/.x3270pro  <<EOF
! x3270 profile
! File created Mon Nov 15 22:31:51 2021 by x3270 v3.6ga4 Thu May  3 15:32:33 UTC 2018 buildd
! This file overrides xrdb and .Xdefaults.
! To skip reading this file, set NOX3270PRO in the environment.
!
! toggles (-set, -clear)
x3270.crosshair: true
x3270.cursorBlink: true
x3270.showTiming: true
x3270.colorScheme: reverse
x3270.charset: bracket
!
! emulator font  (-efont)
x3270.emulatorFont: -misc-fixed-medium-r-normal--20-200-75-75-c-100-iso8859-1
EOF

}

instala_emulador_3270() {
  sudo apt-get install x3270 fonts-3270 xfonts-x3270-misc c3270 pr3287 -y

  # x3270 no encuentra los fonts en /usr/share/fonts/X11/misc/3270*
  # ninguna de las siguientes lo arreglo:
  #sudo fc-cache -f -v
  #sudo dpkg-reconfigure fontconfig
}


instala_tk4_minus() {
  [ -f tk4-_v1.00_current.zip ] || wget http://wotho.ethz.ch/tk4-/tk4-_v1.00_current.zip
  [ -f tk4-cbt.zip ]            || wget http://wotho.ethz.ch/tk4-/tk4-cbt.zip # optional
  [ -f tk4-source.zip ]         || wget http://wotho.ethz.ch/tk4-/tk4-source.zip # optional

  mkdir -p ~/mvs/
  cd ~/mvs/

  unzip ../tk4-_v1.00_current.zip
  unzip -o ../tk4-cbt.zip
  unzip -o ../tk4-source.zip

  # ./unattended/set_console_mode hace lo siguiente:
  echo "CONSOLE" > ./unattended/mode

}

##
# main
#

instala_requisitos
instala_emulador_3270
preconfigura_x3270
instala_tk4_minus

# corre hercules y hace IPL de MVS 3.8j
# ./mvs

# corre terminal
# /usr/bin/x3270 -model 3279-2  -port 3270  127.0.0.1
# /usr/bin/c3270 -model 3279-2  -port 3270  127.0.0.1

