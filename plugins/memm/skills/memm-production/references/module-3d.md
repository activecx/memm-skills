# Module: 3D models

- Read each 3D model's modes in `memm_list_models`: text, one photo, or several photos of the **same** object, with their named views where required. Some models need views in a fixed order (for example front, left, back, right without gaps); pass `image_views` in the same order as `image_urls`.
- In photo modes the prompt is only a title and does not change the geometry.
- Rigging and pose: only the options that offer rigging produce a rigged model; `pose_mode` (`a-pose` or `t-pose`) applies only where the catalogue says so.
- 3D jobs return a job; poll about every 20 seconds. The result has `modelUrl`, `modelFormat` (GLB or FBX), a preview and a download link. 3D jobs cannot go in a batch.
- Product accuracy: a photo-based 3D model approximates the product; label text and fine details are often not exact. Say so before the user relies on it for packaging.

## QA focus

Open the preview (and the model in a viewer when available): the shape matches the photos, no missing or melted parts, the textures sit correctly, the format is the one requested.
