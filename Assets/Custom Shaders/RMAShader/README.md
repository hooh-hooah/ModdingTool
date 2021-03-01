# What is this?
## RMA Shader
Roughness
Metallic
AmbientOcclusion Packed Shader

## How to pack?
You can merge textures with python and OpenCV. 
```python
import cv2
img_rough = cv2.imread(rough)
img_metal = cv2.imread(metal)
img_ao = cv2.imread(ao, 1)

if img_rough is not None and img_metal is not None:
    r, _, _ = cv2.split(img_rough)
    m, _, _ = cv2.split(img_metal)
    ao, _, _ = cv2.split(img_ao)

    w = np.ones(r.shape).astype(np.uint8) * 255
    b = np.zeros(r.shape).astype(np.uint8)

    img = cv2.merge((np.invert(r),m,ao,w))
    im_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2BGRA)
    Image.fromarray(im_rgb).save(result_name)
```