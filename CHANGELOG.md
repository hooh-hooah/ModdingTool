# Changelog

## 0.2.0

### 2020-01-09

- Moved Light Probe Intensity tool to hooh Modding Tool Window.
- Now Foldout status are being saved after closing editor/updating code.

### 2020-01-08

**Hair mod.xml template has been changed! be aware.**

- Changed FBXAssetProcessor: Added few name targets. 
  - "shoesmesh.fbx"
- Added Foldout sections. Now you can fold stuffs
- Moved Mod Scaffolding into separate class.
- Combined error messages that you get when you try to execute modding tool function without selecting anything.
- Moved Manifest Building into separate class.
- Now hooh Modding Tool supports Heelz Mod. You can make heels mode with hooh Modding Tool
- Removed Bandizip Dependency. Now you don't have to use bandizip to build mods. Good Riddance.
- Moved Material Swapping into separate class. 
- Now texture swap is optional.
- Now alerts you when there is no mod.xml in current Project Folder.
- Made Probe Intensitry public. It's going to be combined in same menu.
- Added a lot of examples.

## 0.1.0

### 2020-01-07

- Now you can build mod with ONE button.
- Changed CSVBuilder Structure: Now it's using key-based delegates instead of category based delegates. 
- Changed FBXAssetProcessor: Added few name targets. 
- Enhanced Hair Component Initialization Tool.
  - Now it initializes dynamic bones automatically.
  - Now it initializes hair preview tools automatically.
- Example: Added Skin Paint Example.
- Added Open Folder Option when modbuilder completes mod build.
  - When you click Open Folder, it will open your zipmod destination folder.
- Example: Updated hair example.
  - Updated mod.xml comments and structure.
  - Updated blender source files.
  - Changed noise.png to 2x res noise texture.
- Updated Shader Code.
  - You can use Opaque Shader when you're making non-transparent clothes that will not torn. useful things like socks or small clothes.
  - Now Glossiness and Metalic adjustments are working.
- Added Changelogs.

