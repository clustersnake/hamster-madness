"""
Blender Static 8-Direction Renderer (Test)
Renders 1 frame from 8 orthographic cameras.
Useful for validating lighting, scale, and model orientation.
"""

import argparse
import json
import os
import math
import sys

import bpy


argv = sys.argv
if "--" in argv:
    argv = argv[argv.index("--") + 1:]
else:
    argv = []

parser = argparse.ArgumentParser()
parser.add_argument("--config", type=str, required=True)
parser.add_argument("--outdir", type=str, default=None,
    help="Override output directory (default: uses sprites_test/ next to sprites/)")
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

if args.outdir:
    OUTPUT_DIR = args.outdir
else:
    OUTPUT_DIR = os.path.join(os.path.dirname(OUTPUT_DIR), "sprites_test")

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


def setup_scene():
    scene = bpy.context.scene
    scene.render.engine = ENGINE
    scene.render.resolution_x = RES_X
    scene.render.resolution_y = RES_Y
    scene.render.resolution_percentage = 100
    scene.render.image_settings.file_format = "PNG"
    scene.render.image_settings.color_mode = "RGBA"
    scene.render.image_settings.compression = 15
    scene.render.film_transparent = True

    if ENGINE == "BLENDER_EEVEE":
        scene.eevee.taa_render_samples = 64
        scene.eevee.use_fast_gi = True


def create_cameras():
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
    for obj in list(bpy.data.objects):
        if obj.name.startswith("cam_") or obj.name.startswith("empty_"):
            bpy.data.objects.remove(obj, do_unlink=True)
    for coll in list(bpy.data.collections):
        if coll.name == "_render_cameras":
            bpy.data.collections.remove(coll)


def main():
    print(f"\n=== Static Render Test: {CHAR} ===")
    print(f"  Engine: {ENGINE}")
    print(f"  Resolution: {RES_X}×{RES_Y}")
    print(f"  Ortho scale: {ORTHO_SCALE}")
    print(f"  Camera distance: {CAM_DIST}, height: {CAM_HEIGHT}")

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    setup_scene()
    delete_render_cameras()
    cameras = create_cameras()

    scene = bpy.context.scene
    scene.frame_set(1)

    for suffix, cam_obj in cameras:
        scene.camera = cam_obj
        filename = f"{CHAR}-{suffix}.png"
        filepath = os.path.join(OUTPUT_DIR, filename)
        scene.render.filepath = filepath
        bpy.ops.render.render(write_still=True)
        print(f"  ✓ {filename}")

    delete_render_cameras()
    print(f"\n✓ Test renders written to: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
