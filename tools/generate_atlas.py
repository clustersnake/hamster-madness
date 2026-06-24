"""
Generate Defold .atlas from rendered sprite PNGs.

Usage:
  python tools/generate_atlas.py <character_dir>

Example:
  python tools/generate_atlas.py "Hamster Madness/main/enemies/bosses/turtle"
"""

import os
import sys
import glob


def generate_atlas(character_dir, actions, directions, fps=12,
                   trim_mode="SPRITE_TRIM_MODE_4",
                   parent_path="/main/enemies/bosses"):
    atlas_path = os.path.join(character_dir, f"{os.path.basename(character_dir)}.atlas")
    sprite_dir = os.path.join(character_dir, "sprites")

    if not os.path.isdir(sprite_dir):
        print(f"ERROR: sprite dir not found: {sprite_dir}")
        sys.exit(1)

    # Determine the relative parent path for atlas references
    # e.g. /main/enemies/bosses/turtle/sprites/turtle_s_0001.png
    rel_base = f"{parent_path}/{os.path.basename(character_dir)}"

    with open(atlas_path, "w") as f:
        # --- Image entries ---
        for action in actions:
            for direction in directions:
                files = sorted(glob.glob(
                    os.path.join(sprite_dir, f"{action}_{direction}_*.png")))
                for img_path in files:
                    rel = os.path.basename(img_path)
                    f.write(f'images {{\n')
                    f.write(f'  image: "{rel_base}/sprites/{rel}"\n')
                    f.write(f'  sprite_trim_mode: {trim_mode}\n')
                    f.write(f'}}\n')

        # --- Animation entries ---
        for action in actions:
            for direction in directions:
                files = sorted(glob.glob(
                    os.path.join(sprite_dir, f"{action}_{direction}_*.png")))
                if not files:
                    continue
                anim_id = f"{action}_{direction}"
                f.write(f'animations {{\n')
                f.write(f'  id: "{anim_id}"\n')
                for img_path in files:
                    rel = os.path.basename(img_path)
                    f.write(f'  images {{ image: "{rel_base}/sprites/{rel}" }}\n')
                f.write(f'  playback: PLAYBACK_LOOP_FORWARD\n')
                f.write(f'  fps: {fps}\n')
                f.write(f'}}\n')

    count = sum(1 for a in actions for d in directions
                if glob.glob(os.path.join(sprite_dir, f"{a}_{d}_*.png")))
    print(f"Generated: {atlas_path}")
    print(f"  {len(actions)} actions × {len(directions)} directions = {count} animation slots")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python tools/generate_atlas.py <character_dir>")
        sys.exit(1)

    char_dir = sys.argv[1]
    actions = ["idle", "walk", "attack", "hurt", "death"]
    directions = ["n", "ne", "e", "se", "s", "sw", "w", "nw"]
    generate_atlas(char_dir, actions, directions)
