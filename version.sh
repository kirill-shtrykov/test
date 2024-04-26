CURRENT_VERSION=`git describe --abbrev=0 --tags 2>/dev/null`
[ $CURRENT_VERSION == '' ] && echo "You need tag in repo" && exit 1
echo "Current Version: $CURRENT_VERSION"
#replace . with space so can split into an array
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })
#get number parts
VNUM1=${CURRENT_VERSION_PARTS[0]}
VNUM2=${CURRENT_VERSION_PARTS[1]}
VNUM3=${CURRENT_VERSION_PARTS[2]}

git log --pretty=oneline HEAD...${CURRENT_VERSION}
