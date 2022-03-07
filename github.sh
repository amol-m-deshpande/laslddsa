#!/bin/bash  
  
# Read the user input   
echo "Enter the git username: "  
read username  
echo "Enter the github auth token:"  
read git_token
echo "Enter the name of the repo"  
read repo_name

# creating the github repo
# curl -H 'Authorization: token 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' https://api.github.com/user/repos -d '{"name":"$repo_name"}'
curl -H 'Authorization: token '${git_token}'' https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'

git commit -am "local change update"


git push https://user_name:$git_token@github.com/$username/$repo_name.git
 


