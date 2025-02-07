#

export LESSHISTFILE=-
export EDITOR="nano -c"
export PATH="$HOME/bin:$PATH"

export ALTERAD_LICENSE_FILE=27001@mu3ebe
source ~/.dotfiles/profile.d/90-quartus.sh
source /opt/geant4/bin/geant4.sh
source /opt/root/bin/thisroot.sh

export CUDACXX=/usr/local/cuda/bin/nvcc

export MIDASSYS="$HOME/midas"
export MIDAS_EXPT_NAME=Mu3e
[ "$(hostname)" != "mu3ebe" ] && export MIDAS_SERVER_HOST=mu3ebe
export MIDAS_EXPTAB="$HOME/online/online/exptab"

# midas repo
export CMAKE_PREFIX_PATH="$MIDASSYS${CMAKE_PREFIX_PATH:+:$CMAKE_PREFIX_PATH}"
export PATH="$MIDASSYS/bin:$PATH"
export LD_LIBRARY_PATH="$MIDASSYS/lib:$LD_LIBRARY_PATH"

# mu3e repo
export CMAKE_PREFIX_PATH="$HOME/mu3e/install${CMAKE_PREFIX_PATH:+:$CMAKE_PREFIX_PATH}"
export PATH="$HOME/mu3e/install/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/mu3e/install/lib64:$LD_LIBRARY_PATH"

# online repo
export PATH="$HOME/online/install/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/online/install/lib64:$LD_LIBRARY_PATH"

#source "$HOME/online/install/set_env.sh"
