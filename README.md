# Custom-Command-mygrep.sh-
# 🛠️ MyGrep.sh - Mini Grep Command Clone

This project is a mini version of the `grep` command, written as a Bash script.  
It allows you to search for strings inside a text file, with support for options like showing line numbers and inverting matches.

---

## 📋 Features
- Case-insensitive string search.
- Print matching lines from a text file.
- Support for options:
  - `-n` → Show line numbers.
  - `-v` → Invert match (show lines that **do not** match the search).
  - Combined options like `-vn` or `-nv` are supported.
- `--help` option to print usage instructions.
- Basic error handling (missing arguments, missing files).

---

## 🚀 How to Use

First, make the script executable:

```bash
chmod +x mygrep.sh
