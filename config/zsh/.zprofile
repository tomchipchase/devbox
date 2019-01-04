# SSH-AGENT
#!/usr/bin/env bash
SERVICE='ssh-agent'
WHOAMI=`whoami`

# if pgrep -u $WHOAMI $SERVICE >/dev/null
# then
# # echo $SERVICE running.
# else
# # echo $SERVICE not running.
# # echo starting
# ssh-agent > ~/.ssh/agent_env
# fi
# . ~/.ssh/agent_env >/dev/null
