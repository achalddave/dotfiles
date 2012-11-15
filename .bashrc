# test
# start settings from berkeley computers... need to figure
# out what these do, but for now, don't mess with them
[[ -z ${MASTER} ]] && export MASTER=${LOGNAME%-*}
[[ -z ${MASTERDIR} ]] && export MASTERDIR=$(eval echo ~${MASTER})

# Set up class wide settings
for file in ${MASTERDIR}/adm/bashrc.d/* ; do [[ -x ${file} ]] && . "${file}"; done

# Set up local settings
for file in ${HOME}/bashrc.d/* ; do [[ -x ${file} ]] && . "${file}"; done

# OCF config
if [ -r /opt/ocf/share/environment/.bashrc ]; then
  source /opt/ocf/share/environment/.bashrc
fi

# end berkeley settings, start my settings
alias ls='ls --color=always'
alias l='ls'
alias la='ls -a'

alias so='source'

alias ssh170='ssh cs170-ed@stella.cs.berkeley.edu'
alias ssh61c='ssh cs61c-kg@stella.cs.berkeley.edu'
#alias ssh61ch='ssh cs61c-kg@hive5.cs.berkeley.edu'

function ssh61ch {
    if  [ -z "$1" ]; then
        server=5
    else
        server=$1
    fi
    `echo "ssh cs61c-kg@hive$server.cs.berkeley.edu"`
}

if [ `uname` == "Linux" ]
then
    alias ls='ls --color=always'
fi

function check_submission {
    rm -rf ~/tmp_check_submission;
    mkdir ~/tmp_check_submission;
    cd ~/tmp_check_submission;
    git init;
    git remote add origin ~cs61c/git/repos/cs61c-kg;
    git pull origin $1;
    read -p "Press [Enter] to continue";
    cd ~;
    #rm -rf ~/tmp_check_submission;
}
