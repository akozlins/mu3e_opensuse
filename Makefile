#

.ONESHELL :

init :
	sudo zypper install git patch cmake gcc-c++

.PHONY : geant4-prepare
geant4-prepare :
	sudo zypper install libexpat-devel libqt5-creator libXmu-devel
	git clone https://gitlab.cern.ch/geant4/geant4
	mkdir -p geant4/cmake-build

.PHONY : geant4-make
geant4-make :
	cd geant4/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX=/opt/geant4 \
	    -DGEANT4_INSTALL_DATA=ON \
	    -DGEANT4_USE_QT=ON \
	    -DGEANT4_USE_OPENGL_X11=ON \
	    ..
	$(MAKE)

geant4-install :
	cd geant4/cmake-build
	sudo $(MAKE) install

root-prepare :
	sudo zypper install libX11-devel libXpm-devel libXft-devel
	git clone https://github.com/root-project/root
	mkdir -p root/cmake-build

root-make :
	cd root/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX=/opt/root \
	    -DCMAKE_CXX_STANDARD=17 \
	    ..
	$(MAKE)

root-install :
	cd root/cmake-build
	sudo $(MAKE) install

midas-prepare :
	git clone https://bitbucket.org/tmidas/midas
	mkdir -p midas/cmake-build

midas-make :
	cd midas/cmake-build
	cmake \
	    -DNO_NVIDIA=1 \
	    -DNO_OPENCV=1 \
	    ..
	$(MAKE)

midas-install :
	cd midas/cmake-build
	$(MAKE) install
