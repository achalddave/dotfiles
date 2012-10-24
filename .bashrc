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
alias l='ls'

# OCF config
if [ -r /opt/ocf/share/environment/.bashrc ]; then
  source /opt/ocf/share/environment/.bashrc
fi
