echo "[pre-push] Start prepush check"
# Check for eslint
echo "[pre-push] Check for NPM..."
which npm &> /dev/null
if [[ "$?" == 1 ]]; then
    echo "Please install NPM"
    exit 1
fi
echo "Pass for checking NPM"
# Eslint check all files under src/
echo "Eslint check all files under src/..."
npm run lint
if [[ "$?" == 1 ]]; then
    echo "ESlint check fail, abort git push"
    exit 1
fi
echo "Pass for Eslint check"
echo "[pre-push] successfully"