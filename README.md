# Bash Tips

## find files by name

```bash
# find by type
# f – regular file
# d – directory
# l – symbolic link
# c – character devices
# b – block devices
find / -type f -name "*.conf"
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

```

```
