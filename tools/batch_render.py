"""
Blender Batch Renderer — 8-Direction Sprite Atlas Generator
============================================================

Usage:
  blender --background model.blend --python batch_render.py -- --config config.json

The config JSON specifies which actions to render, the output directory, and
render settings. A single model.blend can serve multiple characters if you
run the script multiple times with different configs.

Config structure (example):
{
    "character": "turtle",
    "output_dir": "/home/user/hamster-madness/Hamster Madness/main/enemies/bosses/turtle/sprites",
    "render_engine": "BLENDER_EEVEE",
    "resolution_x": 192,
    "resolution_y": 192,
    "camera_distance": 8,
    "camera_height": 6,
    "ortho_scale": 4.0,
    "fps": 12,
    "actions": [
        {"name": "idle",   "frames": "all"},
        {"name": "walk",   "frames": "all"},
        {"name": "attack", "frames": "all"},
        {"name": "hurt",   "frames": "all"},
        {"name": "death",  "frames": "all"}
    ]
}

Direction naming (8 angles):
  camera_angle → output suffix
  0°    → "e"   (camera at +X, model faces east)
  45°   → "se"  (camera at +X/+Y, model faces south-east)
  90°   → "s"   (camera at +Y, model faces south)
  135°  → "sw"
  180°  → "w"   (camera at -X, model faces west)
  225°  → "nw"
  270°  → "n"   (camera at -Y, model faces north)
  315°  → "ne"
"""

import argparse
import json
import os
import sys
import math

import bpy


# ---------------------------------------------------------------------------
# CLI argument parsing
# ---------------------------------------------------------------------------

argv = sys.argv
if "--" in argv:
    argv = argv[argv.index("--") + 1:]
else:
    argv = []

parser = argparse.ArgumentParser()
parser.add_argument("--config", type=str, required=True)
args = parser.parse_args(argv)

with open(args.config) as f:
    CONFIG = json.load(f)

CHAR       = CONFIG["character"]
OUTPUT_DIR = CONFIG["output_dir"]
ENGINE     = CONFIG.get("render_engine", "BLENDER_EEVEE")
RES_X      = CONFIG["resolution_x"]
RES_Y      = CONFIG["resolution_y"]
CAM_DIST   = CONFIG["camera_distance"]
CAM_HEIGHT = CONFIG["camera_height"]
ORTHO_SCALE = CONFIG["ortho_scale"]
FPS        = CONFIG["fps"]
ACTIONS    = CONFIG["actions"]

# 8 directions: camera angle (radians) → suffix
DIRECTIONS = [
    (0.0,             "e"),
    (math.pi / 4,     "se"),
    (math.pi / 2,     "s"),
    (3 * math.pi / 4, "sw"),
    (math.pi,         "w"),
    (5 * math.pi / 4, "nw"),
    (3 * math.pi / 2, "n"),
    (7 * math.pi / 4, "ne"),
]

assert len(sys.argv) > 1, "No .blend file provided"
BLEND_PATH = bpy.data.filepath
assert BLEND_PATH != "", "Save the .blend file first before running batch_render.py"


# ---------------------------------------------------------------------------
# Scene setup
# ---------------------------------------------------------------------------

def setup_scene():
    scene = bpy.context.scene
    scene.render.engine = ENGINE
    scene.render.resolution_x = RES_X
    scene.render.resolution_y = RES_Y
    scene.render.resolution_percentage = 100
    scene.render.image_settings.file_format = "PNG"
    scene.render.image_settings.color_mode = "RGBA"
    scene.render.image_settings.compression = 15
    scene.render.fps = FPS
    scene.render.film_transparent = True

    if ENGINE == "BLENDER_EEVEE":
        scene.eevee.taa_render_samples = 64
        scene.eevee.use_fast_gi = True

    scene.frame_start = 1
    scene.frame_end = 1


