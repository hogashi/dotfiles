#!/bin/bash

# Usage: source install.sh [-f]

echo $*

FORCE=""
if [ "$1" = "-f" ]; then
  FORCE="-f"
fi

echo '# cloning dotfiles...'
echo
echo '## % type git'
type git
echo

RETV=$?
if [ $RETV -ne 0 ]; then
  echo "## ${RETV}: 'git' not found. exitting..."
  return 2
fi

DFDIR="${HOME}/.dotfiles"

CSKIP=""
if [ -d $DFDIR ]; then
  echo "## ${RETV}: '${DFDIR}' already exists."
  echo "## select: by default '(q)uit', OR '(u)se it' OR '(o)verwrite'"
  echo -n "[Q/u/o]: "
  read RVAR
  case $RVAR in
    u*)
      echo "## (u)sing it..."
      CSKIP="true"
      ;;
    o*)
      echo '## (o)verwriting...'
      echo "## % rm -rf ${DFDIR}"
      rm -rf ${DFDIR}
      if [ $? -ne 0 ]; then
        echo "## failed to rm old directory. exitting..."
        return 2
      fi
      ;;
    *)
      echo "## (q)uitting..."
      return 3
      ;;
  esac
fi

if [ "$CSKIP" != "true" ]; then
  echo "## % git clone https://github.com/hogashi/dotfiles.git ${DFDIR}"
  git clone https://github.com/hogashi/dotfiles.git ${DFDIR}
  RETV=$?

  if [ $RETV -ne 0 ]; then
    echo "## ${RETV}: failed to clone dotfiles. exitting..."
    return 2
  fi
fi

echo
echo '# installing dotfiles...'
echo

LINKFAIL=0
for DFILE in ${DFDIR}/linkees/*; do
  echo "## % ln -s ${FORCE} ${DFILE} ~/.$(basename ${DFILE})"
  ln -s ${FORCE} ${DFILE} ~/.$(basename ${DFILE})
  if [ $? -ne 0 ]; then
    LINKFAIL=1
  fi
done

if [ $LINKFAIL -eq 1 ]; then
  echo '# warn: ln failed, consider use "-f" option to force link'
fi

# install vim-plug
echo '# download and install vim-plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo '# done!'
echo '# do `exec $SHELL -l` to apply them.'

