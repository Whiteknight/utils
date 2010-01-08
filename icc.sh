# By default, icc installs to /opt/intel/*
# We do a quick and dirty find here to try and get the binary name.
# We don't do anything here to prevent fetching multiple results, if
# we have multiple versions installed.
WKICC=$(find /opt/intel/ -name icc)

# The iccvars_ia32.sh script updates path and everything.
# TODO: Handle other platforms, not just ia32.
# TODO: We should run iccvars_ia32.sh lazily. I don't know if the variable
#       names it defines will conflict with other compilers
if [ -e $WKICC ]; then
    WKICCPATH=${WKICC%/icc}
    source $WKICCPATH/iccvars_ia32.sh
fi

