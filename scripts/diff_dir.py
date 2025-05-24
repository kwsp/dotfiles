#!/usr/bin/env python3
from typing import NamedTuple
from datetime import datetime
from pathlib import Path
from pprint import pprint
import argparse


parser = argparse.ArgumentParser()
parser.add_argument("dir1", type=Path)
parser.add_argument("dir2", type=Path)
args = parser.parse_args()

dir1 = args.dir1
dir2 = args.dir2

assert dir1.exists()
assert dir2.exists()

print(f"dir1: {dir1}")
print(f"dir2: {dir2}")


def human_readable_size(size, decimal_places=4):
    for unit in ["B", "KB", "MB", "GB", "TB", "PB"]:
        if size < 1024.0:
            return f"{size:.{decimal_places}f} {unit}"
        size /= 1024.0


def walk(dir1: Path):
    subdirs: list[Path] = []
    files: list[Path] = []
    for p in dir1.glob("*"):
        if p.stem.startswith("."):
            continue
        elif p.is_dir():
            subdirs.append(p)
        else:
            files.append(p)
    subdirs.sort()
    files.sort()
    return subdirs, files


def compare_stat(p1: Path, p2: Path):
    s1 = p1.stat()
    s2 = p2.stat()
    msg = ""
    space = "\t\t\t"
    if s1.st_size != s2.st_size:
        size1 = human_readable_size(s1.st_size)
        size2 = human_readable_size(s2.st_size)
        msg += f"size:\t{size1}{space}{size2}\n"
    time1 = round(s1.st_mtime)
    time2 = round(s2.st_mtime)
    if time1 != time2:
        t1 = datetime.fromtimestamp(time1)
        t2 = datetime.fromtimestamp(time2)
        msg += f"mtime:\t{t1}{space}{t2}\n"
    if msg:
        print("Files different:")
        print(f"File 1:\t{p1}")
        print(f"File 2:\t{p2}")
        # print(f"Name:\t{p1.name}\t\t{p2.name}")
        print(msg, end="\n")
        return False
    return True


class CompareDirResult(NamedTuple):
    extra_f1: list[Path]
    extra_f2: list[Path]
    extra_dir1: list[Path]
    extra_dir2: list[Path]
    files_different: list[tuple[Path, Path]]


def compare_dir(dir1: Path, dir2: Path):
    subdir1, files1 = walk(dir1)
    subdir2, files2 = walk(dir2)
    subdir2dict = {p.name: p for p in subdir2}
    files2dict = {p.name: p for p in files2}
    extra_f1: list[Path] = []
    files_different: list[tuple[Path, Path]] = []
    for f1 in files1:
        if f2 := files2dict.get(f1.name):
            files2dict.pop(f2.name)
            if compare_stat(f1, f2):
                files_different.append((f1, f2))
        else:
            extra_f1.append(f1)
    extra_f2 = list(files2dict.values())
    extra_dir1: list[Path] = []
    extra_dir2: list[Path] = []
    for sd1 in subdir1:
        if sd2 := subdir2dict.get(sd1.name):
            subdir2dict.pop(sd1.name)
            ret = compare_dir(sd1, sd2)
            extra_f1.extend(ret.extra_f1)
            extra_f2.extend(ret.extra_f2)
            extra_dir1.extend(ret.extra_dir1)
            extra_dir2.extend(ret.extra_dir2)
        else:
            extra_dir1.append(sd1)
    extra_dir2.extend(subdir2dict.values())
    return CompareDirResult(
        extra_f1=extra_f1,
        extra_f2=extra_f2,
        extra_dir1=extra_dir1,
        extra_dir2=extra_dir2,
        files_different=files_different,
    )


def print_list_path(l: list[Path], prefix=""):
    for p in l:
        print(f"{prefix}{p}")


ret = compare_dir(dir1, dir2)

if ret.extra_f1:
    print("Files present in dir1 but not in dir2:")
    print_list_path(ret.extra_f1, "\t")
else:
    print("All files present in dir1 are also present in dir2.")

if ret.extra_f2:
    print("Files present in dir2 but not in dir1:")
    print_list_path(ret.extra_f2, "\t")
else:
    print("All files present in dir2 are also present in dir1.")

if ret.extra_dir1:
    print("Subdirectories present in dir1 but not in dir2:")
    print_list_path(ret.extra_dir1, "\t")
else:
    print("All subdirectories present in dir1 are also present in dir1.")

if ret.extra_dir2:
    print("Subdirectories present in dir2 but not in dir1:")
    print_list_path(ret.extra_dir2, "\t")
else:
    print("All subdirectories present in dir2 are also present in dir1.")

if ret.files_different:
    print("Same files with different properties:")
    pprint(ret.files_different)
else:
    print(
        "All files that are present in both directories are identical (st_size and st_mtime)."
    )
