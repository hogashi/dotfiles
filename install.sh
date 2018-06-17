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
echo "## % git clone git@github.com:hogashi/dotfiles.git ${DFDIR}"
git clone git@github.com:hogashi/dotfiles.git ${DFDIR}
RETV=$?

echo
if [ $RETV -ne 0 ]; then
  if [ $RETV -eq 128 ]; then
    echo "## ${RETV}: '${DFDIR}' already exists."
    echo "## select: by default '(q)uit', OR '(u)se it' OR '(o)verwrite'"
    echo -n "[Q/u/o]: "
    read RVAR
    case $RVAR in
      u*)
        echo "## (u)sing it..."
        ;;
      o*)
        echo '## (o)verwriting...'
        echo "## % rm -rf ${DFDIR} && git clone git@github.com:hogashi/dotfiles.git ${DFDIR}"
        rm -rf ${DFDIR} && git clone git@github.com:hogashi/dotfiles.git ${DFDIR}
        ;;
      *)
        echo "## (q)uitting..."
        return 3
        ;;
    esac
  else
    echo "## ${RETV}: failed to clone dotfiles. exitting..."
    return 2
  fi
fi

echo
echo '# installing dotfiles...'
echo

for DFILE in $(ls ${DFDIR} | egrep -v "(\.git|install\.sh|ignores)"); do
  echo "## % ln -s ${FORCE} ${DFILE} ~/.$(basename ${DFILE})"
  ln -s ${DFILE} ~/.${DFILE}
done

