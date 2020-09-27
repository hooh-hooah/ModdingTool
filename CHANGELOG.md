# Changelog

## 0.5.0

### 2020-09-27

-   Changed archiving method: Removed `7z` dependency `7z Instance` → `SharpZipLib DLL Library`.
-   New modding tool document is now available in [the Official AIHS Modding Tool Document Site](http://hooh-hooah.github.io/)
-   Added Studio Item Thumbnail Generator
-   Added and Integrated Image Compression Library with Item Thumbnail Generator
-   Reworked and Improved Mod Packer.
    -   All Mod Packing/Validation has moved to the `SideloaderMod` class.
    -   Legacy Mod XML is compatible. But it is recommended to do little work to legacy mods.
    -   Improved Mod XML and Asset Validation. Now it can detect resolved AssetBundles when you make new Mod Packer Class
    -   Improved Automation and Quality of Life Changes.
    -   Added Material Editor Support and Automation
    -   Added Dependency Loader Automation
-   XML Helper has moved to the part of `SideloaderMod` class
-   Changed mod packer's archive option to `Stored`. The Loading Performance has been greatly improved compared to the last method.
-   Optimized the Modding Tool's GUI Performance.
    -   Now, AI/HS2 Inspectors Repaint when the content has changed.
    -   Changed all button events to delegate to prevent GUI Stack Failure
-   Added various ILLUSION shader preview
-   Added Map Info automatic initialization
-   Added Various Accessory Automatic initialization
-   Added Map Event Automatic Generation and Packing (All automatic, no interaction is needed)
-   Improved Clothing Testing Methods. Now it's not dependent to the scene. Now it's a just prefab
-   Added ADV Dump Function (For Advanced Developers)
-   Removed Legacy Mod Packer Code
-   Reduced Warning Error Logs
-   Added Developer Utility Extensions
-   Updated Hanmen's new Shader Replica

... You can check more informations about changes and how to use the new feature in [the Official AIHS Modding Tool Document Site](http://hooh-hooah.github.io/).


## 0.4.2

### 2020-07-23

-   Added Dependency Loader Support
-   Added HS2 Map Support
-   Added HS2 Map Component Inspector
-   Changed ModPacker into modular structure.
-   Overall performance improvements.
-   Added Hanmen's ILLUSION Clothing Replica Shaders

## 0.4.1 - beta

### 2020-07-05

-   Reworked ColorableObjects shader. It's now can be used for Accessory and Studio Items.
-   Added Thumbnail Generator.
-   Reworked XML Helper and it's less confusing now.
-   Added Accessory Component Custom Inspector.
-   Fixed ItemComponents are being weird.
-   Reworked Mod Files Validator.

## 0.4.0 - alpha

### 2020-07-02

-   Improved Asset Building w/ Validating Assets in .xml files.
-   Added SetName, SetNameSequence for Unity Macro.
-   Now Wrap Object with Parent respects target's parent.
-   Fixed Foldout Style Fuckery.
-   Updated Hair Preview - Now you can preview your hair and texutres in Editor.
-   Added BaseBoneNavigator.

### 2020-06-28

-   Updated Engine's Version to HS2's Unity Engine Version (2018.4.11f)
    -   **Do not upgrade version with unity's feature. re-import everything so your stuffs are not going to break.**
-   Added Preview Alpha
    -   Now you can preview your right without launching the game with binding helper.
    -   Binding helper will be combined with skin preview components.
    -   In the end it will be all-in-one preview system in one or two months.
-   Re-designed Component Inspector
    -   Now it's more easier to manage your mod's component.
-   Reduced Human Error with more automated tasks
-   Moved Mod Component Initializing into Tranform Component Inspector.
-   Added and refined the examples
-   Added Animation Example (Warning, it's really rough atm)
-   Added Bunch of Macros and UI Improvements
-   Initial Support for HS2 In-game Map Components - It works technically.
-   Added Anisotrophic shader alpha.
-   Removed unused and big files from the project.

#### What's about to come?

-   **Complete Animation Workflow**
-   **Migrating mod configuration into ScriptableObject from mod.xml**
-   **Better UI**
-   **All-in-one Editor Preview System that almost identical to ILLUSION's Loading Code.**

## 0.3.0

### 2020-02-29

-   Changed Clothing Initializer's Class Target to SkinnedMeshRenderer from MeshRenderer
-   Added new targets for Clothing Targets
    -   TODO: Make it modular to make users can customize targets with regex support.
-   Added Automatic Dynamic Bone Initializer
    -   WARNING: It will remove existing dynamic bones of the object automatically.
    -   TODO: Make it only remove automatically added dynamic bones.
-   Resolved CSVBuilder's Same-named Asset Naviation Issue.
-   Added FK Bone List support for CSVBuilder.
-   Changed UI Little Bit
-   Added Animation List Generator. It will fill out ItemComponent's Animation List based on Object's Animation Controllers.
-   Added ModPack Testing method.
-   Changed Temporary Folder location for zipping mod.
-   WIP: XML Inspector...
-   Merged Light Probe Intensity Adjustment into hooh's Tool Window.
-   Material generation for hair mods is changed.
-   Added XML Touch Tool for mod.xml Manipulation.
-   Changed few shader's name.
-   Added few shaders.
    -   Colorable Objects

## 0.2.1

### 2020-01-30

-   Fixed Hair Render Object setup fuckery
-   Now SB3U ScriptBuilder will include shader value adjustment.
-   Added Deploy Mode for ModPacker (good for just checking things and debugging)
-   Now you can add bone informations for your items.
-   Now List Generator automatically put list items in mod.xml

## 0.2.0

### 2020-01-09

-   Moved Light Probe Intensity tool to hooh Modding Tool Window.
-   Now Foldout status are being saved after closing editor/updating code.

### 2020-01-08

**Hair mod.xml template has been changed! be aware.**

-   Changed FBXAssetProcessor: Added few name targets.
    -   "shoesmesh.fbx"
-   Added Foldout sections. Now you can fold stuffs
-   Moved Mod Scaffolding into separate class.
-   Combined error messages that you get when you try to execute modding tool function without selecting anything.
-   Moved Manifest Building into separate class.
-   Now hooh Modding Tool supports Heelz Mod. You can make heels mode with hooh Modding Tool
-   Removed Bandizip Dependency. Now you don't have to use bandizip to build mods. Good Riddance.
-   Moved Material Swapping into separate class.
-   Now texture swap is optional.
-   Now alerts you when there is no mod.xml in current Project Folder.
-   Made Probe Intensitry public. It's going to be combined in same menu.
-   Added a lot of examples.

## 0.1.0

### 2020-01-07

-   Now you can build mod with ONE button.
-   Changed CSVBuilder Structure: Now it's using key-based delegates instead of category based delegates.
-   Changed FBXAssetProcessor: Added few name targets.
-   Enhanced Hair Component Initialization Tool.
    -   Now it initializes dynamic bones automatically.
    -   Now it initializes hair preview tools automatically.
-   Example: Added Skin Paint Example.
-   Added Open Folder Option when modbuilder completes mod build.
    -   When you click Open Folder, it will open your zipmod destination folder.
-   Example: Updated hair example.
    -   Updated mod.xml comments and structure.
    -   Updated blender source files.
    -   Changed noise.png to 2x res noise texture.
-   Updated Shader Code.
    -   You can use Opaque Shader when you're making non-transparent clothes that will not torn. useful things like socks or small clothes.
    -   Now Glossiness and Metalic adjustments are working.
-   Added Changelogs.
