#

export LESSHISTFILE=-

export ALTERAD_LICENSE_FILE=27001@mu3ebe
source ~/.dotfiles/profile.d/90-quartus.sh
source /opt/geant4/bin/geant4.sh
source /opt/root/bin/thisroot.sh

export CUDACXX=/usr/local/cuda/bin/nvcc

export MIDASSYS=/home/mu3e/midas
export MIDAS_EXPT_NAME=Mu3e
export MIDAS_SERVER_HOST=mu3ebe

export CMAKE_PREFIX_PATH="$HOME/mu3e/install:$HOME/midas${CMAKE_PREFIX_PATH:+:$CMAKE_PREFIX_PATH}"
