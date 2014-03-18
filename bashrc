######################################################################################
#   FILE: .basrhc                                                                    #
#   DESCRIPTION: Configuration file for bash                                         #
#   AUTOR: Luis Moreno Rodriguez                     last modification: 16-12-2009   #
######################################################################################

# TODO
# comentar rmnpc, rmtabs, translate_newlines, replace_strings que pasa al pasarles un solo fichero (para permitir redireccion output y poder seleccionar si sustituir el original o crear uno nuevo)
# cmpress y extract pueden ser mas cortos y mejor codificados (unificar filosofia tempfiles)
# mejorar sysinfo con awk
# Add extrachere function
# Add cmpresshere function
# Add/Correct SIGTERM support to kll
# a?adir a renamer los caracteres conflictivos ()[]
# Add autoparser para dividir .bashrc en scripts individuales

# LAST CHANGED
# actions in rmnpc, rmtabs and translate_newlines when pass only one file
# changed tempfiles management
# changed all 'echo ${f##...}' without echo 
# bug in mntiso
# mntiso and umntiso
# bad info in define and translate_word
# mkgrubiso
# translate_newlines
# bash ini for TTY's
# paquetes_instalados_pacman, paquetes_instalados_yaourt
# replace_strings
# adjustclocks
# dos2unix in translate_newlines
# mkmakefile_c
# mkgrubiso comments in code
# crackWEP
# colordiff

######################################################################################
################# EXPORTS (some are required for some functions) #####################
######################################################################################
#'locale -a' shows the LOCALES that you can select, if you want chage your locale;
# 1 - choose yours LOCALES editing locale.gen file.
# 2 - run locale-gen
# 3 - edit the next lines
#export LANG="es_ES.UTF-8"       # for spain and UTF-8 charset
#export LANG="es_ES"              # for spain and ISO-8859-1 charset
#export LC_ALL="es_ES.UTF-8"
#export LANGUAJE="es_ES"

export OOO_FORCE_DESKTOP="gnome"
export CHROMIUM_DATA="/usr/share/chromium/data/"
#export PAGER="less"

#for WIFI configuration
export COUNTRY="ES"

##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################
bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}
PROMPT_COMMAND=bash_prompt_command


######################################################################################
################################### COLOR FUNCTIONS ##################################
######################################################################################
function colorON () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Turn on bash extra colors and effects"
        return
    fi
    # Some colors and styles for echo'es
    NC='\e[0m'              # No Colorexport LESS_TERMCAP_mb=$'\E[01;31m'

    # Styles
    BOLD='\e[1m'
    UNDERLINE='\e[4m'
    BLINK='\e[5m'
    INVERSE='\e[7m'

    # Foreground colors:
    black_FG='\e[0;30m'
    red_FG='\e[0;31m'
    green_FG='\e[0;32m'
    yellow_FG='\e[0;33m' #Orange
    blue_FG='\e[0;34m'
    magenta_FG='\e[0;35m'
    cyan_FG='\e[0;36m'
    ligth_gray_FG='\e[0;37m' #Black
    default_FG='\e[0;39m'

    # Bright foreground colors:
    DARK_GRAY_FG='\e[1;30m'
    RED_FG='\e[1;31m'
    GREEN_FG='\e[1;32m'
    YELLOW_FG='\e[1;33m'
    BLUE_FG='\e[1;34m'
    MAGENTA_FG='\e[1;35m'
    CYAN_FG='\e[1;36m'
    WHITE_FG='\e[1;37m'
    DEFAULT_FG='\e[0;39m'

    # Background colors:
    black_BG='\e[40m'
    red_BG='\e[41m'
    green_BG='\e[42m'
    yellow_BG='\e[43m' #Orange
    blue_BG='\e[44m'
    magenta_BG='\e[45m'
    cyan_BG='\e[46m'
    ligth_gray_BG='\e[47m'
    default_BG='\e[49m'

    # Adjust colors for some aliases
    GREP_COLOR="always"
    LS_COLOR="auto"

    #you have installed the Perl script for colorize the gcc output?
    if which colorgcc &>/dev/null; then
        GCC="colorgcc"
    else
        if [ "$1" = "--verbose" ]; then
            echo "it seems that you not have installed 'colorgcc'; a Perl script for coloroze the gcc output"
        fi
        GCC="gcc"
    fi

    #you have installed colordiff for colorize the diff output?
    if which colordiff &>/dev/null; then
        DIFF="colordiff"
    else
        if [ "$1" = "--verbose" ]; then
            echo "it seems that you not have installed 'colordiff'; a tool for coloroze diff output"
        fi
        DIFF="diff"
    fi

    # Color for man pages
    export LESS_TERMCAP_mb=$'\E[01;31m'     # blink on = bright red (RED_FG)
    export LESS_TERMCAP_md=$'\E[01;31m'      #
    export LESS_TERMCAP_me=$'\E[0m'         # all attr off = no color
    export LESS_TERMCAP_se=$'\E[0m'         # standout off = no color
    export LESS_TERMCAP_so=$'\E[01;44;33m'  # standout on =
    export LESS_TERMCAP_ue=$'\E[0m'         # underline off = no color
    export LESS_TERMCAP_us=$'\E[01;32m'     # underline on = bright green (GREEN_FG)

    # Prompt
    NO_COLOUR="\[\033[0m\]"
    YELLOW="\[\033[1;33m\]"
    BLUE="\[\033[0;34m\]"
    WHITE="\[\033[1;37m\]"
    LIGHT_RED="\[\033[1;31m\]"
    LIGHT_GREEN="\[\033[1;32m\]"
    LIGHT_BLUE="\[\033[1;34m\]"
    LIGHT_CYAN="\[\033[1;36m\]"
    LIGHT_GRAY="\[\033[1;37m\]"

    PS1="${LIGHT_GRAY}\@ ${LIGHT_GREEN}\u${NO_COLOUR}@${LIGHT_BLUE}\h ${NO_COLOUR}:${LIGHT_RED}\w${NO_COLOUR}\\$ "
    #original# PS1="${LIGHT_GRAY}\@ ${LIGHT_GREEN}\u${NO_COLOUR}@${LIGHT_BLUE}\h ${NO_COLOUR}:${LIGHT_RED}\${NEW_PWD}${NO_COLOUR}\\$ "
#    PS1='\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;34m\]\h\[\033[00m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '
}


function colorOFF () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Turn off bash extra colors and effects"
        return
    fi
    # Define some colors and styles for echo'es
    NC=''              # No Colorexport LESS_TERMCAP_mb=$'\E[01;31m'

    # Styles
    BOLD=''
    UNDERLINE=''
    BLINK=''
    INVERSE=''

    # Foreground colors:
    black_FG=''
    red_FG=''
    green_FG=''
    yellow_FG='' #Orange
    blue_FG=''
    magenta_FG=''
    cyan_FG=''
    ligth_gray_FG='' #Black
    default_FG=''

    # Bright foreground colors:
    DARK_GRAY_FG=''
    RED_FG=''
    GREEN_FG=''
    YELLOW_FG=''
    BLUE_FG=''
    MAGENTA_FG=''
    CYAN_FG=''
    WHITE_FG=''
    DEFAULT_FG=''

    # Background colors:
    black_BG=''
    red_BG=''
    green_BG=''
    yellow_BG='' #Orange
    blue_BG=''
    magenta_BG=''
    cyan_BG=''
    ligth_gray_BG=''
    default_BG=''

    # Adjust colors for some aliases
    GREP_COLOR="never"
    LS_COLOR="never"
    GCC="gcc"
    DIFF="diff"

    # Color for man pages
    export LESS_TERMCAP_mb=$'\E[0m'
    export LESS_TERMCAP_md=$'\E[0m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[0m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[0m'

    # Prompt
    NO_COLOUR=""
    YELLOW=""
    BLUE=""
    WHITE=""
    LIGHT_RED=""
    LIGHT_GREEN=""
    LIGHT_BLUE=""
    LIGHT_CYAN=""
    LIGHT_GRAY=""

    PS1="${LIGHT_GRAY}\@${LIGHT_GREEN}\u${NO_COLOUR}@${LIGHT_BLUE}\h${NO_COLOUR}:${LIGHT_RED}\${NEW_PWD}${NO_COLOUR}\\$ "
#    PS1='\u@\h:\w\$ '
}


######################################################################################
######################################### ALIAS ######################################
######################################################################################
alias loadXterm='xrdb -load ~/.Xdefaults'
alias icequake='stjerm -k f12 -p bottom -o 80 -l 10000 -h 751 -w 1280'
alias reload='. ~/.bashrc'
alias yoigo='if [ $HOME != /root ]; then
    			echo "Debes ser root para ejecutarme"
    		else
			usb_modeswitch
			echo "Iniciando modem; espera 15 segundos..."
			sleep 15
            #modprobe usbserial vendor=0x19d2 product=0x0031
			echo "Conectando..."
			while [ `ifconfig | grep ppp0 | wc -l` != 1 ]; do
				sleep 1
			done
			sleep 5
			echo "Configurando DNS..."
			echo "# Generated by command yoigo of bashrc" > /etc/resolv.conf
			echo "nameserver 10.8.0.21" >> /etc/resolv.conf
			echo "nameserver 10.8.0.20" >> /etc/resolv.conf
		fi'
#alias xterm='xterm -vb' # disables sound bell in xterm and activate visual bell

alias mkall='./configure && make && sudo make install'
alias mkclean='rm -rfv *~ .*~'
alias duh='du -h --max-depth=1'
alias dfh='df -kTh'
alias grepn='grep -n'

# for mtk
function 2mtk() {
      cd /projects/users/sam/mtk
}

