# Arkyve

## Description

A script to automatically move any file into an archive folder

## Usage

```bash
arkyve <file1> [<file2> ...]
```

## Behavior

- If an Archive, Archives, or 4-Archives folder exists in the current directory, move the file(s) into it.
- Else, if an Archive, Archives, or 4-Archives folder exists in the parent directory, move the file(s) into it.
- Else, create an Archive folder in the current directory and move the file(s) into it.
