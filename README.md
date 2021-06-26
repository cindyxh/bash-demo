# Bash Tips

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
