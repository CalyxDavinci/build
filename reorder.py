#!/usr/bin/env python3
import itertools
import json
import os
import sys

def find_patches(index_path: str) -> dict[str, list[str]]:
    with open(index_path, "r") as f:
        return json.load(f)

def save_patches(index_path: str, index: dict[str, list[str]]):
    with open(index_path, "w") as f:
        json.dump(index, f, indent=4)
        f.truncate()

def change_patch_number(filename: str, number: int) -> str:
    return f"{number:04}-{filename.split('-', 1)[1]}"

if len(sys.argv) == 1:
    print(f"Usage: {sys.argv[0]} path/to/patches")
    exit(1)

path = sys.argv[1]
index_path = os.path.join(path, "INDEX.json")
patch_index = find_patches(index_path)
# Patches should be sorted properly already in the JSON array, so preserve that order
patches = itertools.chain.from_iterable(patch_index.values())

intermediate_paths = []

for number, patch in enumerate(patches, 1):
    new_patch = change_patch_number(patch, number)
    old_path = os.path.join(path, patch)
    new_path = os.path.join(path, new_patch)
    intermediate_path = f"{new_path}.tmp"

    intermediate_paths.append((intermediate_path, new_path, patch, new_patch))

    print(f"{old_path} -> {new_path}")
    os.rename(old_path, intermediate_path)

for (intermediate_path, new_path, _, _) in intermediate_paths:
    os.rename(intermediate_path, new_path)

for section, items in patch_index.items():
    for idx, item in enumerate(items):
        new = [new_patch for (_, _, patch, new_patch) in intermediate_paths if item == patch][0]
        items[idx] = new

save_patches(index_path, patch_index)
