CURRENT_VERSION=`git describe --abbrev=0 --tags 2>/dev/null`
[ $CURRENT_VERSION == '' ] && echo "You need tag in repo" && exit 1
echo "Current Version: $CURRENT_VERSION"
#replace . with space so can split into an array
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })
#get number parts
VNUM1=${CURRENT_VERSION_PARTS[0]}
VNUM2=${CURRENT_VERSION_PARTS[1]}
VNUM3=${CURRENT_VERSION_PARTS[2]}

CHANGES=$(git log --pretty=oneline HEAD...${CURRENT_VERSION} | awk '{ $1=""; print "-" $0 }')
echo "Changes:"
echo ${CHANGES}
if [[ $CHANGES =~ "feat" ]]
then
    VNUM2=$((VNUM2+1))
    VNUM3=0
else
    VNUM3=$((VNUM3+1))
fi

#create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
echo "Updating $CURRENT_VERSION to $NEW_TAG"

# #get current hash and see if it already has a tag
# GIT_COMMIT=`git rev-parse HEAD`
# NEEDS_TAG=`git describe --contains $GIT_COMMIT 2>/dev/null`

# #only tag if no tag already
# if [ -z "$NEEDS_TAG" ]; then
#   git tag -a "${NEW_TAG}" -m "${CHANGES}"
#   git push --tags
#   git push
# else
#   echo "Already a tag on this commit" && exit 1
# fi

# exit 0
