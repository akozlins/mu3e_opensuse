#

.ONESHELL :

init :
	sudo zypper install --no-confirm \
	    git patch cmake gcc-c++ ninja
	sudo zypper install --no-confirm \
	    'xorg-*-devel' 'libboost_*1_75_0-devel' 'libQt5*-devel'
	sudo zypper install --no-confirm \
	    eigen3-devel liblz4-devel libcurl-devel fmt-devel gtkmm3-devel
	# gcc13
	sudo zypper install gcc13-c++
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 130
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 130
	sudo update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 10
	sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 10

.PHONY : geant4-prepare
geant4/.git/config :
	sudo zypper install --no-confirm \
	    libexpat-devel libqt5-creator libXmu-devel
	git clone https://gitlab.cern.ch/geant4/geant4 --branch v11.1.2

.PHONY : geant4-make
geant4-make : geant4/.git/config
	mkdir -p geant4/cmake-build
	cd geant4/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX=/opt/geant4-11.1.2 \
	    -DGEANT4_INSTALL_DATA=ON \
	    -DGEANT4_USE_QT=ON \
	    -DGEANT4_USE_OPENGL_X11=ON \
	    -G Ninja \
	    ..
	ninja

geant4-install :
	cd geant4/cmake-build
	sudo ninja install

root/.git/config :
	sudo zypper install --no-confirm \
	    libX11-devel libXpm-devel libXft-devel libXext-devel libopenssl-devel libpng16-devel libxml2-devel
	git clone https://github.com/root-project/root --branch v6-29-02

root-make : root/.git/config
	mkdir -p root/cmake-build
	cd root/cmake-build
	cmake \
	    -DCMAKE_INSTALL_PREFIX=/opt/root-6.29.02 \
	    -DCMAKE_CXX_STANDARD=17 \
	    -DLLVM_CXX_STD=c++17 \
	    -Dxrootd=OFF \
	    -G Ninja \
	    ..
	ninja

root-install :
	cd root/cmake-build
	sudo ninja install

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
