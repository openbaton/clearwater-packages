#!/bin/bash
#########################
#	Openbaton	#
#########################
# Author : lgr

# clearwater relation script

#foreign="homer"
# we can read the relation name by the name of the script!
foreign=$(echo $0 | rev | cut -d "/" -f 1 | rev | cut -d "_" -f 1)

# If there are default options load them 
if [ -f "$SCRIPTS_PATH/default_options" ]; then
	source $SCRIPTS_PATH/default_options
fi

if [ -z "$SCRIPTS_PATH" ]; then
	echo "$SERVICE : Using default script path $SCRIPTS_PATH"
	SCRIPTS_PATH="/opt/openbaton/scripts"
else
	echo "$SERVICE : Using custom script path $SCRIPTS_PATH"
fi

# copy homer related information
if [ -f "$REALMFILE" ] && [ -z "$(cat $REALMFILE | grep $foreign)" ];then
cat >> $REALMFILE <<EOL
homer-1                IN A     VAR_HOMER_MGMT
homer                  IN A     VAR_HOMER_MGMT
EOL
fi

# TODO : enable scaling 
source $SCRIPTS_PATH/relation_joined.sh

# the generic relation_joined handles replacing the ip afterwards