# Related with intall/unistall/update...
alias instalar='yaourt -S'
alias actualizar_paquete='instalar'
alias actualizar_todo='yaourt -Syu --aur' #--ignore amarok-base,amarok-engine-xine'
#alias reinstalar='yaourt -Sf'
#alias desinstalar='yaourt -Rs'
#alias desinstalar_purgar='yaourt -Rsn' #borra tambien los configfile (no crea pacsave files)
alias desinstalar='yaourt -Rsn'
alias buscar='yaourt -Ss'
alias info_paquete='yaourt -Qi'
alias limpiar_cache='yaourt -Sc'
alias paquetes_huerfanos='pacman -Qqdt' #instalados como dependencias pero ya no requeridos por ningun paquete
alias paquetes_instalados_pacman='pacman -Qqe | grep -v "$(pacman -Qmq)"'
alias paquetes_instalados_yaourt='pacman -Qmq'
alias paquetes_instalados='pacman -Qqe'
pkgs_depends_on() {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
		echo "Necesito el nombre de un paquete"		
		return
	fi
	if [ "$PKGS_INSTALLED" = "" ]; then
		echo -n "Calculando paquetes instalados... "
		PKGS_INSTALLED=`pacman -Qqe`
	fi
	local NUM_PKGS_INSTALLED=`echo $PKGS_INSTALLED | wc -w`
	echo -e "$NUM_PKGS_INSTALLED paquetes instalados\nRevisando cuales necesitan como dependecia a '$1'..."

	for p in $PKGS_INSTALLED; do
		echo -ne "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\bfaltan por revisar $NUM_PKGS_INSTALLED paquetes"

		local TMP=`pacman -Qi $p | grep "Depends On" | grep $1`
		if [ "$TMP" != "" ]; then local DEPENDS_ON="$DEPENDS_ON $p"; fi

		local TMP2=`pacman -Qi $p | grep "Optional Deps" | grep $1`
		if [ "$TMP2" != "" ]; then local OPTIONAL_DEPS="$OPTIONAL_DEPS $p"; fi
        
	    local NUM_PKGS_INSTALLED=`expr $NUM_PKGS_INSTALLED - 1`
	done; echo

	if [ "$DEPENDS_ON" = "" ]; then
		echo -e "\nNo se encontro ningun paquete que dependa directamente de '$1'"
	else
		echo -e "\nPaquetes que dependen directamente de '$1':\n$DEPENDS_ON"
	fi
	if [ "$OPTIONAL_DEPS" = "" ]; then
		echo -e "\nNo se encontro ningun paquete tenga como dependecia opcional a '$1'"
	else
		echo -e "\nPaquetes que tienen como dependencia opcional a '$1':\n$OPTIONAL_DEPS"
	fi
}
alias paquetes_dependiendes_de='pkgs_depends_on'


# For activate (or desactvate) color in some tools
alias gcc='$GCC'
alias diff='$DIFF'
alias ls='ls --color=$LS_COLOR'
alias grep='grep --color=$GREP_COLOR'

# Renaming programs
alias aa='asciiquarium'
alias pp='xpenguins'
alias swi-prolog='pl'
alias supercat='spc'

# Related with cd command
alias cd='mycd'
alias back='cd $OLDPWD'
alias ..='cd ..'
alias ...='cd ../..'

# ls's
alias ll='ls -lh'
alias lz='ll -S'
alias lt='ll -t'
alias l='ll -CF'
alias la='ll -a'
alias lr='ll -R'

# Operations with files and folders
alias mkdir='mkdir -p'
alias rmdir='rm -rfv'
alias cpdir='cp -rfv'
alias del='rmdir'
alias cpy='cpdir'

# Small functions
alias beep='echo -en "\x07"'
alias alarm='echo -en "\a"'
alias path='echo -e ${PATH//:/\\n}'
alias hour='while true; do clear; echo "========"; date +"%r"; echo "========"; sleep 1; done'
alias clock='cal; echo; while true; do echo -ne "\b\b\b\b\b\b\b\b\b\b\b"; echo -n `date +"%r"`; sleep 1; done'
alias ip="lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g'"
alias ropen='echo ejecting dvd reader /dev/sr1...; eject /dev/sr1'
alias wopen='echo ejecting dvd writer /dev/sr0...; eject /dev/sr0'
alias rclose='echo closing dvd reader /dev/sr1...; eject -t /dev/sr1'
alias wclose='echo closing dvd writer /dev/sr0...; eject -t /dev/sr0'
alias startvnc='vncserver -depth 16 -geometry 800x600 :1; echo Default ports: 5800 5801-web 5900 5901' #/sbin/service xfs start
alias stopvnc='vncserver -kill :1' #/sbin/service xfs stop

# Bookmarks
alias home='cd ~'
alias incoming='cd /home/luis/.aMule/Incoming'
alias autonoma='cd /home/luis/uni/autonoma'
alias luis='cd /mnt/datos/luis'
alias mis_proyectos='cd /mnt/datos/luis/mis_proyectos'
alias musica='cd /mnt/datos/musica'
alias datos='cd /mnt/datos'
alias media='cd /media'



######################################################################################
########################### VARIOUS INDEPENDENT FUNCTIONS ############################
######################################################################################
function bhelp () {
    lsvars
    lsalias #command `alias` returns the same but without color
    lsfuncs #command `declare -f` returns the same but without color
}


function lsvars () {
    echo
    echo -e "$BLUE_FG   Needed exports and variables for .bashrc file:$NC"
    echo -e "$BLUE_FG ==================================================$NC"
    echo -e "${YELLOW_FG}GREP_COLOR$NC = $GREP_COLOR"
    echo -e "${YELLOW_FG}LS_COLOR$NC = $LS_COLOR"
    echo -e "${YELLOW_FG}GCC$NC = $GCC"
    echo -e "${YELLOW_FG}HOME$NC = $HOME"
    echo -e "${YELLOW_FG}LANG$NC = $LANG"
    echo
}


function lsalias () {
    local THISFILE=$(echo $HOME/.bashrc)

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Shows the aliases declared in $THISFILE and some information about this"
        return
    fi
    echo
    echo -e "$BLUE_FG   Declared 'alias' in .bashrc file:$NC"
    echo -e "$BLUE_FG =====================================$NC"
    cat $THISFILE | grep -n 'alias' | cut -d '#' -f 1 | grep '='
    echo
    echo -e "The list shows the aliases in the same order that '$THISFILE'"
    echo
}


function lsfuncs () {
    local THISFILE=$(echo $HOME/.bashrc)

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Shows the functions availables in $THISFILE and some information about this"
        return
    fi
    echo
    echo -e "$BLUE_FG   Functions availables in .bashrc file:$NC"
    echo -e "$BLUE_FG =========================================$NC"
    cat $THISFILE | grep -n 'function' | cut -d '#' -f 1 | grep '()' | cut -d '(' -f 1
    echo -e $NC
    echo -e "The list shows the functions in the same order that '$THISFILE'. For information about especific function type $RED_FG'name_function --help'$NC or $RED_FG'name_function -h'$NC"
    echo
}
    

#function cdh () { mycd ~/$1 ; }
alias dirs='dirs -v'

function mycd () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "These mimic my previous tcsh aliases that used push, pop, dirs in place of cd. 'cdh' cd's relative to the home directory; 'mycd' acts like the normal 'cd' but maintains a stack of visited directories, which you can visit with 'mycd -' (last dir on stack), 'mycd +n' (for n an integer specifying the stack location)."
        echo -e "${RED_FG}You can define this as 'cd()' so it overrides 'cd'$NC. You can do it adding alias in bash configuration file, like this;"
        echo -e "\t alias cd='mycd'"
        echo -e "\t alias last='mycd -'"
        echo
        echo -e "The main 'mycd' function is from ${UNDERLINE}http://www.thrysoee.dk/pushd/$NC"
        echo
        echo -e "Note this requires $YELLOW_FG'seq'$NC, which is not part of OS X by default, you can get it downloading the source for coreutils, and compiling"
        return
    fi
    MAX=10
    LEN=${#DIRSTACK[@]}

    if [ $# -eq 0 ] || [ "$1" = "-" ]; then
        builtin cd "$@"
        pushd -n $OLDPWD > /dev/null
    else
        pushd "$@" > /dev/null || return 1
    fi

    if [ $LEN -gt 1 ]; then
        for i in `seq 1 $LEN`; do
            eval p=~$i
            if [ "$p" = "$PWD" ]; then
                popd -n +$i > /dev/null
                break
            fi
        done
    fi

    if [ $LEN -ge $MAX ]; then
        popd -n -0 > /dev/null
    fi
}
alias last='mycd -'


function netinfo () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Show network information"
        return
    fi
    echo -e "${RED_FG}=================== Network Information ==================$NC"
	local NET_DEVICES=`/sbin/ifconfig | cut -d ' ' -f1`
	
    for d in $NET_DEVICES; do

    	echo -en "${RED_FG}- ${d}$NC "	
    	echo -e "(`/sbin/ifconfig $d | awk /'Link encap/ {print $3}' | cut -d: -f2` type)"
        
        if [ "$d" != "lo" ]; then
    		echo -e "  HW address: `/sbin/ifconfig $d | awk /'HWaddr/ {print $5}'`"
    		echo -e "  IPv4 network" 
    		echo -e "       IP address: `/sbin/ifconfig $d | awk /'inet addr/ {print $2}' | cut -d: -f2`"
    	    echo -e "       Mask: `/sbin/ifconfig $d | awk /'Mask/ {print $4}' | cut -d: -f2`"
    	    echo -e "       Broadcast: `/sbin/ifconfig $d | awk /'Bcast/ {print $3}' | cut -d: -f2`"
    		echo -e "  IPv6 network"
    		echo -e "       IP address: `/sbin/ifconfig $d | awk /'inet6 addr/ {print $3}'`"
        else
    		echo -e "  IPv4 network" 
    		echo -e "       IP address: `/sbin/ifconfig $d | awk /'inet addr/ {print $2}' | cut -d: -f2`"
    	    echo -e "       Mask: `/sbin/ifconfig $d | awk /'Mask/ {print $3}' | cut -d: -f2`"
    		echo -e "  IPv6 network"
    		echo -e "       IP address: `/sbin/ifconfig $d | awk /'inet6 addr/ {print $3}'`"
        fi
        echo
	done

    echo -e "${RED_FG}- Internet$NC (ISP external network type)"
    if ping -c 1 checkip.dyndns.org &>/dev/null; then
        local myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
        echo -e "  ${myip}"
    else
        echo ": not conected"
    fi
    echo -ne "\n${RED_FG}NOTE:$NC You can find more information using 'ifconfig' command"
    echo 
}


function sysinfo () {
    local PASSWD_FILE=/etc/passwd
    local GROUP_FILE=/etc/group

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Show system information"
        return
    fi

    echo -e "${RED_FG}=================== System Information ====================$NC"
    echo -e "- ${RED_FG}You are logged on host:$NC $HOSTNAME"
    echo -ne "- ${RED_FG}Kernel name:$NC "; uname -s
    echo -ne "- ${RED_FG}Kernel release:$NC "; uname -r
    echo -ne "- ${RED_FG}Kernel version:$NC "; uname -v
    echo -ne "- ${RED_FG}Machine hardware name:$NC "; uname -m 
    echo -ne "- ${RED_FG}Processor:$NC "; uname -p
    echo -ne "- ${RED_FG}Hardware platform:$NC "; uname -i
    echo -ne "- ${RED_FG}OS:$NC "; uname -o
    echo -ne "- ${RED_FG}Current date:$NC "; date
    echo -ne "\n${RED_FG}Machine stats:$NC"; uptime
    echo -e "\n${RED_FG}==================== Users logged on =====================$NC "; w | tail -n 2
    echo -e "\n${RED_FG}================== Memory stats (in MB) ==================$NC "; free -m
    echo -e "\n${RED_FG}======================= Disc stats =======================$NC "; df -h
    echo -e "\n${RED_FG}==================== Users of system =====================$NC ";
    echo -e "UID\tGUID\tShell\t\tUser\t\tName\t\tHome"
#cat /etc/passwd | cut -d ':' -f1,3,4,5,6,7 | pr -t -e:20
    local USERS_INFO=`cat $PASSWD_FILE | sed s/' '/_/g `
    for u in $USERS_INFO; do
        local user=`echo $u | cut -d ':' -f 1`
        if [ ! $user ]; then user="             "; fi
        local uid=`echo $u | cut -d ':' -f 3`
        local guid=`echo $u | cut -d ':' -f 4`
        local name=`echo $u | cut -d ':' -f 5`
        if [ ! $name ]; then name="              "; fi
        local home=`echo $u | cut -d ':' -f 6`
        local shell=`echo $u | cut -d ':' -f 7`
        if [ ! $shell ]; then shell="             "; fi
        echo -e "$uid\t$guid\t$shell\t$user\t\t$name\t\t$home"
    done
    echo -e "\n${RED_FG}==================== Groups of system ====================$NC ";
    echo -e "GUID\tGroup\t\tUsers"
#cat /etc/group | cut -d ':' -f1,3,4 | pr -t -e:16
    local GROUPS_INFO=`cat $GROUP_FILE` # | sed s/' '/_/g `
    for g in $GROUPS_INFO; do
        local group=`echo $g | cut -d ':' -f 1`
        local guid=`echo $g | cut -d ':' -f 3`
        local users=`echo $g | cut -d ':' -f 4`
        echo -e "$guid\t$group\t\t$users"
    done
    echo -ne "\n${RED_FG}NOTE:$NC You can find more information in the files directory /etc; "
    echo "sudoers, exports, fstab, shadow, host.*, protocols, services, etc."
    echo "Usefull commands to show system info: hwdetect, procinfo (-a), lsof, ps (aux), top, netstat (-tunep)"
    echo "Usefull commands to manage users an groups: passwd, user*, group*"
}


