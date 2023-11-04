#!/bin/bash
# Generate maps
map_files=(
    "./maps/outpost21/outpost-01-basement.dmm"
    "./maps/outpost21/outpost-02-surface.dmm"
    "./maps/outpost21/outpost-03-upper.dmm"
    "./maps/outpost21/outpost-07-asteroid.dmm"
)

tools/github-actions/nanomap-renderer minimap -w 2240 -h 2240 "${map_files[@]}"

# Move and rename files so the game understands them
cd "data/nanomaps"

mv "outpost-01-basement_nanomap_z1.png" "outpost_nanomap_z1.png"
mv "outpost-02-surface_nanomap_z1.png" "outpost_nanomap_z2.png"
mv "outpost-03-upper_nanomap_z1.png" "outpost_nanomap_z3.png"
mv "outpost-07-asteroid_nanomap_z1.png" "outpost_nanomap_z7.png"

cd "../../"
cp data/nanomaps/* "icons/_nanomaps/"