def create_cameras():
    """Create 8 orthographic cameras arranged in a circle."""
    cam_collection = bpy.data.collections.new("_render_cameras")
    bpy.context.scene.collection.children.link(cam_collection)

    cameras = []
    for angle_rad, suffix in DIRECTIONS:
        x = CAM_DIST * math.cos(angle_rad)
        y = CAM_DIST * math.sin(angle_rad)

        cam_data = bpy.data.cameras.new(f"cam_{suffix}")
        cam_data.type = "ORTHO"
        cam_data.ortho_scale = ORTHO_SCALE
        cam_data.clip_start = 0.1
        cam_data.clip_end = 100.0

        obj = bpy.data.objects.new(f"cam_obj_{suffix}", cam_data)
        obj.location = (x, y, CAM_HEIGHT)
        cam_collection.objects.link(obj)

        track = obj.constraints.new(type="TRACK_TO")
        track.target = bpy.data.objects.new(f"empty_{suffix}", None)
        track.target.location = (0, 0, 0)
        track.track_axis = "TRACK_NEGATIVE_Z"
        track.up_axis = "UP_Y"
        cam_collection.objects.link(track.target)

        cameras.append((suffix, obj))

    return cameras


def delete_render_cameras():
    """Remove previously created render cameras (for re-runs)."""
    for obj in list(bpy.data.objects):
        if obj.name.startswith("cam_") or obj.name.startswith("empty_"):
            bpy.data.objects.remove(obj, do_unlink=True)
    for coll in list(bpy.data.collections):
        if coll.name == "_render_cameras":
            bpy.data.collections.remove(coll)


# ---------------------------------------------------------------------------
# Actions
# ---------------------------------------------------------------------------

def get_action(name):
    """Find an action by name, case-insensitive."""
    for action in bpy.data.actions:
        if action.name.lower() == name.lower():
            return action
    return None


def get_frame_range(action):
    """Return (start, end+1) integer frame range for an action."""
    return int(action.frame_range[0]), int(action.frame_range[1]) + 1


# ---------------------------------------------------------------------------
# Rendering
# ---------------------------------------------------------------------------

def render_animation(anim_name, action, cameras):
    """Render all frames of an action from 8 camera angles."""
    scene = bpy.context.scene
    frame_start, frame_end = get_frame_range(action)
    total_frames = frame_end - frame_start

    print(f"\n  Rendering '{anim_name}' ({total_frames} frames × 8 directions)")

    for frame in range(frame_start, frame_end):
        scene.frame_set(frame)
        for suffix, cam_obj in cameras:
            scene.camera = cam_obj

            filename = f"{anim_name}_{suffix}_{frame:04d}.png"
            filepath = os.path.join(OUTPUT_DIR, filename)
            scene.render.filepath = filepath

            bpy.ops.render.render(write_still=True)

        progress = ((frame - frame_start + 1) / total_frames) * 100
        print(f"    {anim_name}: {frame - frame_start + 1}/{total_frames} ({progress:.0f}%)")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    print(f"\n=== Batch Render: {CHAR} ===")
    print(f"  Output: {OUTPUT_DIR}")
    print(f"  Engine: {ENGINE}")
    print(f"  Resolution: {RES_X}×{RES_Y}")
    print(f"  FPS: {FPS}")
    print(f"  Camera distance: {CAM_DIST}, height: {CAM_HEIGHT}")
    print(f"  Ortho scale: {ORTHO_SCALE}")

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    setup_scene()
    delete_render_cameras()
    cameras = create_cameras()

    rendered_any = False
    for action_cfg in ACTIONS:
        action_name = action_cfg["name"]
        action = get_action(action_name)
        if not action:
            print(f"  ⚠ Action '{action_name}' not found in .blend — skipping")
            continue
        rendered_any = True
        render_animation(action_name, action, cameras)

    delete_render_cameras()

    if not rendered_any:
        print("  ⚠ No actions were rendered!")
        print(f"  Available actions: {[a.name for a in bpy.data.actions]}")
        sys.exit(1)

    print(f"\n✓ Done! Files written to: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
