#

.ONESHELL :

init :
	sudo zypper install --no-confirm \
	    git patch cmake gcc-c++
	sudo zypper install --no-confirm \
	    'xorg-*-devel' 'libboost_*1_75_0-devel' 'libQt5*-devel'

.PHONY : geant4-prepare
geant4/.git/config :
	sudo zypper install --no-confirm \
	    libexpat-devel libqt5-creator libXmu-devel
	git clone https://gitlab.cern.ch/geant4/geant4
	mkdir -p geant4/cmake-build

.PHONY : geant4-make
geant4-make : geant4/.git/config
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

root/.git/config :
	sudo zypper install --no-confirm \
	    libX11-devel libXpm-devel libXft-devel libXext-devel libopenssl-devel libpng16-devel
	git clone https://github.com/root-project/root
	mkdir -p root/cmake-build

root-make : root/.git/config
	cd root/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX=/opt/root \
	    -DCMAKE_CXX_STANDARD=17 \
	    -Dxrootd=OFF \
	    ..
	$(MAKE)

root-install :
	cd root/cmake-build
	sudo $(MAKE) install

midas/.git/config :
	git clone https://bitbucket.org/tmidas/midas
	git -C midas submodule update --init --recursive
	mkdir -p midas/cmake-build
	ln -s -T $(shell readlink -f -- midas) ~/midas

midas-make : midas/.git/config
	cd midas/cmake-build
	cmake \
	    -DNO_NVIDIA=1 \
	    -DNO_OPENCV=1 \
	    ..
	$(MAKE)

midas-install :
	cd midas/cmake-build
	$(MAKE) install
