#

.ONESHELL :

init :
	sudo zypper install git patch cmake gcc-c++

geant4-prepare :
	sudo zypper install libexpat-devel libqt5-creator libXmu-devel
	git clone https://gitlab.cern.ch/geant4/geant4
	mkdir -p geant4/cmake-build

.PHONY : geant4
geant4 :
	cd geant4/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX=/opt/geant4 \
	    -DGEANT4_INSTALL_DATA=ON \
	    -DGEANT4_USE_QT=ON \
	    -DGEANT4_USE_OPENGL_X11=ON \
	    ..
	$(MAKE)

root-prepare :
	sudo zypper install libX11-devel libXpm-devel libXft-devel
	git clone https://github.com/root-project/root
	mkdir -p root/cmake-build

root :
	cd root/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX=/opt/root \
	    -DCMAKE_CXX_STANDARD=17 \
	    ..
	$(MAKE)