function adjustclocks () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Adjust and synchronize the system clock's; clock of date (and hwclock if you have installed). Usage ${RED_FG}'adjustclocks'$NC"
        return
    fi
	local TEMP_FILE="/tmp/deleteme.$$"

    # If the adjtime file /etc/adjtime doesn't exist, the default is local time
    if [ ! -f /etc/adjtime ]; then
        local FLAG="--localtime"
    else    
        local FLAG="--utc"
    fi

    # Fetch time and date from internet
    if [ $FLAG = "--localtime" ]; then
        local COUNTRY_CODE="/n141" #for Spain (Madrid)
    else
        local COUNTRY_CODE="" #for UTC country code doesn't needed 
    fi
    lynx -accept_all_cookies -dump -nolist -hiddenlinks=ignore -nonumbers http://free.timeanddate.com/clock/i1s3w5hl${COUNTRY_CODE}/tt0/tw0/tm2/td1/th1/tb2 > $TEMP_FILE

    if [ ! -s $TEMP_FILE ]; then
        echo "Error fetching time and date from internet.'$1'"
        rm -f $TEMP_FILE
        echo "To adjust de date and time type it with \"MM/DD/YY HH:MM:SS\" and 24HRS format"
        echo "For example,  9/22/96 16:45:05"
        read NEW_DATE
    else
        echo "Synchronizing from internet..."
        local NEW_DATE=`cat $TEMP_FILE`
    fi
    rm -f $TEMP_FILE

    # Adjust clocks
    if which hwclock &>/dev/null; then
        hwclock $FLAG --set --date="$NEW_DATE"
        hwclock $FLAG --hctosys
    else
        date "+%D %T" --set "$NEW_DATE"
    fi
}


function crackWEP () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Crack Wifi WEB encryption. Usage ${RED_FG}'crackWEP device'$NC"
        echo "device is the active device network. It must be like eth0, eth1, wlan0, ath0..."
        return
    fi
    if [ $USER != "root" ] && [ $HOME != "/root" ]; then
        echo "You must be root to run me."
        return
    fi
    local DEV=$1
    local MONITOR_DEV="mon0"

    if ! ifconfig $DEV &>/dev/null; then
        echo "The device '$DEV' doesn't exists. Use 'ifconfig' to view all devices."
        return
    fi

    echo "To continue and view all WIFI nets press any key"
    read 
    iwlist $DEV scan | grep Address -A 6
    echo -n "select the ESSID to crack (see WIFI list below): "
    read ESSID
    echo -n "type the CHANNEL of selected ESSID '$ESSID' (see WIFI list below): "
    read CHANNEL
    echo "The selected CHANNEL is '$CHANNEL' and ESSID is '$ESSID', press any key to continue"
    read
    echo "Swiching to monitor mode..."
    airmon-ng start $DEV
    echo "To start the capture of packets press enter. When you have enough packets press 'Ctrl+C' to break the capture and start decodification of WEB password"  
    read
    echo "Capturing packages and saving in current directory in ivs files..."
    sleep 2
    airodump-ng -w "$ESSID" -c $CHANNEL $MONITOR_DEV #-i
    echo "Stopping monitor mode..."
    airmon-ng stop $DEV
    echo "Decoding to discover WEP password..."
    aircrack-ng *.ivs
}


function define () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Fetch word definition from google. Usage ${RED_FG}'define word'$NC"
        return
    fi
	local TEMP_FILE="/tmp/deleteme.$$"

    local LNG=`echo "$LANG" | cut -d '_' -f 1`
    local CHARSET=`echo $LANG | cut -d '.' -f 2` #usefull if charset is unicode

    lynx -accept_all_cookies -dump -hiddenlinks=ignore -nonumbers -assume_charset="$CHARSET" -display_charset="$CHARSET" "http://www.google.com/search?hl=$LNG&q=define%3A+${1}&btnG=Google+Search"| grep -m 5 -C 2 -A 5 -w "*" > $TEMP_FILE

    if [ ! -s $TEMP_FILE ]; then
        echo "No definition for '$1'"
    else
        cat $TEMP_FILE
    fi
    rm -f $TEMP_FILE
}


function translate_word () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Fetch word translation from google. Usage ${RED_FG}'translate_word word'$NC"
        return
    fi
	local TEMP_FILE="/tmp/deleteme.$$"

    echo "********************************************************"
    echo " Choose the direction for translate '$1'"
    echo "********************************************************"
    echo " 0 - spanish to english"
    echo " 1 - english to spanish"
    echo " [Other] EXIT"
    echo "********************************************************"
    echo -n "Enter your menu choice: "
    read OPTION

    local SRC=en
    local DST=es
    case $OPTION in
    0)       SRC=es; DST=en;;
    1)       SRC=en; DST=es;;
    *)       echo "Exit"; return;;
    esac
    local LNG=`echo "$LANG" | cut -d '_' -f 1`
    local CHARSET=`echo $LANG | cut -d '.' -f 2` #usefull if charset is unicode

    lynx -accept_all_cookies -dump -hiddenlinks=ignore -nonumbers -assume_charset=$CHARSET -display_charset=$CHARSET "http://www.google.com/dictionary?aq=f&langpair=${SRC}|${DST}&q=${1}&hl=$LNG"| grep -C 2 -A 5 -w "*" > /$TEMP_FILE

    if [ ! -s $TEMP_FILE ]; then
        echo "No translation for '$1'"
    else
        cat $TEMP_FILE
    fi
    rm -f $TEMP_FILE
}


