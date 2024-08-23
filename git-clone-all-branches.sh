#!/bin/bash

echo "Welcome to use git-clone-all-branches toolkit developed by Krxkli"

echo "请输入克隆链接: "
read repo_url

#echo "请输入仓库名:"
#read repo_name

clone_info="git-clone-all-branches-name.log"
git clone --progress $repo_url &> $clone_info
repo_name=$(head $clone_info -n 1 | cut -d "'" -f 2)
rm ${clone_info}

cd $repo_name

save_file_path="${repo_name}_branches.txt"

git branch -r > ${save_file_path}

readarray -t lines < ${save_file_path}

counter=0
for line in "${lines[@]}"
do
	if [ $counter -gt 0 ]; then
		local_name=$(echo "$line" | cut -d'/' -f2)
		echo "fetch branch: ${local_name}"
		git checkout -b ${local_name} ${line}
	fi

	((counter++))
done

rm ${save_file_path}





