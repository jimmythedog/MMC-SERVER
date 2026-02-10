#!/usr/bin/env bash

set -eEuo pipefail

isNodeInstalled() {
  node -v > /dev/null 2>&1
  npm -v > /dev/null 2>&1
}

isNodeInstalledViaApt() {
  dpkg -l npm > /dev/null 2>&1
}

if isNodeInstalled; then
  if isNodeInstalledViaApt; then
    echo
    echo "NodeJS has been installed via apt, and needs to be removed"
    echo
    read -p "Do you wish to completely remove NodeJS? (y/n) " input
    if [ "${input^^}" = "Y" ]; then
      sudo apt-get --purge autoremove -y nodejs npm
    else
      echo "You will need to remove NodeJS before you can continue"
      exit 1
    fi
  else
    echo "ERROR: node.js is already installed, but not via the package manager (apt)"
    echo "       Therefore, I cannot continue, sorry"
    exit 1
  fi
fi

cat <<EOF

Here is a summary of what I'm going to do...
* Remove any existing node directory if I find one
* Download the NodeJS tarball from the official site
* Extract it to your home directory
* Finally, I will update your .profile file to add the new directory to your path
* Once all of this done, you will need to follow the steps shown at the end of this run
* Note: If jq is not already installed, I will temp install it to make life easier for me

EOF

read -p "Do you wish to continue? (y/n) " input
if [ ! "${input^^}" = "Y" ]; then
  echo "OK, installation aborted"
  exit 1
fi

if ! jq -V >/dev/null 2>&1; then
  REMOVE_JQ=true
  sudo apt install -y jq
fi

if curl -V > /dev/null 2>&1; then
    WEB_GET_CMD="curl -fsSLo"
else
    WEB_GET_CMD="wget -qO"
fi

read NODE_VERSION NPM_VERSION \
  <<< $(${WEB_GET_CMD}- https://nodejs.org/download/release/index.json |\
  jq -r '[.[]|select (.lts != false)][0] | [.version, .npm] | @tsv')

if [ -n "${REMOVE_JQ:-}" ]; then
  sudo apt purge -y jq
fi

NODE_DIRECTORY="node-${NODE_VERSION}-linux-x64"

cd ${HOME}
if [ -d "${NODE_DIRECTORY}" ]; then
  rm -rf "${NODE_DIRECTORY}"
fi

${WEB_GET_CMD}- https://nodejs.org/dist/${NODE_VERSION}/${NODE_DIRECTORY}.tar.xz | tar xJ
if ! grep -q "${NODE_VERSION}" .profile; then
  echo "PATH=\${HOME}/${NODE_DIRECTORY}/bin:\${PATH}" >> ~/.profile
  echo
  echo "IMPORTANT! You will need to log out and back in for the changes to take effect!!!"
  echo "           (Alternatively, you could just execute '. ~/.profile')"
  echo "Once you've done that, execute both 'node -v' & 'npm -v' to ensure everything is OK"
  . .profile
fi

cat <<EOF

I now detect node version $(node -v) (and I expected ${NODE_VERSION})
And I detect npm version $(npm -v) (and I expected ${NPM_VERSION})

EOF
