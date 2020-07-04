<center>
  <a href="#"><img src="https://i.imgur.com/gKt64bk.png" alt="Logo"></a>
  <h4 align="center">a modern iOS apt repository template</h4>
</center>

<a href="#"><img src="https://i.imgur.com/y4oV9VV.png" alt="colored line"></a>

This template contains samples on how you can easily make depiction pages without replicating your html pages.</br>
The Cydia pages are styled using [Bootstrap](https://getbootstrap.com), and the Sileo pages are styled using JavaScript Object Notation (JSON).</br>
If you use web depictions / Reposi3, Sileo now converts web depictions to native depictions in **realtime**.

This guide does **NOT** cover creating .deb files, *but will briefly cover assiging depictions*, please do not ask about debian files, that is for development. This is simply here to get you started on making a base apt repository.
<a href="#"><img src="https://i.imgur.com/y4oV9VV.png" alt="colored line"></a>

### Steps
### 1. APT-FTPArchive

You **must** have apt-ftparchive on your operating system to use repo.me. This can be solved on Windows via WSL. My subsystem OS is Debian, which I know does contain apt-ftparchive. This can be solved on macOS via Diatrus' precompiled version (downloaded automatically via `updaterepo.sh`, and perms will be set automatically as well) 
</br>
You **must** have wget, zstd, xz, bzip2, & gzip installed on macOS. Use [Homebrew](https://brew.sh) on macOS to install the dependencies. ***This isn't a homebrew installation tutorial, read the website.***

### 2. Download / Fork repo.me

If you are *not* hosting your repo on [Github Pages](https://pages.github.com/), you can download the zip file [here](https://github.com/syns/repo.me/archive/master.zip) and extract to a subfolder on your website.

There are 2 options for those using [Github Pages](https://pages.github.com/).

A. If you want to use your root `username.github.io` as your repo, fork this repo and rename it to `username.github.io`. So when adding it in your Package Manager of choice, use `https://username.github.io`.

B. If you want to use a subfolder for your existing `username.github.io` as your repo (example `username.github.io/repo`), fork this repo and rename it to `repo`. So when adding it in your Package Manager of choice, use `https://username.github.io/repo`.

You can change `repo` to anything you want, like `cydia` for example. So your repo URL would be `https://username.github.io/cydia`.

### 3. Personalize

**Release File**

Modify `repo.conf` in ./assets/repo by changing the labels: </br>
`ORIGIN_HERE`, `LABEL_HERE`, `CODENAME_HERE`, and `DESCRIPTION_HERE` </br>

`updaterepo.sh` will take care of the Release file after modifying the config. So you're now finished regarding `Release`.

**Branding**

Please check `index.html` for what lines need to be changed! ***Note: You do not need to use the included `index.html`*** </br>
Add a "CydiaIcon.png" for your APT Repository Logo. ***This is not a design tutorial, it should be relatively self-explanatory***.

**Page Footers**

The data below are the links that appear at the bottom of every **Webview / Cydia Depiction**. The data is stored in `repo.xml` at the root folder of your repo. </br>

```xml
<repo>
    <footerlinks>
        <link>
            <name>Follow me on Twitter</name>
            <url>https://twitter.com/truesyns</url> # Feel free to swap your twitter in for this! 
            <iconclass>glyphicon glyphicon-user</iconclass>
        </link>
        <link> # You can remove this if you wish, however if I may, please do not do so! It will allow others to find repo.me such as you have!
            <name>I want this depiction template</name> 
            <url>https://github.com/syns/repo.me</url>
            <iconclass>glyphicon glyphicon-thumbs-up</iconclass>
        </link>
    </footerlinks>
</repo>
```

#### 4. _Almost_ ready.
At this point your repo is basically ready to be added into your Package Manager of choice. </br>
You can visit your repo's homepage by going to `https://username.github.io/repo/`. </br>
Next guide will show you how to assign and customize your depiction pages.

<a href="#"><img src="https://i.imgur.com/y4oV9VV.png" alt="colored line"></a>

### Depictions
### 1.1 Adding a simple depiction page (Web Folder / Cydia)

Go to the depictions folder and duplicate the folder `me.syns.oldpackage`. </br>
Rename the duplicate with the same name as your package name. </br>
There are 2 files inside the folder - `info.xml` and `changelog.xml`. </br>
Update the 2 files with information regading your package. </br>
The tags are pretty much self-explanatory. </br>
Contact [@truesyns](https://twitter.com/truesyns) for questions.

`info.xml`.
```xml
<package>
    <id>me.syns.oldpackage</id>
    <name>Old Package</name>
    <version>1.0.0-1</version>
    <compatibility>
        <firmware>
            <miniOS>5.0</miniOS>
            <maxiOS>7.0</maxiOS>
            <otherVersions>unsupported</otherVersions>
            <!--
            for otherVersions, you can put either unsupported or unconfirmed
            -->
        </firmware>
    </compatibility>
    <dependencies></dependencies>
    <descriptionlist>
        <description>This is an old package. Requires iOS 7 and below..</description>
    </descriptionlist>
    <screenshots></screenshots>
    <changelog>
        <change>Initial release</change>
    </changelog>
    <links></links>
</package>
```

`changelog.xml`.
```xml
<changelog>
    <changes>
        <version>1.0.0-1</version>
        <change>Initial release</change>
    </changes>
</changelog>
```
### 1.2 Adding a simple depiction page (Native Folder / Sileo)

Go to the /depictions/native/me.syns.samplepackage and copy the file `depiction.json`. </br>
Move into a folder labeled as your package name. </br>
Edit The Labeled Parts (i.e. VERSION_NUMBER, TWEAK_NAME, etc.) or use the Sileo Depiction Generator by [@M4cs:](https://twitter.com/maxbridgland) [SileoGen](https://sileogen.com/). </br>
Contact [@truesyns](https://twitter.com/truesyns) for questions.

#### 2. Link the depiction page in your tweak's `control` file

You can add the depictions url at the end of your package's `control` file before compiling it. </br>
The depiction line should look like this:

```text
Depiction: https://username.github.io/repo/depictions/web/?p=[idhere]
```

Replace `[idhere]` with your actual package name.

```text
Depiction: https://username.github.io/repo/depictions/web/?p=me.syns.oldpackage
```
For Sileo Depictions, add the SileoDepiction key alongside the Depiction in your `control` file before compiling it.

```text
SileoDepiction: https://username.github.io/repo/depictions/native/me.syns.samplepackage/depiction.json
````

#### 3. Rebuilding the `Packages` file

The `Packages` file is handled by `updaterepo.sh`. Windows users should be using WSL (I use Debian), Linux users should be
checking for apt-ftparchive, and macOS (10.10+) users should be using Diatrus' [recompiled version of apt-ftparchive](https://apt.procurs.us/apt-ftparchive) (this is now automatically downloaded via `updaterepo.sh` and perms will automatically be set for apt-ftparchive to work on macOS). macOS users will be asked for their password when running this, this is due to `sudo`, the perms are changed after apt-ftparchive is automatically pulled via wget, but not without you entering your password. 


#### 5. Repository at last!

If you haven't done yet, go ahead and add your repo to your package manager. </br>
You should now be able to install your tweak from your own repo.

<a href="#"><img src="https://i.imgur.com/y4oV9VV.png" alt="colored line"></a>

## Sileo Extras

These are some extra things that can make your repository look even better on Sileo.

### Featured Packages (`sileo-featured.json`)

Change The Following Lines:
```
 "url": "https://raw.githubusercontent.com/syns/repo.me/master/assets/Banners/RepoHeader.png", <---- The Package Banner
        "title": "Sample Package", <---- Your Package Name
        "package": "me.syns.newpackage", <---- The Actual Package
```
  <p align="center">Special Thanks and Credits to: <a href="https://github.com/Supermamon/">Supermamon</a> for <a href="https://github.com/supermamon/Reposi3">Reposi3</a> (the base) & <a href="https://twitter.com/Diatrus/">Diatrus</a> for apt-ftparchive on macOS.</p>
</center>
