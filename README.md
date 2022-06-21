# Bash Tips

## specify command to run the file

Running a command through `/usr/bin/env` has the benefit of looking for whatever the default version of the program is in your current environment. So you don't have to look for it in a specific place on the system.

```bash
#!/usr/bin/env bash #lends you some flexibility on different systems
#!/usr/bin/bash     #gives you explicit control on a given system of what executable is called
```

## extract cert file from pfx
```
openssl pkcs12 -in mic_certificate_<>.pfx -clcerts -nokeys -out <>.pem
```
## view system info
```bash
system_profiler SPSoftwareDataType SPHardwareDataType
uname
```

## AWK
```bash
# row 4 and item 6
iostat | awk '{if (NR==4) print $6}'
d=$(echo "3 4" | awk '{c=$2/$1; printf "%0.4f\n", c }') 
sensors | grep CPU | awk '{printf "%d\n", $2}'
cat pi_data.txt | awk '{if ( $1 ~ /[0-9]/ ) print $0}'

$ cat pi_data.txt | \
>   awk '{if ( $1 ~ /[0-9]/ ) \
>            { \
>               {if ($3 < 4) {print $1 "\t small"} else { print $1 "\t medium"} } \
>        } else { print $1 "\t " $3} \
>        }'
time     wave(ft)

ls -l *.db | awk '{sum +=$5 } END {print "Total= " sum}'
lsusb -v  2>&- | grep -E  'Bus 00|MaxPower'

#!/bin/bash
#
# stop_task.sh - stop a task
#
task1="edublocks"
 
echo "Stopping $task1..."
ps -e | grep -E $task1 | \
 awk '{print $1}' | xargs sudo kill -9 1>&-
 
# another option:
ps -e | grep $task1 | awk '{system("sudo kill " $1 "  1>&-")'}

sensors | grep CPU | awk '{print substr($2,2,4)}'
```
### AWK Separator
```bash
# separator :
echo "1:hi" | awk -F  ":" '{print $2}'
echo "1: " | awk -F  ":" '/1/ {print $1}'

# use split
echo "12=23 11" | awk '{split($0,a,"="); print a[3]; print a[2]; print a[1]}'
export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk '{split($0,v,"= "); print v[2] }')
ls ""${JAVA_HOME}""
```
## Insert line
https://www.baeldung.com/linux/insert-line-specific-line-number
### ed (interactive)
```bash
# ed: number of character in the file and interactive
# insert at line 3 "hello"
# save and exit . - finish, w - write changes, q - quit
ed <file>
3i
hello
.
w
q
# save above scripts in script.ed
ed <file> <script.ed
```
### sed (origin from ed)
```bash
# line 3, i for insert
# -i for apply changes to the file
sed -i '3 i hello' <file>
# save change to a different file
sed '3 i hello' <file> > <outfile>
```
### awk (from ed)
```bash
# awk 'condition{action}'
# NR num of records for line number
# number 1 at the end could be any non-zero, to print every line
awk 'NR==3{print "New Line with awk"}1' File1
```
### gawk (GNU awk)

## pushd and popd
```bash
pushd
# move 2nd from bottom to top
pushd +1
# move 2nd from top to top
pushd -1
popd
# pop 2nd item from bottom
popd +1
# pop 2nd item from top
popd -1
dirs
dirs -v
cd ~1
# In ~/.bashrc
alias dirs="dirs -v"
```
## echo shell commands

```bash
# to turn on
set -x
set -o xtrace
set -v
set -o verbose
# to turn off
set +x
set +v
```

## find directories

```bash
# {} will be replaced by the name
find . -maxdepth 1 -mindepth 1 -type d -exec echo {} \;
find ./ -type d -maxdepth 1 -exec basename {} \;
for dir in */; do  if [[ $(basename $dir) != "node_modules" ]]; then echo "$dir"; fi; done
# OR
find . -maxdepth 1 -mindepth 1 -type d | while read dir; do
  echo "$dir"
done
# OR
for dir in */; do
    echo "$dir"
done
# OR
for file in *; do
    if [ -d "$file" ]; then
        echo "$file"
    fi
done
# OR
# exclude node_modules and .git
find . -type d -name 'node_modules' -prune -o -name '.git' -prune -o  -type d -print
# add -maxdepth 1
```

## find files by name

```bash
# find by type
# f – regular file
# d – directory
# l – symbolic link
# c – character devices
# b – block devices
find / -type f -name "*.conf"
# find files *.json
# exlude node_modules by adding -path ./node_modules -prune -false -o
find . -path ./node_modules -prune -false -o -name '*.json'
find . -name "*.js" -not -path "./node_modules/*"
# exclude multiple path at current level
find . -type d \( -path dir1 -o -path dir2 -o -path dir3 \) -prune -false -o -name '*.txt'
# exlude directories at any level
find . -type d \( -name node_modules -o -name dir2 -o -path name \) -prune -false -o -name '*.json'
```

## find files with text

```bash
grep -rnw '/path/to/somewhere/' -e 'pattern'
man grep
# ================
# flags
-r or -R is recursive,
-n is line number, and
-w stands for match the whole word.
-l (lower-case L) can be added to just give the file name of matching files.
-e is the pattern used during the search
# =================
# search those files with .c or .h extensions:
grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"
# exclude files with .o extension:
grep --exclude=\*.o -rnw '/path/to/somewhere/' -e "pattern"
# exclude directories
grep --exclude-dir={dir1,dir2,_.dst} -rnw '/path/to/somewhere/' -e "pattern"
```

## color echo

```bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
echo "${red}red text ${green}green text${reset}"
```
