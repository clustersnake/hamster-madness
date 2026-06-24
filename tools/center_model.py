"""
Centra el modelo en el origen (0,0,0) y ajusta ortho_scale.
Uso: Blender -> Window > Toggle System Console
      File > Open -> abrir el .blend
      Window > Toggle System Console
      Scripting workspace -> New -> pegar esto -> Run Script
      O desde terminal:
        blender turtle_toon.blend --python center_model.py
"""

import bpy
import os


def center_model():
    """Mueve todas las mallas para que el modelo quede centrado en (0,0,0)."""

    # --- 1. Calcular el centro del modelo ---
    min_x = min_y = min_z = float('inf')
    max_x = max_y = max_z = float('-inf')

    meshes = [obj for obj in bpy.data.objects if obj.type == 'MESH']

    for obj in meshes:
        for v in obj.data.vertices:
            world_v = obj.matrix_world @ v.co
            min_x = min(min_x, world_v.x)
            min_y = min(min_y, world_v.y)
            min_z = min(min_z, world_v.z)
            max_x = max(max_x, world_v.x)
            max_y = max(max_y, world_v.y)
            max_z = max(max_z, world_v.z)

    center_x = (min_x + max_x) / 2
    center_y = (min_y + max_y) / 2
    center_z = (min_z + max_z) / 2

    size_x = max_x - min_x
    size_y = max_y - min_y
    size_z = max_z - min_z
    max_dim = max(size_x, size_y, size_z)

    print(f"Bounds actuales:")
    print(f"  X: {min_x:.2f} a {max_x:.2f}  |  Y: {min_y:.2f} a {max_y:.2f}  |  Z: {min_z:.2f} a {max_z:.2f}")
    print(f"  Dimension máxima: {max_dim:.2f}")
    print(f"  Centro: ({center_x:.2f}, {center_y:.2f}, {center_z:.2f})")

    # --- 2. Mover TODOS los objetos (no solo mallas) ---
    for obj in bpy.data.objects:
        if obj.parent is None:  # solo objetos raíz
            obj.location.x -= center_x
            obj.location.y -= center_y
            obj.location.z -= center_z

    print(f"\n✓ Modelo centrado en el origen")
    print(f"  offset aplicado: ({-center_x:.2f}, {-center_y:.2f}, {-center_z:.2f})")

    # --- 3. Calcular ortho_scale recomendado ---
    # 80% del viewport
    ortho_80 = max_dim / 0.80
    # 90% del viewport
    ortho_90 = max_dim / 0.90

    print(f"\northo_scale recomendado para el config.json:")
    print(f"  80% del frame: {ortho_80:.1f}")
    print(f"  90% del frame: {ortho_90:.1f}")

    # --- 4. Sugerir camera_distance ---
    print(f"\ncamera_distance (debe ser > max_dim/2 = {max_dim/2:.1f}):")
    print(f"  Recomendado: {max_dim:.0f}")

    # Verificar que la cámara no haga clip
    print(f"\nclip_end debe ser > camera_distance + camera_height")
    print(f"  clip_end recomendado: {max_dim + 10:.0f}")


if __name__ == "__main__":
    center_model()

    # Guardar el archivo (sobrescribe el original)
    blend_path = bpy.data.filepath
    if blend_path:
        # Backup primero
        backup = blend_path + ".backup"
        import shutil
        shutil.copy2(blend_path, backup)
        print(f"\n✓ Backup guardado: {backup}")
        bpy.ops.wm.save_mainfile(filepath=blend_path)
        print(f"✓ Archivo guardado: {blend_path}")
    else:
        print("\n⚠ No hay archivo .blend abierto, no se guardó")