function mkgrubiso () {
    #the GRUB bootable CD-ROM
    local ISO="$HOME/GRUB.iso"  

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Make a GRUB/GRUB2/GRUB-GFX bootable CD-ROM iso image in your home directory. If you are using GRUB or GRUB-GFX this script add more rescue options in iso file like memtest+, x86test and the possibility to change keyboard layout. Usage ${RED_FG}'mkgrubiso'$NC"
        return
    fi

    #temp folder to copy the content GRUB bootable CD-ROM
    local ISO_CONTENT="/tmp/deleteme_grubiso"

    # Search and copy GRUB file to boot from CDROM
    echo "Compiling needed GRUB files.."
    if [ -f /usr/lib/grub/i386-pc/stage2_eltorito ]; then
        local ELTORITO="/usr/lib/grub/i386-pc/stage2_eltorito"
    else   
        local ELTORITO=`locate stage2_eltorito | grep grub | head -n 1`
        if [ "$ELTORITO" = "" ] || [ ! -f "$ELTORITO" ]; then
            echo -e "${RED_FG}ERROR!$NC the file 'stage2_eltorito' not found"
            echo "Check that you have installed GRUB, GRUB2 or GRUB-GFX and update your DB files with 'updatedb'"
            return
        fi
    fi

    mkdir $ISO_CONTENT
    mkdir -p $ISO_CONTENT/boot/grub
    cp -v $ELTORITO $ISO_CONTENT/boot/grub

    # Search and copy GRUB configfile
    if [ -f /boot/grub/menu.lst ]; then
        local MENU="/boot/grub/menu.lst"
        cp -v $MENU $ISO_CONTENT/boot/grub
    else    
        if [ -f /boot/grub/grub.cfg ]; then
            local MENU="/boot/grub/grub.cfg"
            cp -v $MENU $ISO_CONTENT/boot/grub
        else
            local MENU=`locate menu.lst | grep grub | head -n 1`
            if [ "$MENU" != "" ] && [ -f "$MENU" ]; then
                cp -v $MENU $ISO_CONTENT/boot/grub
            else
                local MENU=`locate grub.cfg | grep grub | head -n 1`
                if [ "$MENU" != "" ] && [ -f "$MENU" ]; then
                    cp -v $MENU $ISO_CONTENT/boot/grub
                else
                    echo -e "${YELLOW_FG}WARNING${NC}: not found menu config for GRUB. Not found 'menu.lst' or 'grub.cnf' files."
                fi
            fi
        fi            
    fi

    # In case that you are using GRUB or GRUB-GFX, add more rescue options
    if [ "$MENU" != "" ] && [ -f "$MENU" ] && [ "${MENU##*/}" = "menu.lst" ]; then
        # Add "reinstall GRUB option" in GRUB configfile

        # First adjust the number of root device that contains GRUB files        
        #local DEVICE=`cat /etc/mtab | grep " / " | cut -d ' ' -f 1` #DON'T WORK, fails in DEVICE_NUM
        local DEVICE=`df / | grep /dev | cut -d ' ' -f 1`
        DEVICE=${DEVICE##*/}  #Necesary to avoid posible problems with character for colorize bash output
                              #"grep --color=never" can also be used to avoid color problems
        local DEVICE_NUM=${DEVICE##*[a-z]} # delete from right to the first character diferent of a to z
        #local DEVICE_NUM=${DEVICE#${DEVICE%?}}  #extract the last character
        local GRUB_PARTITION=`expr $DEVICE_NUM - 1`

        # Second adjust the number of drive
        local DEVICE_HD=${DEVICE%%[0-9]*} # delete from left to the first character diferent of 0 to 9
        DEVICE_HD=${DEVICE_HD#${DEVICE_HD%?}}  #extract the last character
        case $DEVICE_HD in
            a)     local GRUB_HD="0";;
            b)     local GRUB_HD="1";;
            c)     local GRUB_HD="2";;
            d)     local GRUB_HD="3";;
            e)     local GRUB_HD="4";;
            f)     local GRUB_HD="5";;
            g)     local GRUB_HD="6";;
            h)     local GRUB_HD="7";;
            i)     local GRUB_HD="8";;
            j)     local GRUB_HD="9";;
            *)     local GRUB_HD="0";;
        esac
        # Add "reinstall GRUB option"
        echo -e "\ntitle Install GRUB to hd0 MBR" >> $ISO_CONTENT/boot/grub/menu.lst
        echo "root (hd${GRUB_HD},${GRUB_PARTITION})" >> $ISO_CONTENT/boot/grub/menu.lst
        echo "setup (hd0)" >> $ISO_CONTENT/boot/grub/menu.lst

        # Add "x86test GRUB option" and "memtest86+ GRUB option"
        echo -e "\nGetting memtest86+ and x86test for extra GRUB menu options..."
        if ping -c 1 www.google.com &>/dev/null; then
            
            local MEMTEST86_LINK="http://www.memtest.org/download/4.00/memtest86+-4.00.bin"

            if wget -O - $MEMTEST86_LINK > $ISO_CONTENT/boot/${MEMTEST86_LINK##*/}; then
                echo -e "\ntitle Run memtest86+ (Memory Testing)" >> $ISO_CONTENT/boot/grub/menu.lst
                echo "kernel /boot/${MEMTEST86_LINK##*/}" >> $ISO_CONTENT/boot/grub/menu.lst
            else
                echo "NOTE: I can't download 'memtest86+' to add option in GRUB menu because the link is broken."
            fi
        fi

        # Add "keyboard layout GRUB option"
        echo -e "\ntitle GRUB keyboard config..." >> $ISO_CONTENT/boot/grub/menu.lst
        echo "configfile /boot/grub/keyboards.lst" >> $ISO_CONTENT/boot/grub/menu.lst

        # Generate keyboard.lst
        local SPLASHIMAGE_LINE=`cat $ISO_CONTENT/boot/grub/menu.lst | grep --color=never splashimage | head -n 1`
        local COLORS_LINE=`cat $ISO_CONTENT/boot/grub/menu.lst | grep --color=never color | head -n 1`

        echo -e "${SPLASHIMAGE_LINE}\n${COLORS_LINE}" >> $ISO_CONTENT/boot/grub/keyboards.lst
        echo -e "#keyboard layouts - ganked from SGD ( http://freshmeat.net/projects/supergrub/?branch_id=62132&release_id=236631 )\n# TODO add other languages\ntimeout 300\ndefault 0\n\ntitle << Back to main menu\nconfigfile /boot/grub/menu.lst\n\ntitle Default layout\nsetkey\n\ntitle Dvorak layout\nsetkey bracketleft minus\nsetkey braceleft underscore\nsetkey bracketright equal\nsetkey braceright plus\nsetkey quote q\nsetkey doublequote Q\nsetkey comma w\nsetkey less W\nsetkey period e\nsetkey greater E\nsetkey p r\nsetkey P R\nsetkey y t\nsetkey Y T\nsetkey f y\nsetkey F Y\nsetkey g u\nsetkey G U\nsetkey c i\nsetkey C I\nsetkey r o\nsetkey R O\nsetkey l p\nsetkey L P\nsetkey slash bracketleft\nsetkey question braceleft\nsetkey equal bracketright\nsetkey plus braceright\nsetkey o s\nsetkey O S\nsetkey e d\nsetkey E D\nsetkey u f\nsetkey U F\nsetkey i g\nsetkey I G\nsetkey d h\nsetkey D H\nsetkey h j\nsetkey H J\nsetkey t k\nsetkey T K\nsetkey n l\nsetkey N L\nsetkey s semicolon\nsetkey S colon\nsetkey minus quote\nsetkey underscore doublequote\nsetkey semicolon z\nsetkey colon Z\nsetkey q x\nsetkey Q X\nsetkey j c\nsetkey J C\nsetkey k v\nsetkey K V\nsetkey x b\nsetkey X B\nsetkey b n\nsetkey B N\nsetkey w comma\nsetkey W less\nsetkey v period\nsetkey V greater\nsetkey z slash\nsetkey Z question\n\ntitle German layout\nsetkey y z\nsetkey z y\nsetkey Y Z\nsetkey Z Y\nsetkey equal parenright\nsetkey parenright parenleft\nsetkey parenleft asterisk \nsetkey doublequote at\nsetkey plus bracketright\nsetkey minus slash\nsetkey slash ampersand\nsetkey ampersand percent\nsetkey percent caret\nsetkey underscore question\nsetkey question underscore\nsetkey semicolon less\nsetkey less numbersign\nsetkey numbersign backslash\nsetkey colon greater\nsetkey greater bar\nsetkey asterisk braceright  \n\n\ntitle Spanish layout\nsetkey\nsetkey slash ampersand\nsetkey ampersand caret\nsetkey caret braceleft\nsetkey asterisk braceright\nsetkey parenleft asterisk\nsetkey parenright parenleft\nsetkey minus slash\nsetkey equal parenright\nsetkey quote minus\nsetkey underscore question\nsetkey question underscore\nsetkey braceleft quote\nsetkey braceright backslash\nsetkey colon greater\nsetkey greater bar\nsetkey doublequote at\nsetkey backslash backquote\nsetkey less backslash\nsetkey semicolon less\nsetkey plus colon\nsetkey at semicolon\n\ntitle French layout\nsetkey\nsetkey less backquote\nsetkey greater tilde\nsetkey ampersand 1\nsetkey 1 exclam\nsetkey tilde 2\nsetkey 2 at\nsetkey doublequote 3\nsetkey 3 numbersign\nsetkey quote 4\nsetkey 4 dollar\nsetkey parenleft 5\nsetkey 5 percent\nsetkey minus 6\nsetkey 6 caret\nsetkey backquote 7\nsetkey 7 ampersand\nsetkey underscore 8\nsetkey 8 asterisk\nsetkey backslash 9\nsetkey 9 parenleft\nsetkey at 0\nsetkey 0 parenright\nsetkey parenright minus\nsetkey numbersign underscore\nsetkey a q\nsetkey A Q\nsetkey z w\nsetkey Z W\nsetkey caret bracketleft\nsetkey dollar bracketright\nsetkey q a\nsetkey Q A\nsetkey m semicolon\nsetkey M colon\nsetkey bracketleft quote \nsetkey percent doublequote\nsetkey asterisk backslash\nsetkey bracketright bar\nsetkey w z\nsetkey W Z\nsetkey comma m\nsetkey question M\nsetkey semicolon comma\nsetkey period less\nsetkey colon period\nsetkey slash greater\nsetkey exclam slash\nsetkey bar question\n" >> $ISO_CONTENT/boot/grub/keyboards.lst
    fi    

    # Add "reboot PC option"
    echo -e "\ntitle Reboot" >> $ISO_CONTENT/boot/grub/menu.lst
    echo "reboot" >> $ISO_CONTENT/boot/grub/menu.lst

    # Add "shutdown PC option"
    echo -e "\ntitle Shutdown" >> $ISO_CONTENT/boot/grub/menu.lst
    echo "halt --no-apm" >> $ISO_CONTENT/boot/grub/menu.lst

    echo -e "\nMaking a bootable GRUB ISO file in $ISO..."
    mkisofs -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table -o $ISO $ISO_CONTENT
    #-boot-load-size 4 bit is required for compatibility with the BIOS on many older machines.

    rm -rf $ISO_CONTENT
    echo -e "\nThe GRUB iso has been generated in '$ISO'"
    echo -n "You want burn it now? [y]es [N]o: "
    read OPTION
    case $OPTION in
        Y|y)    echo "Insert empty CDROM and press enter"; read
                if ! cdrecord -v speed=4 -data $ISO; then
                    echo -e "${RED_FG}ERROR!$NC check CD-ROM"
                fi;;
    esac    
}


function toiso () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Converts raw, bin, cue, ccd, img, mdf, nrg cd/dvd image files to ISO image file. Usage ${RED_FG}'toiso file1 file2...'$NC"
    fi
    for i in $*; do
        if [ ! -f "$i" ]; then
            echo "'$i' is not a valid file; jumping it"
        else
            local ERROR_EXTENSION=0
            echo -n "converting $i... "
            OUT=`echo $i | cut -d '.' -f 1`

            case $i in
            *.raw)              bchunk -v $i $OUT.iso;; #raw=bin #*.cue #*.bin
            *.bin|*.cue)        bin2iso $i $OUT.iso;;
            *.ccd|*.img)        ccd2iso $i $OUT.iso;; #Clone CD images
            *.mdf)              mdf2iso $i $OUT.iso;; #Alcohol images
            *.nrg)              nrg2iso $i $OUT.iso;; #nero images
            *)                  ERROR_EXTENSION=1;;
            esac

            if [ $? != 0 ] || [ $ERROR_EXTENSION -eq 1 ]; then
                echo -e "${RED_FG}ERROR!$NC"
                if [ $ERROR_EXTENSION -eq 1 ]; then echo "toiso don't know de extension of '$i'"; fi
            else
                echo -e "${GREEN_FG}done!$NC"
            fi
        fi
    done
}


