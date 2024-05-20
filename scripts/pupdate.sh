COMMIT_MSG=$1
COMMIT_DESC=$2

if [ -z $COMMIT_MSG ]; then
	COMMIT_MSG="auto generated message"
fi

echo -e "\n[pupdate] Adding all files to the staging area ... " &&
git add . &&

echo -e "\n[pupdate] Commitng changes ..." &&
git commit -m $COMMIT_MSG $COMMIT_DESC &&

echo -e "\n[pupdate] Pushing to the origin ..." &&
git push origin main &&

cd /etc/nixos &&

echo -e "\n[pupdate] Pulling in /etx/nixos ..." &&
&& sudo git pull origin main &&

echo -e "\n[pupdate] updating ..." &&
&& update &&

echo -e "\n[pupdate] Done"
