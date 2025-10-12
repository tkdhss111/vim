# git@example.com:foo/bar.git
REPO:= git@github.com:tkdhss111/git_test2.git
DATE:= $(shell date +%Y/%m/%d)
 
# Github public key fingerprints (must be added to .ssh/known_hosts)
#
# Remove old public key fingerprints in known_hosts:
# ssh-keygen -R github.com
# Add new Github public key fingerprints:
# ssh-keyscan -t rsa github.com >> .ssh/known_hosts
known_hosts:
	ssh-keygen -R github.com
	ssh-keyscan -t rsa github.com >> C:/Users/tkdhs/.ssh/known_hosts

# ssh-agent is used for passphrase-less SSH authentification.
# By default, the ssh-agent service is disabled.
# Start Windows PowerShell with run as administrator mode.
# Get-Service ssh-agent | Set-Service -StartupType Automatic
# Start-Service ssh-agent
# Get-Service ssh-agent
# Then open command prompt and type ssh-agent <complete-key-path here>
test:
	ssh-agent $env:USERPROFILE/.ssh/id_rsa
	ssh-add -l
	ssh -T git@github.com

#	@echo $(GH_SSH)

init:
	touch README.md
	git config --global user.name "Hisashi Takeda"
	git config --global user.email "tkdhss111@gmail.com"
	git init
	git add README.md
	git commit -m "Initial commit"
	git remote add origin $(REPO) 
	git remote -v
	git push -u origin master

init2:
	echo "# git_test2" >> README.md
	git init
	git add README.md
	git commit -m "first commit"
	git branch -M main
	git remote add origin $(REPO)
	git push -u origin main

pull:
	git remote add origin git@github.com:tkdhss111/git_test3.git
	git branch -M main
	git push -u origin main

clean:
	rm -r bak .git
	rm README.md
