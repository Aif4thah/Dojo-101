# git

## conf

```bash
git config --global user.email vaca@hotmail.fr
git config --global user.name vaca@hotmail.fr
git add *
git commit -m "update MM-YYYY"
git push origin main
```

## create a pull request:

```bash
git clone https://github.com/<YourUserName>/demo
```
Use my demo repo to try it out.


Once there, click on the Fork button in the top-right corner. This creates a new copy of my demo repo under your GitHub user account with a URL like:

```bash
https://github.com/<YourUserName>/demo
```

The copy includes all the code, branches, and commits from the original repo.
Next, clone the repo by opening the terminal on your computer and running the command:

```bash
git clone https://github.com/<YourUserName>/demo
```
Once the repo is cloned, you need to do two things:

## Create a new branch by issuing the command:

```bash
$ git checkout -b new_branch
#Create a new remote for the upstream repo with the command:

$ git remote add upstream https://github.com/kedark3/demo
#In this case, "upstream repo" refers to the original repo you created your fork from.

#Now you can make changes to the code. The following code creates a new branch, makes an arbitrary change, and pushes it to new_branch:

$ git checkout -b new_branch
Switched to a new branch ‘new_branch’
$ echo “some test file” > test
$ cat test
Some test file
$ git status
On branch new_branch
No commits yet
Untracked files:
  (use "git add <file>..." to include in what will be committed)
    test
nothing added to commit but untracked files present (use "git add" to track)
$ git add test
$ git commit -S -m "Adding a test file to new_branch"
[new_branch (root-commit) 4265ec8] Adding a test file to new_branch
 1 file changed, 1 insertion(+)
 create mode 100644 test
$ git push -u origin new_branch
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), 918 bytes | 918.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
Remote: Create a pull request for ‘new_branch’ on GitHub by visiting:
Remote:   http://github.com/example/Demo/pull/new/new_branch
Remote:
 * [new branch]         new_branch -> new_branch
#Once you push the changes to your repo, the Compare & pull request button will appear in GitHub.
```