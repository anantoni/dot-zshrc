# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history



# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# Autoload screen if we aren't in it.  (Thanks Fjord!)
#if [[ $STY = '' ]] then screen -xR; fi

   #{{{ ZSH Modules

   autoload -U compinit promptinit zcalc zsh-mime-setup
   compinit
   promptinit
   zsh-mime-setup

   #}}}

   #{{{ Options

   # why would you type 'cd dir' if you could just type 'dir'?
   setopt AUTO_CD

   # Now we can pipe to multiple outputs!
   setopt MULTIOS

   # Spell check commands!  (Sometimes annoying)
   setopt CORRECT

   # This makes cd=pushd
   setopt AUTO_PUSHD

   # This will use named dirs when possible
   setopt AUTO_NAME_DIRS

   # If we have a glob this will expand it
   setopt GLOB_COMPLETE
   setopt PUSHD_MINUS

   # No more annoying pushd messages...
   # setopt PUSHD_SILENT

   # blank pushd goes to home
   setopt PUSHD_TO_HOME

   # this will ignore multiple directories for the stack.  Useful?  I dunno.
   setopt PUSHD_IGNORE_DUPS

   # 10 second wait if you do something that will delete everything.  I wish I'd had this before...
   setopt RM_STAR_WAIT

   # use magic (this is default, but it can't hurt!)
   setopt ZLE

   setopt NO_HUP

   setopt VI

   # only fools wouldn't do this ;-)
   export EDITOR="emacs"


   setopt IGNORE_EOF

   # If I could disable Ctrl-s completely I would!
   setopt NO_FLOW_CONTROL

   # beeps are annoying
   setopt NO_BEEP

   # Keep echo "station" > station from clobbering station
   setopt NO_CLOBBER

   # Case insensitive globbing
   setopt NO_CASE_GLOB

   # Be Reasonable!
   setopt NUMERIC_GLOB_SORT

   # I don't know why I never set this before.
   setopt EXTENDED_GLOB

   # hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
   setopt RC_EXPAND_PARAM

   #}}}

   #{{{ Variables
   export MATHPATH="$MANPATH:/usr/local/texlive/2007/texmf/doc/man"
   export INFOPATH="$INFOPATH:/usr/local/texlive/2007/texmf/doc/info"
   export PATH="$PATH:/usr/local/texlive/2007/bin/i386-linux"
   export RI="--format ansi"

   declare -U path

   #export LANG=en_US
   export PAGER=most
   #}}}

   #{{{ External Files

   # Include stuff that should only be on this
   if [[ -r ~/.localinclude ]]; then
       source ~/.localinclude
   fi

   # Include local directories
   if [[ -r ~/.localdirs ]]; then
       source ~/.localdirs
   fi

   autoload run-help
   HELPDIR=~/zsh_help

   #}}}

   #{{{ Aliases

   #{{{ Amarok
   if [[ -x =amarok ]]; then
       alias play='dcop amarok player play'
       alias pause='dcop amarok player pause'
       alias next='dcop amarok player next'
       alias prev='dcop amarok player prev'
       alias stop='dcop amarok player stop'
       alias current='dcop amarok player nowPlaying'
       alias osd='dcop amarok player showOSD'
       alias pp='dcop amarok player playPause'
   fi

   #}}}

   #{{{ Shell Conveniences

   alias sz='source ~/.zshrc'
   alias ez='vim ~/.zshrc'
   alias mk=popd
   alias ls='pwd; ls --color'

   #}}}

   #{{{ Package management

   if [[ -x =aptitude ]]; then
       alias attd="sudo xterm -C aptitude"
   else
       if [[ -x =emerge ]]; then
           alias emu='sudo emerge -uDN world'
           alias emup='sudo emerge -uDvpN world'
           alias esy='sudo emerge --sync'
           alias ei='sudo emerge'
           alias eip='sudo emerge -vp '
           alias packmask='sudo vi /etc/portage/package.unmask'
           alias packuse='sudo vi /etc/portage/package.use'
           alias packkey='sudo vi /etc/portage/package.keywords'
       fi
   fi

   #}}}

   #{{{ SSH

   if [[ $HOST = FrewSchmidt ]]; then
       alias sf='ssh frew@FrewSchmidt2'
   else
       alias sf='ssh frew@FrewSchmidt'
   fi

   alias enosh='ssh schmidtf@enosh.letnet.net'

   alias s31='ssh 192.168.3.1'
   alias s39='ssh 192.168.3.9'
   #}}}

   #{{{ Misc.
   if [[ -x `which tea_chooser` ]]; then
       # I need to do this more elegantly...
       alias rt='cd /home/frew/bin/run/tea_chooser; ./randtea.rb'
   fi

   # CPAN and sudo don't work together or something
   if [[ -x `which perl` ]]; then
       alias cpan="su root -c 'perl -MCPAN -e \"shell\"'"
   fi

   # Maxima with line editing!  Now if only I could use zle...
   if [[ -x `which maxima` && -x `which ledit` ]]; then
       alias maxima='ledit maxima'
   fi

   # Convenient.  Also works in Gentoo or Ubuntu
   if [[ -x `which irb1.8` ]]; then
       alias irb='irb1.8 --readline -r irb/completion'
   else
       alias irb='irb --readline -r irb/completion'
   fi

   # For some reason the -ui doesn't work on Ubuntu... I need to deal with that
   # somehow...
   if [[ -x `which unison` ]]; then
       alias un='unison -ui graphic -perms 0 default'
       alias un.='unison -ui graphic -perms 0 dotfiles'
   fi

   # fri is faster.
   if [[ -x `which fri` ]]; then
       alias ri=fri
   fi

   # This is how you can see all of my passwords.
   alias auth='view ~/.auth.des3'

   # copy with a progress bar.
   alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

   # save a few keystrokes when opening the learn sql database
   if [[ -x `which psql` ]]; then
       alias lrnsql="psql learn_sql"
   fi

   # I use the commands like, every day now
   alias seinr="sudo /etc/init.d/networking restart"
   if [[ -x `which gksudo` && -x `which wlassistant` ]]; then
       alias gkw="gksudo wlassistant&"
   fi

   alias kgs='javaws http://files.gokgs.com/javaBin/cgoban.jnlp'

   if [[ -x `which delish` ]]; then
       alias delish="noglob delish"
   fi

   alias tomes='screen -S tome -c /home/frew/.tomescreenrc'
   alias mpfs='mplayer -fs -zoom'
   alias mpns='mplayer -nosound'

   if [[ -x /home/frew/personal/dino ]]; then
       dinoray=( /home/frew/personal/dino/* )
       alias dino='feh $dinoray[$RANDOM%$#dinoray+1]'
   fi

   #}}}

   #{{{ Globals...

   alias -g G="| grep"
   alias -g L="| less"

   #}}}

   #{{{ Suffixes...

   if [[ -x `which abiword` ]]; then
       alias -s doc=abiword
   fi
   if [[ -x `which ooimpress` ]]; then
       alias -s ppt='ooimpress &> /dev/null '
   fi

   if [[ $DISPLAY = '' ]] then
      alias -s txt=vi
      else
          alias -s txt=gvim
   fi

      #}}}

      #}}}

      #{{{ Completion Stuff

	bindkey -M viins '\C-i' complete-word

	# Faster! (?)
	zstyle ':completion::complete:*' use-cache 1

	# case insensitive completion
	zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

	zstyle ':completion:*' verbose yes
	zstyle ':completion:*:descriptions' format '%B%d%b'
	zstyle ':completion:*:messages' format '%d'
	zstyle ':completion:*:warnings' format 'No matches for: %d'
	zstyle ':completion:*' group-name ''
	#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
	zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored

	# generate descriptions with magic.
	zstyle ':completion:*' auto-description 'specify: %d'

	# Don't prompt for a huge list, page it!
	zstyle ':completion:*:default' list-prompt '%S%M matches%s'

	# Don't prompt for a huge list, menu it!
	zstyle ':completion:*:default' menu 'select=0'

	# Have the newer files last so I see them first
	zstyle ':completion:*' file-sort modification reverse

	# color code completion!!!!  Wohoo!
	zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

	unsetopt LIST_AMBIGUOUS
	setopt  COMPLETE_IN_WORD

	# Separate man page sections.  Neat.
	zstyle ':completion:*:manuals' separate-sections true

	# Egomaniac!
	zstyle ':completion:*' list-separator 'fREW'

	# complete with a menu for xwindow ids
	zstyle ':completion:*:windows' menu on=0
	zstyle ':completion:*:expand:*' tag-order all-expansions

	# more errors allowed for large words and fewer for small words
	zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'

	# Errors format
	zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

	# Don't complete stuff already on the line
	zstyle ':completion::*:(rm|vi):*' ignore-line true

	# Don't complete directory we are already in (../here)
	zstyle ':completion:*' ignore-parents parent pwd

	zstyle ':completion::approximate*:*' prefix-needed false

	#}}}

	#{{{ Key bindings

	# Who doesn't want home and end to work?
	bindkey '\e[1~' beginning-of-line
	bindkey '\e[4~' end-of-line

	# Incremental search is elite!
	bindkey -M vicmd "/" history-incremental-search-backward
	bindkey -M vicmd "?" history-incremental-search-forward

	# Search based on what you typed in already
	bindkey -M vicmd "//" history-beginning-search-backward
	bindkey -M vicmd "??" history-beginning-search-forward

	bindkey "\eOP" run-help

	# oh wow!  This is killer...  try it!
	bindkey -M vicmd "q" push-line

	# Ensure that arrow keys work as they should
	bindkey '\e[A' up-line-or-history
	bindkey '\e[B' down-line-or-history

	bindkey '\eOA' up-line-or-history
	bindkey '\eOB' down-line-or-history

	bindkey '\e[C' forward-char
	bindkey '\e[D' backward-char

	bindkey '\eOC' forward-char
	bindkey '\eOD' backward-char

	bindkey -M viins 'jj' vi-cmd-mode
	bindkey -M vicmd 'u' undo

	# Rebind the insert key.  I really can't stand what it currently does.
	bindkey '\e[2~' overwrite-mode

	# Rebind the delete key. Again, useless.
	bindkey '\e[3~' delete-char

	bindkey -M vicmd '!' edit-command-output

	# it's like, space AND completion.  Gnarlbot.
	bindkey -M viins ' ' magic-space

	#}}}

	#{{{ History Stuff

	# Where it gets saved
	HISTFILE=~/.history

	# Remember about a years worth of history (AWESOME)
	SAVEHIST=10000
	HISTSIZE=10000

	# Don't overwrite, append!
	setopt APPEND_HISTORY

	# Write after each command
	# setopt INC_APPEND_HISTORY

	# Killer: share history between multiple shells
	setopt SHARE_HISTORY

	# If I type cd and then cd again, only save the last one
	setopt HIST_IGNORE_DUPS

	# Even if there are commands inbetween commands that are the same, still only save the last one
	setopt HIST_IGNORE_ALL_DUPS

	# Pretty    Obvious.  Right?
	setopt HIST_REDUCE_BLANKS

	# If a line starts with a space, don't save it.
	setopt HIST_IGNORE_SPACE
	setopt HIST_NO_STORE

	# When using a hist thing, make a newline show the change before executing it.
	setopt HIST_VERIFY

	# Save the time and how long a command ran
	setopt EXTENDED_HISTORY

	setopt HIST_SAVE_NO_DUPS
	setopt HIST_EXPIRE_DUPS_FIRST
	setopt HIST_FIND_NO_DUPS

	#}}}

	#{{{ Prompt!

	host_color=cyan
	history_color=yellow
	user_color=green
	root_color=red
	directory_color=magenta
	error_color=red
	jobs_color=green

	host_prompt="%{$fg_bold[$host_color]%}%m%{$reset_color%}"

	jobs_prompt1="%{$fg_bold[$jobs_color]%}(%{$reset_color%}"

	jobs_prompt2="%{$fg[$jobs_color]%}%j%{$reset_color%}"

	jobs_prompt3="%{$fg_bold[$jobs_color]%})%{$reset_color%}"

	jobs_total="%(1j.${jobs_prompt1}${jobs_prompt2}${jobs_prompt3} .)"

	history_prompt1="%{$fg_bold[$history_color]%}[%{$reset_color%}"

	history_prompt2="%{$fg[$history_color]%}%h%{$reset_color%}"

	history_prompt3="%{$fg_bold[$history_color]%}]%{$reset_color%}"

	history_total="${history_prompt1}${history_prompt2}${history_prompt3}"

	error_prompt1="%{$fg_bold[$error_color]%}<%{$reset_color%}"

	error_prompt2="%{$fg[$error_color]%}%?%{$reset_color%}"

	error_prompt3="%{$fg_bold[$error_color]%}>%{$reset_color%}"

	error_total="%(?..${error_prompt1}${error_prompt2}${error_prompt3} )"

	case "$TERM" in
	  (screen)
	    function precmd() { print -Pn "\033]0;S $TTY:t{%100<...<%~%<<}\007" }
	  ;;
	  (xterm)
	    directory_prompt=""
	  ;;
	  (*)
	    directory_prompt="%{$fg[$directory_color]%}%~%{$reset_color%} "
	  ;;
	esac

	if [[ $USER == root ]]; then
	    post_prompt="%{$fg_bold[$root_color]%}%#%{$reset_color%}"
	else
	    post_prompt="%{$fg_bold[$user_color]%}%#%{$reset_color%}"
	fi

	PS1="${host_prompt} ${jobs_total}${history_total} ${directory_prompt}${error_total}${post_prompt} "


	#if [[ $TERM == screen]; then
	     #function precmd() {
		  #print -Pn "\033]0;S $TTY:t{%100<...<%~%<<}\007"
		     #}
	#elsif [[ $TERM == linux ]]; then
	    #precmd () { print -Pn "\e]0;%m: %~\a" }
	#fi

	#}}}

	#{{{ Functions

	#function vi {
		#LIMIT=$#
		#for ((i = 1; i <= $LIMIT; i++ )) do
		        #eval file="\$$i"
		        #if [[ -e $file && ! -O $file ]]
		        #then
		                #otherfile=1
		        #else

		        #fi
		#done
		#if [[ $otherfile = 1 ]]
		#then
		        #command sudo vi "$@"
		#else
		        #command vi "$@"
		#fi
	#}

	_force_rehash() {
	  (( CURRENT == 1 )) && rehash
	  return 1  # Because we didn't really complete anything
	}

	edit-command-output() {
	 BUFFER=$(eval $BUFFER)
	 CURSOR=0
	}
	zle -N edit-command-output

	#}}}

	#{{{ Testing... Testing...
	#exec 2>>(while read line; do
	#print '\e[91m'${(q)line}'\e[0m' > /dev/tty; done &)

	watch=(notme)
	LOGCHECK=0

	#}}}

	#{{{ ZSH Modules

	autoload -U compinit promptinit zcalc zsh-mime-setup
	compinit
	promptinit
	zsh-mime-setup

	#}}}

	# If set, the pattern "**" used in a pathname expansion context will
	# match all files and zero or more directories and subdirectories.
	#shopt -s globstar

	# make less more friendly for non-text input files, see lesspipe(1)
	[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

	# set variable identifying the chroot you work in (used in the prompt below)
	if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	    debian_chroot=$(cat /etc/debian_chroot)
	fi

	# set a fancy prompt (non-color, unless we know we "want" color)
	case "$TERM" in
	    xterm-color) color_prompt=yes;;
	esac

	# uncomment for a colored prompt, if the terminal has the capability; turned
	# off by default to not distract the user: the focus in a terminal window
	# should be on the output of commands, not on the prompt
	force_color_prompt=yes

	if [ -n "$force_color_prompt" ]; then
	    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	    else
		color_prompt=
	    fi
	fi

	if [ "$color_prompt" = yes ]; then
	    export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 5)\]\w\[$(tput setaf 2)\][\[$(tput setaf 6)\]\t\[$(tput setaf 2)\]]\\[$(tput setaf 2)\]\\$ \[$(tput sgr0)\]"
	else
	    export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 5)\]\w\[$(tput setaf 2)\][\[$(tput setaf 6)\]\t\[$(tput setaf 2)\]]\\[$(tput setaf 2)\]\\$ \[$(tput sgr0)\]"
	fi
	unset color_prompt force_color_prompt

	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
	    xterm*|rxvt*)
		export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 5)\]\w\[$(tput setaf 2)\][\[$(tput setaf 6)\]\t\[$(tput setaf 2)\]]\\[$(tput setaf 2)\]\\$ \[$(tput sgr0)\]"
		;;
	    *)
		;;
	esac

	# enable color support of ls and also add handy aliases
	if [ -x /usr/bin/dircolors ]; then
	    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	    alias ls='ls --color=auto'
	    alias dir='dir --color=auto'
	    alias vdir='vdir --color=auto'

	    alias grep='grep --color=auto'
	    alias fgrep='fgrep --color=auto'
	    alias egrep='egrep --color=auto'
	    ## Show hidden files ##
	    alias l.='ls -d .* --color=auto'
	    alias c='clear'
	    ## get rid of command not found ##
	    alias cd..='cd ..'
	fi

	# some more ls aliases
	alias lss='clear;ls -l'
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -CF'

	export TERM=xterm-256color

	# LB - DOOP related environment
	export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
	export DOOP_HOME=/home/anantoni/doop-nexgen/
	export DOOP_PROJECT=doop-nexgen
	export DOOP_EXTERNALS=/home/anantoni/doop-nexgen/doop-benchmarks/JREs/

	source /home/anantoni/lb-engines/logicblox-3.10.24/etc/profile.d/logicblox.sh
	alias home='cd ${HOME}'
	alias doop_home="cd ${HOME}/doop-nexgen"

	#JAVA_HOME=${HOME}/Dropbox/resources/java/jdk1.8.0_20/
	JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
	PATH=${JAVA_HOME}/bin/:${PATH}
	#GRADLE_HOME=/opt/gradle-2.4
	#MAVEN_HOME=/opt/apache-maven-3.3.3
	PATH=${PATH}:${DOOP_HOME}
	PATH=${PATH}:${MAVEN_HOME}/bin/
	PATH=${PATH}:${GRADLE_HOME}/bin/
	export JAVA_HOME
	#export JRE_HOME
	export PATH

	# some more ls aliases
	alias ll='ls -alh'
	alias la='ls -A'
	alias l='ls -CFlh'
	alias woo='fortune'
	alias lsd="ls -alF | grep /$"

	# This is GOLD for finding out what is taking so much space on your drives!
	alias diskspace="du -S | sort -n -r |more"


	# Show me the size (sorted) of only the folders in this directory
	alias dirs="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"

	# This will keep you sane when you're about to smash the keyboard again.
	alias frak="fortune"

	# This is where you put your hand rolled scripts (remember to chmod them)
	PATH="$HOME/bin:$PATH"

	## a quick way to get out of current directory ##
	alias ..='cd ..'
	alias ...='cd ../../'
	alias ....='cd ../../../'
	alias .....='cd ../../../'
	alias .4='cd ../../../../'
	alias .5='cd ../../../../..'
	alias emacsd='emacs --daemon'
	alias emacs='emacs -nw'
	alias e='emacsclient -t'
	alias ec='emacsclient -c'
	alias vim='emacsclient -t'
	alias vi='emacsclient -t'
	## Colorize the grep command output for ease of use (good for log files)##
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
	alias fgrep='fgrep --color=auto'

	alias bc='bc -l'
	alias sha1='openssl sha1'
	alias mkdir='mkdir -pv'
	alias diff='colordiff'
	alias mount='mount |column -t'

	# handy short cuts #
	alias h='history'
	alias j='jobs -l'

	alias path='echo -e ${PATH//:/\\n}'
	alias now='date +"%T'
	alias nowtime=now
	alias nowdate='date +"%d-%m-%Y"'

	alias vi=vim
	alias svi='sudo vi'
	alias vis='vim "+set si"'
	alias edit='vim'

	# Stop after sending count ECHO_REQUEST packets #
	alias ping='ping -c 5'
	# Do not wait interval 1 second, go fast #
	alias fastping='ping -c 100 -s.2'

	alias ports='netstat -tulanp'

	# do not delete / or prompt if deleting more than 3 files at a time #
	alias rm='rm -I --preserve-root'

	# confirmation #
	alias mv='mv -i'
	alias cp='cp -i'
	alias ln='ln -i'

	# Parenting changing perms on / #
	alias chown='chown --preserve-root'
	alias chmod='chmod --preserve-root'
	alias chgrp='chgrp --preserve-root'

	# distro specific  - Debian / Ubuntu and friends #
	# install with apt-get
	alias apt-get="sudo apt-get"
	alias updatey="sudo apt-get --yes"

	# update on one command
	alias update='sudo apt-get update' 
	alias upgrade='sudo apt-get update && sudo apt-get upgrade'


	# Use modern completion system
	autoload -Uz compinit
	compinit

	zstyle ':completion:*' auto-description 'specify: %d'
	zstyle ':completion:*' completer _expand _complete _correct _approximate
	zstyle ':completion:*' format 'Completing %d'
	zstyle ':completion:*' group-name ''
	zstyle ':completion:*' menu select=2
	eval "$(dircolors -b)"
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion:*' list-colors ''
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
	zstyle ':completion:*' menu select=long
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' use-compctl false
	zstyle ':completion:*' verbose true

	zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
	zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
