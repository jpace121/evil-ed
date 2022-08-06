for repo in straight/repos/*
do
  echo $repo
  pushd $repo
  url=$(git remote get-url $(git remote))
  echo $url
  popd
  git submodule add $url ./$repo
done