function mntiso () {
    # path where all iso files are mounted in diferent folders
    local MOUNT_DIR=$HOME/mounted_ISO

    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Mount ISO files using /dev/loop's devices. All files are mounted in $MOUNT_DIR, in diferent folders with the names of iso files. Supports relative and absolute paths. Usage ${RED_FG}'mntiso isofile1 isofile2...'$NC"
        return
    fi

    for F in $*; do
        if [ ! -f "$F" ]; then echo "$F is not valid file"; fi
    done

    if ! lsmod | grep loop &>/dev/null; then
        echo "The loop module is not loaded, to load type 'modprobe loop'"; return
    fi

    if [ ! -d $MOUNT_DIR ]; then mkdir $MOUNT_DIR; fi

    # delete residual folders of old and not mounted ISO files
    MOUNT_POINTS=`ls $MOUNT_DIR/`
    for i in $MOUNT_POINTS; do
#debo mirar si no esta en mtab, no si esta vacio
        if [ -d $MOUNT_DIR/$i ] && [ `ls $MOUNT_DIR/$i | wc -l` -eq 0 ]; then rm -rf $MOUNT_DIR/$i; fi
    done

    local MAX_MOUNTS=`ls /dev/loop? | wc -l`
    local NUM_MOUNTED=`cat /etc/mtab | grep /dev/loop | wc -l`

    # loop; diferent ISOs
    for F in $*; do
        if [ $NUM_MOUNTED -eq $MAX_MOUNTS ]; then
            echo -e "You can't mount more ISO files. You need umount some ISO; there are mounted $NUM_MOUNTED ISO files and the maximum allowed is $MAX_MOUNTS"; return
        fi

        local ISO=${F##*/} # the iso file to mount; without path
        local MOUNT_POINT=$MOUNT_DIR/${ISO%.*} #without .iso extension

        # loop; probe with all loops devices; /dev/loop0 /dev/loop1 ..... /dev/loopN
        for d in `ls /dev/loop?`; do

            # if device is not in use
            if ! cat /etc/mtab | grep $d &>/dev/null; then

                echo -ne "\nmounting $ISO using $d device... "
                mkdir -p ${MOUNT_POINT}_${d##*/}
            
                if mount -o ro,loop=$d -t iso9660 $F ${MOUNT_POINT}_${d##*/}; then
                    echo -e "${GREEN_FG}done!$NC\nfor unmount type 'umount ${MOUNT_POINT}_${d##*/}'"
                    NUM_MOUNTED=`expr $NUM_MOUNTED + 1`
                else
                    rm -rf ${MOUNT_POINT}_${d##*/}
                    echo -e "${RED_FG}ERROR!$NC"
                fi
                break
            fi
        done
    done
}


function umntiso () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Dialog for umount any /dev/loop's devices. Usage ${RED_FG}'umntiso'$NC"
        return
    fi

#    if ! lsmod | grep loop &>/dev/null; then
#        echo "The loop module is not loaded, to load type 'modprobe loop'"; return
#    fi

    local NUM_MOUNTED=`cat /etc/mtab | grep /dev/loop | wc -l`
    if [ $NUM_MOUNTED -eq 0 ]; then echo "no found ISO files mounted"; return; fi

    local MOUNT_POINTS=`cat /etc/mtab | grep /dev/loop | cut -d ' ' -f 2`
    echo -e "********** Select the ISOs to umount **********\n"
    for i in $MOUNT_POINTS; do

        echo "Umount $i?"
        echo -n "[a]ll yes, [y]es, [N]o: "
        read OPTION

        case $OPTION in
        Y|y)    echo -ne "umounting $i... "
                if ! umount $i; then echo -e "${RED_FG}ERROR!$NC\n";
                else echo -e "${GREEN_FG}done!$NC\n"; rm -rf $i; 
                fi;;

        A|a)    MOUNT_POINTS=`cat /etc/mtab | grep /dev/loop | cut  -d ' ' -f 2`
                for i in $MOUNT_POINTS; do
                    echo -ne "umounting $i... "
                    if ! umount $i; then echo -e "${RED_FG}ERROR!$NC\n";
                    else echo -e "${GREEN_FG}done!$NC\n"; rm -rf $i; 
                    fi
                done
                break;;

        *)      echo;;
        esac
    done
}


function screenshot () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Takes a screenshot of selected area"
        return
    fi
    local IMAGE=`echo $HOME/$(date +%s).png`
    echo "Select screen area to take a shot."

    if import -frame -strip -quality 75 $IMAGE; then
        echo "screenshot saved in $IMAGE"
    else
        echo -e "${RED_FG}ERROR!$NC"
    fi
}


