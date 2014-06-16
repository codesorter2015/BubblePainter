nw=0.9.2

cd "`dirname "$0"`/../../"

hash npm 2>/dev/null || {
  echo >&2 "You must install Node.js and npm to run this program: http://nodejs.org"
  exit 1
}

hash nodemon 2>/dev/null || {
  echo "You must install nodemon run this program. Please enter your password to install nodemon:";
  sudo npm install -g nodemon
}

if [ ! -d "app/node_modules" ]; then
  cd app
  mv package.json package.json.backup
  mv .package.npm.json package.json
  npm install
  mv package.json .package.npm.json
  mv package.json.backup package.json
  cd ..
fi

if [ ! -d "dev/mac/node-webkit-v$nw-osx-ia32" ]; then
  echo "Downloading node-webkit v$nw development environment..."
  curl -sS http://dl.node-webkit.org/v$nw/node-webkit-v$nw-osx-ia32.zip > nw.zip
  mkdir node-webkit-v$nw-osx-ia32
  unzip nw.zip -d node-webkit-v$nw-osx-ia32/
  rm nw.zip
  mv node-webkit-v$nw-osx-ia32 dev/mac/
fi

./dev/mac/node-webkit-v$nw-osx-ia32/node-webkit.app/Contents/MacOS/node-webkit app/