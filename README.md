# Arkyve

## Description

A script to automatically move any file into an "Archive"

## Usage

```bash
arkyve <file1> [<file2> ...]
```

## Behavior

- If an Archive or Archives folder exists in the current directory, move the file(s) into it.
- Else, if an Archive or Archives folder exists in the parent directory, move the file(s) into it.
- Else, create an Archive or Archives folder in the current directory and move the file(s) into it.