function backup () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Back up a file or folder in tgz compressed file. Supports relative and absolute paths. Usage ${RED_FG}'backup file'$NC or ${RED_FG}'backup folder'$NC"
        return
    fi
    if [ ! -d "$1" ] && [ ! -f "$1" ]; then echo "$1 is not a valid file or folder"
        return
    fi

    local F=$1
    if [ -d "$F" ]; then
        local F=${F%/} # delete de last character if it is '/'
    fi

    local ITEM=${F##*/} # the file or folder to comress
    local DIR=${F%/*} # the path of the file or folder to compress

    # if de file is not in the actual path
    if [ "$ITEM" != "$DIR" ]; then
        local OLD_PATH=`pwd`
        cd $DIR
    fi

    local EXTENSION=$(date +%Y%m%d-%H%M).tgz
    echo -n "saving backup of '$ITEM' in `pwd`/${ITEM}_$EXTENSION... "
    tar -czf ${ITEM}_$EXTENSION --recursion $ITEM

    if [ $? != 0 ]; then
        echo -e "${RED_FG}ERROR!$NC"
    else
        echo -e "${GREEN_FG}done!$NC"
    fi
    if [ "$ITEM" != "$DIR" ]; then cd $OLD_PATH; fi
}


function cmpress () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Compress files and/or folders in severals formats. Supports relative and absolute paths. Usage ${RED_FG}'cmpress files_and_folders'$NC example ${RED_FG}'cmpress file1 folder folder2 file2...'$NC."
        return
    fi

    for F in $*; do
        if [ ! -f "$F" ] && [ ! -d "$F" ]; then echo "$F is not a valid file or folder"
            return
        fi
    done

    # recieved one file or folder to compress
    if [ $# -eq 1 ]; then
        local F=$1
        if [ -d "$F" ]; then
            local F=${F%/} # delete de last character if it is '/'
        fi

        local ITEM=${F##*/} # the file or folder to comress
        local DIR=${F%/*} # the path of the file or folder to compress

        # if de file is not in the actual path
        if [ "$ITEM" != "$DIR" ]; then
            local OLD_PATH=`pwd`
            cd $DIR
        fi
    else
        # copy all items in a temp folder in actual path
        echo "You want compress multiple elements, write a name for compressed file (without extension)"
        read ITEM
        while ls $ITEM &>/dev/null; do
            echo "There are one element with this name in working directory"
            echo -n "Choose other name: "
            read ITEM
        done
        local DIR="$ITEM" # avoid 'cd $OLD_PATH' actions
        mkdir $ITEM
        for F in $*; do cp -rf $F $ITEM; done # copy all items
    fi

    echo "********************************************************"
    echo " Choose the format to compress '$ITEM'"
    echo "********************************************************"
    echo " 0 .rar"
    echo " 1 .zip"
    echo " 2 .bz2 (only for one file, not folders or several elements)"
    echo " 3 .gz (only for one file, not folders or several elements)"
    echo " 4 .tar"
    echo " 5 .tbz"
    echo " 6 .tgz"
    echo " 7 .7z"
    echo " 8 .arj"
    echo " 9 .lha"
    echo " [Other] EXIT"
    echo "********************************************************"
    echo -n "Enter your menu choice: "
    read OPTION

    if expr index "`seq 0 9`" "$OPTION" 1>/dev/null; then

        if [ -d "$ITEM" ] && [ $OPTION -eq 2 -o $OPTION -eq 3 ]; then
            echo "You can't compress folders or severals elements in this format"
            if [ $# -gt 1 ]; then rm -rf $ITEM; fi  # delete temp folder, used to compress multiple items
            if [ "$ITEM" != "$DIR" ]; then cd $OLD_PATH; fi
            return
        fi
        echo -n "compressing in file `pwd`/$ITEM"
    else
        if [ $# -gt 1 ]; then rm -rf $ITEM; fi  # delete temp folder, used to compress multiple items
        if [ "$ITEM" != "$DIR" ]; then cd $OLD_PATH; fi
        echo "Exit"; return
    fi

    case $OPTION in
    0)      echo -n ".rar... "; rar a -ru $ITEM.rar $ITEM &>/dev/null;;
    1)      echo -n ".zip... "; zip -r $ITEM.zip $ITEM &>/dev/null;;
    2)      echo -n ".bz2... "; bzip2 -zf $ITEM &>/dev/null;;
    3)      echo -n ".gz... "; gzip -f $ITEM &>/dev/null;;
    4)      echo -n ".tar... "; tar -cf $ITEM.tar $ITEM &>/dev/null;;
    5)      echo -n ".tbz... "; tar -cjf $ITEM.tbz --recursion $ITEM &>/dev/null;;
    6)      echo -n ".tgz... "; tar -czf $ITEM.tgz --recursion $ITEM &>/dev/null;;
    7)      echo -n ".7z... "; 7z a -r $ITEM.7z $ITEM &>/dev/null;;
    8)      echo -n ".arj... "; arj a -r $ITEM.arj $ITEM &>/dev/null;;
    9)      echo -n ".lha... "; lha -a $ITEM.lha $ITEM &>/dev/null;;
    esac

    if [ $? != 0 ]; then
        echo -e "${RED_FG}ERROR!$NC\n"
    else
        echo -e "${GREEN_FG}done!$NC\n"
    fi
    if [ $# -gt 1 ]; then rm -rf $ITEM; fi  # delete temp folder, used to compress multiple items
    if [ "$ITEM" != "$DIR" ]; then cd $OLD_PATH; fi
}


function extract () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Extract compressed files. If the contents of the file are several elements, it will be extract in folder with the name of file and the suffix '_FILES'. Supports relative and absolute paths. Usage ${RED_FG}'extract file1 file2...'$NC"
        return
    fi

    for F in $*; do
        if [ ! -f "$F" ]; then echo "$F is not a valid compressed file"
            return
        fi
    done

    for F in $*; do
        local ITEM=${F##*/} # the file to extract
        local DIR=${F%/*} # path of the file to extract

        # if de file is not in the actual path
        if [ "$ITEM" != "$DIR" ]; then
            local OLD_PATH=`pwd`
            cd $DIR
        fi

        mkdir ${ITEM}_FILES     #folder where files are extracted
        local ERROR_EXTENSION=0 #FLAG to marks files that not have valid extension
        local RET=0             #the return of the extract command (default 0; no ERROR, OK)

        echo -n "extracting '`pwd`/$ITEM'... "
        case $ITEM in
	    *.iso|*.ISO)
            
            local TEMP_DIR=/tmp/deleteme_extract.$$
            mkdir $TEMP_DIR

            if mount -o loop -t iso9660 $ITEM $TEMP_DIR; then
                cp -rf $TEMP_DIR/* ${ITEM}_FILES
                umount $TEMP_DIR
            else
                RET=1
            fi
            rm -rf $TEMP_DIR;;
            
	    *)
            cd ${ITEM}_FILES
            
            case $ITEM in
            *.arj|*.ARJ)           arj x -y ../$ITEM &>/dev/null;; # unarj
            *.lha|*.LHA)           lha -x ../$ITEM &>/dev/null;;
            *.rar|*.RAR)           unrar x ../$ITEM &>/dev/null;; # rar x 
            *.ace|*.ACE)           unace x ../$ITEM &>/dev/null;; 
            *.zip|*.ZIP)           unzip ../$ITEM &>/dev/null;;
            *.tar|*.TAR)           tar -xf ../$ITEM &>/dev/null;; 
            *.tar.bz2|*.TAR.BZ2)   tar -xjf ../$ITEM &>/dev/null;; 
            *.tbz|*.TBZ)           tar -xjf ../$ITEM &>/dev/null;; 
            *.tbz2|*.TBZ2)         tar -xjf ../$ITEM &>/dev/null;; 
            *.tar.gz|*.TAR.GZ)     tar -xzf ../$ITEM &>/dev/null;; 
            *.tgz|*.TGZ)           tar -xzf ../$ITEM &>/dev/null;; 
            *.bz2|*.BZ2)           bunzip2 -f ../$ITEM &>/dev/null;;  #bunzip2 or bzip2 -d
            *.gz|*.GZ)             gunzip -f ../$ITEM &>/dev/null;; 
            *.Z|*.z)               uncompress -f ../$ITEM &>/dev/null;; 
            *.7z|*.7Z)             7z x ../$ITEM &>/dev/null;;
            *)   ERROR_EXTENSION=1;;
            esac
        
            local RET=$?
            cd ..
        esac
            
        if [ $RET != 0 ] || [ $ERROR_EXTENSION -eq 1 ]; then
            rm -rf ${ITEM}_FILES     # delete folder

            if [ $ERROR_EXTENSION -eq 1 ]; then
                echo -e "${RED_FG}ERROR!$NC\nextract don't know de extension of $ITEM\n"
            else
                echo -e "${RED_FG}ERROR!$NC\nThe file $ITEM is not a valid '.${F##*.}' file, or other error ocurred (see below).\n"
            fi
        else
            # looks if the content is one or more files
            if [ `ls ${ITEM}_FILES | wc -w` -eq 1 ]; then
                local EXTRACT_PATH=`pwd`/`ls ${ITEM}_FILES`
                cp -rf ${ITEM}_FILES/* ./
                rm -rf ${ITEM}_FILES
            else
                local EXTRACT_PATH=`pwd`/${ITEM}_FILES
            fi
            echo -e "${GREEN_FG}done!$NC\nall files extracted in $EXTRACT_PATH\n"
        fi
        if [ "$ITEM" != "$DIR" ]; then cd $OLD_PATH; fi
    done

    if [ "$ITEM" != "$DIR" ] && [ -d "$EXTRACT_PATH" ] &&  [ $# -eq 1 ]; then
        echo -n "You want to go to the directory that contains the extracted files? [y]es [N]o: "
        read OPTION
        case $OPTION in
        Y|y)    cd $EXTRACT_PATH;;
        esac
    fi
}


function resize_images () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Resize images. Usage ${RED_FG}'resize_images image1 image2...'$NC"
        return
    fi
	echo "Write new width value (in pixels)" # ancho
	read WIDTH
	echo "Write new height value (in pixels)" # alto
	read HEIGHT
    for i in $*; do
		if [ -f $i ]; then
			local IMAGE_NAME=${i%/*}  # path of the image file
			local IMAGE_TYPE=${i##*.}  # file extension
			echo -n "Resizing '$i' in '${IMAGE_NAME}_resized.$IMAGE_TYPE'... "
			if convert $i -scale ${WIDTH}x${HEIGHT} ${IMAGE_NAME}_resized.$IMAGE_TYPE; then
                echo -e "${GREEN_FG}done!$NC"
			fi
		else
			echo "'$i' is not a valid file; jumping it"
		fi
	done;
}


calculate_dependencies2 () {
    local MAIN_DEPS=""
    local SRC_REVISED=""

    calculate_dependencies () {
        # source file doesn't exists
        if [ ! -f $1 ]; then return; fi

        # source file had been revised
        for SRC_FILE in $SRC_REVISED; do
            if [ "$1" = "$SRC_FILE" ]; then return; fi
        done

        local NEW_DEPS=`grep --color=never "#include \"" "$1" | cut -d \" -f 2 | cut -d . -f 1`
        MAIN_DEPS="$MAIN_DEPS $NEW_DEPS"
        SRC_REVISED="$SRC_REVISED $1"

        for dep in $MAIN_DEPS; do
            if [ -f "$dep.c" ] && [ -f "$dep.h" ]; then
                # A dependency of the main program is an object, and to 
                # compile one object we need source file (dep.c) and header (dep.h).
                calculate_dependencies "$dep.c"
                calculate_dependencies "$dep.h"
            fi
        done;
    }
    calculate_dependencies $1

    remove_duplicates () {
        local RET=""
        for i in $1; do
            # add first element
            if [ "$RET" = "" ]; then 
                RET=$i
            else
                # add ohters elements
                local REPEAT_ITEM=0
                for j in $RET; do
                    if [ "$i" = "$j" ]; then REPEAT_ITEM="1"; break; fi
                done
                if [ "$REPEAT_ITEM" -eq 0 ]; then RET="$RET $i"; fi
            fi
        done
        echo $RET
    }    
#echo "$MAIN_DEPS" >> /tmp/del; awk '{ while(++i<=NF) printf (!a[$i]++) ? $i FS : ""; i=split("",a); print "" }' /tmp/del
    remove_duplicates "$MAIN_DEPS"
}


function mkmakefile_c () {
    local AUTOR="Luis Moreno"
    local HOMEPAGE=""
    local EMAIL=""

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Make a C makefile. Usage ${RED_FG}'mkmakefile_c'$NC"
        return
    fi 

    if [ -f Makefile ]; then
        echo -n "There are another Makefile in current directory, dou you want replace it? [Y]es [no]: "
        read OPTION
        case $OPTION in
        N|n)    return;;
        esac
    fi

    local PROYECT_NAME=""
    while [ "$PROYECT_NAME" = "" ]; do
        echo "What is the name of the proyect?"
        read PROYECT_NAME
        PROYECT_NAME=`echo $PROYECT_NAME | sed s/' '/_/g`
    done
    local DATE=$(date +%d/%m/%Y)

    local FILES=`ls *.c`
    if [ "$FILES" = "" ]; then 
        echo -e "${YELLOW_FG}WARNING${NC} There aren't C source files in current directory."
        echo "In this conditions you need to edit generated Makefile"
    fi
    for file in $FILES; do
        if [ `grep main $file | wc -l` -gt "0" ]; then
            local MAIN_LIST="$MAIN_LIST $file"
        fi
    done

    echo -e "PROYECT= $PROYECT_NAME\n#VERSION= EDITME\n\nPROYECT_DIR=\$(PROYECT)\$(VERSION)\nCC=gcc\n#CC=i486-mingw32-gcc\n#.PHONY:all clean \n#autotools\n\n###############################################################\n# Define with -march flag (in CFLAGS) the instruction set to use\n#ARCH= -march=i386\n#   -march=...\n#	i386            Intel 386 Prcoessor\n#	i486            Intel/AMD 486 Processor\n#	pentium         Intel Pentium Processor\n#	pentiumpro      Intel Pentium Pro Processor\n#	pentium2	    Intel PentiumII/Celeron Processor\n#	pentium3	    Intel PentiumIII/Celeron Processor\n#	pentium4        Intel Pentium 4/Celeron Processor\n#	k6              AMD K6 Processor\n#	k6-2		    AMD K6-2 Processor\n#	K6-3		    AMD K6-3 Processor\n#	athlon          AMD Athlon/Duron Processor\n#	athlon-tbird    AMD Athlon Thunderbird Processor\n#	athlon-4	    AMD Athlon Version 4 Processor\n#	athlon-xp	    AMD Athlon XP Processor\n#	athlon-mp	    AMD Athlon MP Processor\n###############################################################\n# \n# To use debuggers uncomment line below\nDEBUG= -g\n#\n# To increment level of warnings uncomment line below\nWARNINGS= -Wall -W" > Makefile

    echo -e "#\n# Linux programs using outb/inb requires the gcc -O2 option. \n# To use outb/inb functions uncomment line below" >> Makefile
    if [ `grep outb * | grep -v Makefile | wc -l` -gt "0" ] || [ `grep inb * | grep -v Makefile | wc -l` -gt "0" ]; then
        echo -e "OUTB_INB= -O2" >> Makefile
    else        
        echo -e "#OUTB_INB= -O2" >> Makefile
    fi

    echo -e "#\n# To use math library (math.h) uncomment line below" >> Makefile
    if [ `grep math.h * | grep -v Makefile | wc -l` -gt "0" ]; then
        echo -e "MATH = -lm" >> Makefile
    else        
        echo -e "#MATH = -lm" >> Makefile
    fi

    echo -e "#\n# To use linux threats (pthread.h) uncomment line below" >> Makefile
    if [ `grep pthread.h * | grep -v Makefile | wc -l` -gt "0" ]; then
        echo -e "THREAD= -lpthread" >> Makefile
    else        
        echo -e "#THREAD= -lpthread" >> Makefile
    fi

    echo -e "#\n# Flags given to add in compiled programs extra objects (*.\$(OBJEXT)) and libraries (*.a, *.la)\nLDADD= \$(THREAD) \$(MATH)\n#\n# Flags given to the compiler (command line flags to cc)\nCFLAGS= \$(DEBUG) \$(WARNINGS) \$(ARCH) \$(OUTB_INB)\n#\n# Directorios de librerias ej:  -L /lib\n#LIB_DIR = -L /lib		\n#\n# Librerias ej: -lm  ( \$(LIB_DIR)/libm.a )\n#LIB = \$(THREAD) \$(MATH)	\n#\n# Flags given to the linker to pass extra flags to the link \n# step of a program or a shared library (command line flags to ld)\nLDFLAGS = \$(LIB_DIR) \$(LIB)\n###############################################################\n" >> Makefile

    echo -en "all: info" >> Makefile
    for MAIN in $MAIN_LIST; do
        echo -en " ${MAIN%.*}" >> Makefile
    done

    echo -en "\n\nclean:\n	rm -rfv *.o *.core" >> Makefile
    for MAIN in $MAIN_LIST; do
        echo -en " ${MAIN%.*}" >> Makefile
    done

    echo -e "\n\ndocs:\n	rm -rf doc/*\n	doxygen Doxyfile\n\nfcpy:\n	rm -rf \$(PROYECT_DIR)\n	mkdir \$(PROYECT_DIR)\n	for file in \$(shell ls); do if [ \$\${file} != \$(PROYECT_DIR) ]; then cp -rf \$\${file} \$(PROYECT_DIR)/; fi; done;\n\nzip: 	fcpy\n	rm -f \$(PROYECT_DIR).zip\n	zip -r \$(PROYECT_DIR).zip \$(PROYECT_DIR)/\n	rm -rf \$(PROYECT_DIR)/\n\ntgz:	fcpy\n	rm -f \$(PROYECT_DIR).tgz\n	tar czf \$(PROYECT_DIR).tgz --recursion \$(PROYECT_DIR)/\n	rm -rf \$(PROYECT_DIR)/\n\nhelp:\n	@echo \"Use: make <target> ...\"\n	@echo \"Targets to compile binaries:\"\n	@echo \"     all ---------- compile all binaries\"" >> Makefile

    for MAIN in $MAIN_LIST; do
        echo -e "	@echo \"     ${MAIN%.*} ---------- compile $MAIN\""  >> Makefile
    done

    echo -e "	@echo \"Other targets:\"\n	@echo \"     clean -------- delete binaries, objects and temp files\"\n	@echo \"     docs --------- to generate documentation with doxygen and delete older\"\n	@echo \"     fcpy --------- create a copy of all proyect in a subdirectory\"\n	@echo \"     zip ---------- archive the sources into a zip file and delete the older zip\"\n	@echo \"     tgz ---------- archive the sources into a tgz file and delete the older tgz\"\n	@echo \"     help --------- show this message\"\n	@echo \"     info --------- show autor info and more\"\n\ninfo:\n	@echo \"********************************************************************\"\n	@echo \"AUTOR: $AUTOR 		$HOMEPAGE    $DATE\"\n	@echo \"Description: EDITME\"\n	@echo \"********************************************************************\"\n	@echo \"      ---------> type make help for more info <---------\"\n	@echo \"********************************************************************\"\n\n" >> Makefile

    for MAIN in $MAIN_LIST; do
        echo -en "${MAIN%.*}: ${MAIN%.*}.o" >> Makefile

        local MAIN_DEPS=`calculate_dependencies2 $MAIN`
        for DEP in $MAIN_DEPS; do
            echo -n " ${DEP}.o" >> Makefile
        done

        echo -e "\n	\$(CC) \$(LDFLAGS) -o \$@ $^ \$(LDADD)\n"  >> Makefile
    done
    echo -e "%.o: %.c %.h\n	\$(CC) \$(CFLAGS) -c $< \n" >> Makefile

    echo "Makefile was generated in '`pwd`/Makefile'"
}


function swapfiles () {
    if [ $# -ne 2 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Swap two files. Usage ${RED_FG}'swapfiles file1 file2'$NC"
        return
    fi
    if [ -f "$1" ] && [ -f "$2" ]; then
		local TEMP_FILE="/tmp/deleteme.$$"
        cp "$1" $TEMP_FILE
        cp "$2" "$1"
        cp $TEMP_FILE "$2"
        rm $TEMP_FILE
    else
        echo "'$1' or '$2', are not valid files"
    fi
}


function srch () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Find a word in files under the current directory ignoring .svn, log files and backups. Usage ${RED_FG}'srch word'$NC"
        return
    fi
    grep -n -R $1 * | grep -v "\.svn" | grep -v "\.log" | grep -v "*~"
}


function rename () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Rename a file or folder. Changes in the name; spaces with '_', substrings ' - ' with '-', and delete non printable characters. Usage ${RED_FG}'rnm file'$NC or ${RED_FG}'rename folder'$NC"
        return
    fi
    if [ ! -d "$1" ] && [ ! -f "$1" ]; then
        echo "'$1' is not a valid file or folder"
        return
    fi
    # first delete blank spaces using sed, later tr delete non printable characters
    local NEW=`echo $1 | sed s/' '/_/g | tr -cd '\11\12\40-\176'`
    # others adjust for best renaming
    NEW=`echo $NEW`
    mv "$1" $NEW
    echo "renamed as '$NEW'"
}


function replace_strings () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Replace strings in files. Usage ${RED_FG}'replace_strings file1 file2...'$NC"
        return
    fi
	local TEMP_FILE="/tmp/deleteme.$$"

	echo "Write the original string to search" 
	read ORIGINAL
	echo "Write the string that replace the original string" 
	read NEW; echo -e "\n\n############# FILE #############\n"

    for file in $*; do
        if [ -f "$file" ]; then

			if [ $# -eq 1 ]; then
				cat $file | sed s/"$ORIGINAL"/"$NEW"/g
				return
			else
	            sed s/"$ORIGINAL"/"$NEW"/g < $file > $TEMP_FILE
	            mv $TEMP_FILE $file
			fi

        else
            echo "'$file' is not a valid file; jumping it"
        fi
    done
}


function rmtabs () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Remove the tabulators in files and replace each by 4 spaces. Usage ${RED_FG}'rmtabs file1 file2...'$NC"
        return
    fi
	local TEMP_FILE="/tmp/deleteme.$$"

    for file in $*; do
        if [ -f "$file" ]; then

			if [ $# -eq 1 ]; then
				cat $file | sed s/'\t'/'    '/g
				return
			else
	            sed s/'\t'/'    '/g < $file > $TEMP_FILE
	            mv $TEMP_FILE $file
			fi

        else
            echo "'$file' is not a valid file; jumping it"
        fi
    done
}


function rmnpc () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Remove non printable characters of files. Usage ${RED_FG}'rmnpc file1 file2...'$NC"
        return
    fi
	local TEMP_FILE="/tmp/deleteme.$$"

    for file in $*; do
        if [ -f "$file" ]; then
						
			if [ $# -eq 1 ]; then
				cat $file | tr -cd '\11\12\40-\176'
				return
			else
	            tr -cd '\11\12\40-\176' < $file > $TEMP_FILE
	            mv $TEMP_FILE $file
			fi

        else
            echo "'$file' is not a valid file; jumping it"
        fi
    done
}


function translate_newlines () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Remove newlines in files and replace each by '\\\n' in characters. Usage ${RED_FG}'translate_newlines file1 file2...'$NC"
        return
    fi
	#Characters that don't use a lot 
    local SPECIAL_CHAR="'*' \\ ? ? @" #list of special(rare) characters

	local TEMP_FILE="/tmp/deleteme.$$"

    for file in $*; do
        if [ -f "$file" ]; then
            dos2unix $file	

			for c in $SPECIAL_CHAR; do

	            local LINES_WITH_SPECIALCHAR=`cat $file | grep \'$c\' | wc -l`
    	        if [ "$LINES_WITH_SPECIALCHAR" -eq "0" ]; then
        
                    #od -c your_file | tr '\n' '$c' > your_new_file 			
					if [ $# -eq 1 ]; then
						cat $file | tr '\012' $c | sed s/$c/'\\n'/g
						return
					else
	    	            cat $file | tr '\012' $c | sed s/$c/'\\n'/g > $TEMP_FILE 
	    	            mv $TEMP_FILE $file
						break
					fi
    	        fi
			done
			if [ "$LINES_WITH_SPECIALCHAR" -ne "0" ]; then
    	    	echo "${RED_FG}ERROR!$NC I can't work with file'$file'."
    	        echo "I need that you add new special character on SPECIAL_CHAR variable (NOTE: don't add *). The special character should not appear in the file '$file'"
            fi

        else
            echo "'$file' is not a valid file; jumping it"
        fi
    done
}


function recursive_command () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Execute bash command in working directory and in all subfoders. Only one command execution in working directory and for each subfolder. Usage ${RED_FG}'recursive_command \"bash_command\"'$NC"
        return
    fi
	local WD=`pwd`

	recursive_execution () {

		ACTION=$1
    	local ITEMS=`ls`
    	for i in $ITEMS; do
    	    if [ -d $i ]; then
    	        cd $i
    	        recursive_execution "$1"
    	    fi
    	done
    	echo "doing '${ACTION}' in folder `pwd`"
		${ACTION}
    	cd ..
	}

	recursive_execution "$1"
	cd $WD
}


function kll () {
    if  [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Giving a percentage of maximum load, kills every process of the current user that takes a load of CPU greater or equal to that given percentage."
        echo -e "It kills every process that produces a load on the CPU greater or equal than the percentage user defined. Usage ${RED_FG}'kll cpu_percentage_usage'$NC"
        return
    fi
    if [ "$1" -le "20" ]; then
        echo "Is dangerous to kill processes that use less than 20% of the CPU. It's not allowed."
        return
    fi
    
    # save process snapshot; a list with pairs %CPU-PID and mutiply all CPU percentages by 10:
    #                        [%CPU_proc1 x 10, PID_proc1] [%CPU_proc2 x 10, PID_proc2] ...
    if [ "$HOME" = "/root" ] || [ "$USER" = "root" ]; then
        # if user is root, save list with all process
        local PROCS=`ps -ax -o %cpu,pid | tr -d '%CPU' | tr -d 'ID' | tr -d '.'`
    else
        #al quitar el . con tr es como multiplicar por 10 la carga de cpu que registre
        local PROCS=`ps -u $USER -o %cpu,pid | tr -d '%CPU' | tr -d 'ID' | tr -d '.'`
    fi

    local LOAD_TARGET=`expr $1 \* 10` # multiply by 10 like the snapshot (process list)
    local FLAG=0
    for i in $PROCS; do
    # if the element of the list is less than 1000 it's a % cpu load (100x10)
    # in case that it's greater than 1000 it's a PID (because the PID of "killable" 
    # process are always greater than 1000) 

        # second: if detected %CPU load grater than user defined
        # inform at user and kill process using the PID
        if [ $FLAG -eq 1 ]; then
            
            if [ "$HOME" = "/root" ] || [ "$USER" = "root" ]; then
                #if user is root, he can kill any process
                local CMD=`ps -ax -o pid,command | tr -d 'ID' | grep "$i" | head -n 1`
            else
                local CMD=`ps -u $USER -o pid,command | tr -d 'ID' | grep "$i" | head -n 1`
            fi
            echo "pid, program: $CMD"
            echo -n "killing... "

            # first try SIGTERM if, fails try SIGKILL
# First try SIGTERM don't work; always return positive number, but it should be the best way
#            if kill $i; then
#                echo -e "${GREEN_FG}done!$NC\n"
#            else        
                if kill -9 $i; then echo -e "${GREEN_FG}done!$NC\n"
                else echo -e "${RED_FG}ERROR!$NC\n"; fi
#            fi
            FLAG=0
        fi
        # first look the % cpu load of all processes (all multiplied by 10)
        if [ "$i" -le "1000" ] && [ "$i" -gt "$LOAD_TARGET" ]; then
            local LOAD=`expr $i / 10`
            echo "found process using $LOAD% of cpu"
            FLAG=1
        fi
    done
}


function my_ps () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Shows all the process of the current user. Usage ${RED_FG}'my_ps'$NC or ${RED_FG}'my_ps process1 process2...'$NC"
        return
    fi
    ps $@ -u $USER -o stat,pid,%cpu,%mem,bsdtime,command ;
}


function p_cpu () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Shows the process order by CPU load."
        return
    fi
    ps -e -o pcpu,cpu,nice,state,bsdtime,args --sort pcpu | sed '/^ 0.0 /d'
}


function restart () {
    SRVDIR=/etc/rc.d

    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Restart all the services passed. Usage ${RED_FG}'restart service1 service2...'$NC"
        echo -e "The services must be in '$SRVDIR' folder, if not, adjust ${YELLOW_FG}SRVDIR$NC variable with the services path; sshd, httpd, ftpd..."
        return
    fi
    if [ -d "$SRVDIR" ] && [ -f "$SRVDIR/$@" ]; then
        $SRVDIR/$@ restart
    else
       echo -e "folder '$SRVDIR' or file '$SRVDIR/$1' don't exists. Check ${YELLOW_FG}SRVDIR$NC variable value"
    fi
}


######################################################################################
#################################### INITIALIZE BASH #################################
######################################################################################
# Path's
#PATH="$PATH:/opt/java/jre/bin:/sbin:/usr/sbin"
PATH="$PATH:/usr/local/bin:$HOME/bin"
#MANPATH="$MANPATH:/usr/man/:/usr/local/man"

# Is necessary to call 'colorON' or 'colorOFF' to initialize the color variables
# colorOFF
colorON #--verbose

# Prompt (It is set by 'colorON' and 'colorOFF' in order to refresh its value)
#PS1='\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;34m\]\h\[\033[00m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '

# When X server is not loaded (for TTY's)
#if [ ! "$DISPLAY" ]; then 
#    # Disable bells
#    #for i in 1 2 3 4 5 6; do setterm -blength 0 > /dev/tty$i; done
#
#    # Set keymap 
#    loadkeys es
#else
#    # Disable bells (visual and sound) in xterm
#    xset -b
#
#    # Set keymap
#    setxkbmap -layout es,es
#
#    # Allow Ctrl-Alt-Backspace exit X 
#    setxkbmap -option terminate:ctrl_alt_bksp
#
#    # Avoid "Invalid MIT-MAGIC-COOKIE-1 keyxset:  unable to open display ":0" errors
#    if [ $USER != "root" ] && [ $HOME = "/root" ]; then
#        cp /home/$USER/.Xauthority /root
#    fi
#
#    # Load xterm configfile    
#    if [ -f ~/.Xdefaults ]; then
#        xrdb -load ~/.Xdefaults
#    else
#        echo -e "XTerm*background: #000000\nXTerm*foreground: white" >> ~/.Xdefaults
#    fi
#fi

# set country for WIFI channels
#iw reg set ES

# Enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# For include more functions, aliases, exports, colors, extras...
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
#if [ -f ~/.bash_exports ]; then
#    . ~/.bash_exports;
#fi
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases;
#fi
#if [ -f ~/.bash_functions ]; then
#    . ~/.bash_functions;
#fi
#if [ -f ~/.bash_extras ]; then
#    . ~/.bash_extras;
#fi
#for personal LS_COLORS values
#if [ -f ~/.dir_colors ]; then
#    eval `dircolors ~/.dir_colors`
#fi
#if [ -f /etc/profile ]; then
#    . /etc/profile
#fi

# Fortune is fun
if which fortune &>/dev/null; then
    echo "----------------------------------- FORTUNE ----------------------------------"
    fortune -ac
    echo "------------------------------------------------------------------------------"
fi

#echo -e "$WHITE_FG$UNDERLINE>>>>> Type 'bhelp' for information about available extras in .bashrc$NC\n"


# Check time system consistency; time's of hwclock and date commands
#if which hwclock &>/dev/null; then
if false ; then

    # If the adjtime file /etc/adjtime doesn't exist, the default is local time
    if [ ! -f /etc/adjtime ]; then
        HW_FLAG="--localtime"
        DATE_FLAG=""
    else    
        HW_FLAG="--utc"
        DATE_FLAG="--utc"
    fi
    #if [ "$(date $DATE_FLAG +"%a %d %b %Y %X")" != "$(hwclock $HW_FLAG | awk -F "CET" '{ print $1 }')" ]; then
    DATE_CLOCK=$(date $DATE_FLAG +"%a %d %b %Y %I:%M")  # without seconds
    HW_CLOCK=`hwclock $HW_FLAG`; HW_CLOCK=${HW_CLOCK%:*} # without seconds
    if [ "$DATE_CLOCK" != "$HW_CLOCK" ]; then
        
        echo -e "${RED_FG}CLOCK'S ERROR${NC}\nThe time's of date and hwclock are diferent."
        echo "date: $DATE_CLOCK"
        echo -e "hwclock: $HW_CLOCK\n"

        DATE_CLOCK=`echo $DATE_CLOCK | tr -d [A-Z] | tr -d [a-z] | tr -d ' ' | tr -d ':'` # only integers
        HW_CLOCK=`echo $HW_CLOCK | tr -d [A-Z] | tr -d [a-z] | tr -d ' ' | tr -d ':'` # only integers
        if [ $HW_CLOCK -lt $DATE_CLOCK ]; then
            echo -e "${YELLOW_FG}WARNING${NC}\nProbably you need to replace CMOS battery"
            echo -e "hwclock < date\n"
        fi
    fi
fi


######################################################################################
######################### SO ESPECIFIC AND PERSONAL FUNCTIONS ########################
################################# AND TESTING FUNCTIONS ##############################
######################################################################################

# sanitize - set file/directory owner and permissions to normal values (644/755)
# usage: sanitize <file>
sanitize()
{
  chmod -R u=rwX,go=rX "$@"
  chown -R ${USER}:users "$@"
}

# Cool History Summerizer
historyawk(){ history|awk '{a[$2]++}END{for(i in a){printf"%5d\t%s\n",a[i],i}}'|sort -nr|head; }


# Solo sirve para Fedora
mkboot_disk () {
    local KERNEL_VERSION=`uname -r`
    local ISO_NAME=BOOT_DISC_$KERNEL_VERSION.iso

    # Para mkbootdisk (FEDORA)
    /sbin/mkbootdisk --verbose --iso --device $HOME/$ISO_NAME $KERNEL_VERSION
    if [ $? != 0 ]; then
        echo -e "${RED_FG}ERROR!$NC"
    else
        echo -e "${GREEN_FG}done!$NC"
        echo "boot disk creado como $HOME/$ISO_NAME"
    fi

}


alias pacs='pacsearch'
pacsearch () {
    echo -e "$(pacman -Ss $@ | sed \
    -e 's#current/.*#\\033[1;31m&\\033[0;37m#g' \
    -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
    -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
    -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}


alias mame='echo -n "Choose the screen scale [1-4], default 2: "; read SCALE; if [ "$SCALE" = "" ]; then SCALE=2; fi; xmame -ws $SCALE -hs $SCALE $*'
xmame_ls () {
    local GAMES_DIR="/mnt/datos/roms/neo-geo"
    local BIOS_DIR=$GAMES_DIR

    local NUM_GAMES=0
    local NUM_FILES=0
    for r in `ls $GAMES_DIR/*.zip`; do

        xmame -nolcf -id $r | grep --color=never [A-Z] | grep --color=never '=' > deleteme
        local GAME_NAME=""
        local SPACES="  "
        #mientras gamename sea 0 incremento el numero de espacios hasta 10
        while [ ! "$GAME_NAME" ] && [ "$SPACES" != '          ' ]; do
            GAME_NAME=`head -n 1 deleteme | awk -F "$SPACES" '{ print $2 }'`
            SPACES="$SPACES "
        done
        if [ "$GAME_NAME" ]; then
            ROM=${r##*/} #muestra desde el ultimo '/'
            echo "$ROM -> $GAME_NAME"
            NUM_GAMES=`expr $NUM_GAMES + 1`
        else
            echo "'$r' not seems a game"
        fi
        NUM_FILES=`expr $NUM_FILES + 1`
    done
    rm deleteme
    echo
    echo "Detected $NUM_GAMES games."
    echo "$NUM_FILES zipped files processed."
}


