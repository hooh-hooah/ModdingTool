## Hanmen/Clothes True Replica Opaque
This shader is ASE replicated vanilla AIT/Clothes True

Featured all main features of the original + additional features.

### Render Queue:
2450

### NEW Additional Features:

This additional properties aims to implement full and easy PBR control over your materials that is lacked in the original shaders.

- Roughness1
- Roughness2
- Roughness3

This properties is separated from _Glossiness_ It controls the level of glossiness map contribution, if you want your material to be solid glossy turn corresponding Roughness level to 0, however if your material has the roughness in _MetallicGlossMap_ R channel, then set it to 1.

- MetallicMask1
- MetallicMask2
- MetallicMask3

This properties is separated from _Metallic_. Controls the level of metallic map contribution, if you want your material to be full metallic turn corresponding Metallic Roughness level to 0, however if your material has metallic roughness in _MetallicGlossMap_ B, then set it to 1.

###### SHADER KEYWORDS:

- #EmissionColor1 (Color1 is Emissive)
- #EmissionColor2 (Color2 is Emissive)
- #EmissionColor3 (Color3 is Emissive)
 
If checked overrides _EmissionColor_ with _Color_, _Color2_, _Color3_. This making possible to control the emission color in char maker. However, you still should set the _MetalliGlossMap_ G channel mask to enable emission. 
 
 
 
### Packing textures

**MainTex:** Basically this is a diffuse map, colorable parts should be grayscale. Alpha channel is also supported for cutoff.

**ColorMask:** This is basically the same as vanilla. _Color_ is black, _Color2_ is Red, _Color3_ is Green. It has additional Blue option, that cannot be changed in char maker, actually I reccomend to reserve it as a color protector, for example you can mark some colored parts on the diffuse map to make it maintain original diffuse colors like seams, prints, etc

**BumpMap:** Ordinary OpenGL normal map. The strength is controlled by _BumpScale_ 

**DetailMask:** This texture used for adding _DetailGlossMap_ masks. R - Detail Mask 1, G - Detail Mask 2, B - Detail Mask 3 (not used currently). The black parts are not affected, leave empty if you don't need detail bumps.

**DetailGlossMap:** Grayscale height map (bump map). Same as vanilla. The shader automatically generates and blends normal from it. UV scaling controlled by _DetailUV_. Masked by _DetailMask_ R channel. The strength is controlled by _DetailNormalMapScale_ 

**DetailGlossMap2:** Grayscale height map (bump map). Same as vanilla. The shader automatically generates and blends normal from it. UV scaling controlled by _DetailUV2_. Masked by _DetailMask_ G channel.  The strength is controlled by _DetailNormalMapScale2_ 

**MetallicGlossMap:** This is very important map, it's packed R channel for Glossiness, G for Emission Mask, B for Metallic.

**OcclusionMap:** This packed map, R - Occlusion map, B - Tearing mask for controlling the clothing break state in char maker. G is not used here. Controlled by _OcclusionStrength_.



### TODO (NOT WORKING FEATURES)

- Translucency
- Weathering Textures
- Dithering

