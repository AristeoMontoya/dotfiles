notes="/notas"
cd "${HOME}${notes}"
message="AUTO $(date +'%Y-%m-%d %H:%M')"

git add .
git commit -m "$message"
git pull
if [ $? -eq 0 ]; then
	echo "Sin conflicto"
	git push
	exit 0
else
	exit 1
fi
