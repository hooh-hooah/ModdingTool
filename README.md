# Introducing hooh Modding Tools

## What is this?

hooh Modding tool is an Unty Editor Project that has almost everything to mod ILLUSION's game AI-shoujyo. 

This modding tool's base has been created by roy12 and I added some nice easy-to-use modding tool to make everyone's life easier. 

## How to use it?

1. Clone Repository

   You can clone this project by clicking download as zip or by using git command `git clone` either way you can see whole commands in top-right green button.

2. Open Editor

   You need to open this project with Unity Editor in order to make your mods. If you don't have Unity Editor yet I suggest you to download **Specific Version of Unity Editor** to use it.

   AI-Shoujo is currently using *2018.4.11f1* Version of Unity Engine. 

3. Try Examples

   There is plenty of examples to play with. If you have some time and see how it's working, I suggest you to play with hooh's Modding Tools.

## Things to know

- You can edit most of my shaders with Amplify Shader Editor which is paid tool made by Amplify Studio. You can get this tool from Unity Asset Store. If you want to make nice good shaders I suggest you to purchase it.

- Dynamic Bone is actually paid component. **Do NOT use this component to make your game/make profit out of this files** unless you have legit copy from Unity Asset Store.

  This components are just included just to resolve dependency between game and editor tools. I will not take any responsibility with using this code without getting legit copy.

- You can checkout tutorials from [this repository](https://github.com/hooh-hooah/AI_Tips/tree/master/mods). If you don't get how to use this tool at all, I suggest you to look at this page to understand what this tool capable of.

## Modding Tool Components

### ID Generator

This tool is used to generate item list for mod.xml

### Unity Macros

This tool is made to save your time.

### Mod Scaffolding

This tool make your gameobject compatible with AI shoujo.

### Assetbundle Builder

You can still build your assetbundles in traditional way. 

### Roy's Honey Select Tools

If you're having some trasnparent render queue issue, here is some good tools that called Roy's Honey Select Tools

### FBX Import Fix

This is automatically applied to all fbx files that meets certain criteria:

- "clothmesh.fbx"

## Trouble Shooting

### Mod Building Error

#### System.IO.FileNotFoundException

Check if your assetbundle path contains uppercase. Unity Editor AssetBundle Creator seems don't like any uppercase in assetbundle path.

#### DirectoryNotFoundException: Could not find a part of...

This error mostly occurs when your assetbundle is not valid. 

Check if you included all the files correctly in assetbundle.

#### Cannot find index of *

#### Failed to parse mod information

There is two possibilities.

1. There is no mod.xml file in "Project" Tab. 

   in this case, you can just open where mod.xml file is or just make new one from that folder.

2. mod.xml file is invalid or has wrong syntax. You can check your xml's syntax from your IDE or [XML Validation Online](https://www.xmlvalidation.com/)

### In-Game Error

#### I can't see my mod in the game

Please go through this checklist below

1. Was "ZIPNAME" `<build name="ZIPNAME">`  in mod.xml unique?

2. Is guid unique to other mods?

3. have you correctly assigned name?

   There is few naming restriction on studio list file. 

   - Category's filename should be unique

   - Category's filename should follow these regex:

     - Big Category: `ItemGroup_GGGG`

       GGGG should be ***Part of mod.xml's GUID***
       For example if guid is `<guid>modbuilder.example.stditem</guid>`
       ItemGroup file's name should be `abdata/studio/info/stditem/ItemGroup_stditem.csv`

     - Mid Categroy: `ItemCategory_YYY_XXXX

       XXXX Should be big category's number

       YYY Should be number

     - ItemList: `ItemList_ZZZ_XXXX_YYY`

       XXXX Should be big category's number

       YYY Should be Mid Category's number

       ZZZ Should be number

4. Did the file updated?

   Zip & Deploy process cannot be done if computer is in these state:

   - Too busy to do any process
   - If the game is open
   - If the zip file is in use (like opening the zipfile in any process)
   - Mod Build Failed

#### I can see my mod but it won't load when I click it

This is mostly caused wrong setup of your game object.

1. The clothes does not have CmpComponents. 

   You can initialize most of things by clicking Initialize xxxx

2. You forgot something

   Do your clothes scaled properly? Everything should be 1

   Do your gameobject has mesh renderers?