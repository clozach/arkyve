# Arkyve

## Description

A script to automatically move any file into an "Archive"

## Usage

```bash
arkyve <file>
```

## Behavior

- If an Archive or Archives folder exists in the current directory, move the file into it.
- Else, if an Archive or Archives folder exists in the parent directory, move the file into it.
- Else, create an Archive or Archives folder in the current directory and move the file into it.