#################### PSQL FUNCTIONS #####################

alias psql_list_dbs='psql -l'
alias psql_list_users='echo "\du" | psql postgres'
alias psql_create_user='createuser'
alias psql_delete_user='dropuser'
alias psql_delete_db='dropdb'

psql_fileload() {
    if [ $# = 0 ] && [ "$DBNAME" = "" ]; then
        echo -e "Dame 1? el nombre del fichero y luego el nombre de la BD"
        return
    fi
    local FILE=$1
    if [ "$DBNAME" = "" ] || [ $# -gt 1 ]; then DBNAME=$2; fi
    psql -e -f $FILE $DBNAME    
}


psql_query() {
    if [ $# = 0 ] && [ "$DBNAME" = "" ]; then
        echo -e "Dame 1? la consulta entre comillas dobles y luego el nombre de la BD"
        return
    fi
    local QUERY=$1
    if [ "$DBNAME" = "" ] || [ $# -gt 1 ]; then DBNAME=$2; fi
    psql -c "$QUERY" $DBNAME    
}


psql_dbconnect () {
    if [ $# = 0 ] && [ "$DBNAME" = "" ]; then
        echo -e "Dame el nombre de la base de datos a la que acceder (conectar)"
        return
    fi
    if [ "$DBNAME" = "" ] || [ $# -gt 0 ]; then DBNAME=$1; fi
    psql $DBNAME
}


psql_list_dbusers () {
    if [ $# = 0 ] && [ "$DBNAME" = "" ]; then
        echo -e "Dame el nombre de la base de datos de la que listar los usuarios"
        return
    fi
    if [ "$DBNAME" = "" ] || [ $# -gt 0 ]; then DBNAME=$1; fi
    echo "\du" | psql $DBNAME
}


psql_list_dbtables() {
    if [ $# = 0 ] && [ "$DBNAME" = "" ]; then
        echo -e "Dame el nombre de la base de datos de la que listar las tablas"
        return
    fi
    if [ "$DBNAME" = "" ] || [ $# -gt 0 ]; then DBNAME=$1; fi
    echo "\dt" | psql $DBNAME
}


psql_table_info() {
    if [ $# = 0 ] && [ "$DBNAME" = "" ]; then
        echo -e "Dame 1? el nombre de la base de datos y luego el nombre de la tabla"
        return
    fi
    local TABLE=$2
    if [ "$DBNAME" = "" ] || [ $# -gt 1 ]; then DBNAME=$1; fi
    echo "\d $TABLE" | psql $DBNAME    
}


psql_newdb_loadingfiles () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Crea bases de datos nuevas en PostgreSQL desde ficheros"
        return
    fi
    if [ $# -gt 1 ]; then
        echo "NOTA: Se ha especificado mas de un archivo pero solo se cargara el primero"
    fi

    DBNAME=`echo ${1%.*}`

    echo -n "NOTA: el nombre de la base de datos a crear sera '$DBNAME', deseas cambiarlo? [y]es, [N]o: "
    read respuesta
    case $respuesta in
        Y|y)    echo "Escribe el nuevo nombre para la BD"
                read DBNAME;;
        *)      ;;
    esac

    export PGUSER=$USER
    export PGPASSWORD=""
    export DBNAME    

    createdb -e $DBNAME 
    if [ $? -ne 0 ]; then
    	echo -e "\nError al crear la base de datos"
    	return
    fi
    echo -e "Base de datos '$DBNAME' creada y accesible para el usuario '$PGUSER'\n"

    psql -f $1 $DBNAME
    echo -e "Se cargo el esquema de la base de datos del fichero '$1'\n"

    createlang plpgsql $DBNAME

    while [ 1 ]; do
        echo -n "Deseas cargar datos en esta BD o algun fichero mas? [y]es, [N]o: "
        read respuesta
        case $respuesta in
            Y|y)    echo "Escribe el path del fichero"        
                    read file
                    while [ ! -f $file ]; do
                        echo "El fichero '$file' no existe"
                        echo "Escribe de nuevo el path del fichero"
                        read file
                    done            
                    psql -e -f $file $DBNAME;;
            *)      break;;
        esac
    done

    echo -n "Deseas ahora borrar la base de datos? [Y]es, [n]o: "
    read respuesta
    case $respuesta in
        n|N)    echo -e "Para borrar la base de datos usa 'dropdb $DBNAME'"; return;;
        *)      dropdb $DBNAME; 
                if [ $? -ne 0 ]; then
                    echo "La base de datos no se pudo borrar; Para borrar la base de datos usa 'dropdb $DBNAME'"
                else
                    echo "Base de datos '$DBNAME' borrada"
                fi;;
    esac
}
