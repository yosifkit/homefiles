export HISTSIZE=$((500 * 1000 * 1000 * 1000))
export HISTFILESIZE=$((HISTSIZE * 2))
# already set
#shopt -s histappend
#PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

alias sl='ls -l'
alias sll='ls -al'
alias vp='vim -p'

alias rsyncshax='/usr/bin/rsync -aSHAXx --partial --numeric-ids --info=progress2'
# https://anarc.at/blog/2019-07-07-rsync-oneliner/
# rsync -PaSHAXx --numeric-ids --info=progress2
# -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
# -S, --sparse                turn sequences of nulls into sparse blocks
# -H, --hard-links            preserve hard links
# -A, --acls                  preserve ACLs (implies -p)
# -X, --xattrs                preserve extended attributes
# -x, --one-file-system       don't cross filesystem boundaries
#     --partial               keep partially transferred files
#     --numeric-ids           don't map uid/gid values by user/group name
#     --info=progress2        statistics based on the whole transfer, rather than individual files
# -c, --checksum              skip based on checksum, not mod-time & size

# unroll
# -r, --recursive             recurse into directories
# -l, --links                 copy symlinks as symlinks
# -p, --perms                 preserve permissions
# -t, --times                 preserve modification times
# -g, --group                 preserve group
# -o, --owner                 preserve owner (super-user only)
# -D                          same as --devices --specials

# unroll again
#     --devices               preserve device files (super-user only)
#     --specials              preserve special files
