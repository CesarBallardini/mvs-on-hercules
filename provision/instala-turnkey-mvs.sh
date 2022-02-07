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
  [ -d /vagrant/tmp/ ] || mkdir /vagrant/tmp/

  pushd /vagrant/tmp/
  [ -f tk4-_v1.00_current.zip ] || wget https://wotho.ethz.ch/tk4-/tk4-_v1.00_current.zip
  [ -f tk4-cbt.zip ]            || wget https://wotho.ethz.ch/tk4-/tk4-cbt.zip # optional
  [ -f tk4-source.zip ]         || wget https://wotho.ethz.ch/tk4-/tk4-source.zip # optional
  popd

  mkdir -p ~/mvs/
  pushd ~/mvs/

  unzip /vagrant/tmp/tk4-_v1.00_current.zip
  unzip -o /vagrant/tmp/tk4-cbt.zip
  unzip -o /vagrant/tmp/tk4-source.zip

  # ./unattended/set_console_mode hace lo siguiente:
  echo "CONSOLE" > ./unattended/mode
  popd

}



# https://groups.io/g/turnkey-mvs/message/1677
# Rob Prins:
#  I have updated my TK4- system.
#  I have installed ISPF 2.2, RPF 191, REVIEW 50.1, New ISPF panels for RPF 3.4,
#  RPF edit, browse, PDS and Reset stats.
#  Option 4 of ISPF contains the RPF foreground assembler.
#  Option M of ISPF contains the "old" TSOAPPLS menu.
#  I have installed a lot of usermods, like TMVS16, TMVS17, ZP60033, ZP60034, ZP60038,
#  ZP60039, ZP60040, ZP60041, ZP60042, ZP60043 and TNIP800.
#  The HERC01.REVPROF, HERC02.REVPROF, HERC03.REVPROF and HERC04.REVPROF
#  datasets are deleted (REVIEW does not need them anymore).
#  I've allocated HERC01/2/3/4.ISP.PROF for ISPF and REVIEW.
#  The initial CLIST is changed and will not call TSOAPPLS anymore, but will go directly to ISPF.
#  I have installed BREXX/370 V2R5M0 including the fix found on github. The version = REXX/370 V2R5M0 (Oct 22 2021)
#
#
#  You can download all the disks from www.prince-webdesign.nl/images/tk4rob.zip
#  Place this file into the root directory of the TK4 system.
#  This file replaces the dasd directory in your TK4 system.
#  Please rename your current dasd directory first before unzipping this file.
# 
#  BTW: this update also contains an installation of the Archiver (file 147 on cbttape.org).
#  In HERC01.TEST.CNTL you will find the jobs I used and some other interesting jobs.

instala_tk4_rob() {
  [ -d /vagrant/tmp/ ] || mkdir /vagrant/tmp/
  pushd /vagrant/tmp/
  [ -f tk4rob.zip ] || wget http://www.prince-webdesign.nl/images/tk4rob.zip
  popd

  pushd ~/mvs/
  mv ./dasd ./dasd-tk4-.orig
  unzip /vagrant/tmp/tk4rob.zip
  # ./unattended/set_console_mode hace lo siguiente:
  echo "CONSOLE" > ./unattended/mode
  popd

}



##
# main
#

instala_requisitos
instala_emulador_3270
preconfigura_x3270
instala_tk4_minus
instala_tk4_rob

# corre hercules y hace IPL de MVS 3.8j
# ./mvs

# corre terminal
# /usr/bin/x3270 -model 3279-2  -port 3270  127.0.0.1
# /usr/bin/c3270 -model 3279-2  -port 3270  127.0.0.1

