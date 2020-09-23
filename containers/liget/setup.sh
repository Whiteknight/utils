LIGET_API_KEY_HASH=$(echo -n "testapikey" | sha256sum -z | head -c 64)
echo $LIGET_API_KEY_HASH
echo "LIGET_API_KEY_HASH=${LIGET_API_KEY_HASH}" > ./.env
mkdir data
echo "call ./add-nuget-source.sh to add the source to nuget if you haven't already"
