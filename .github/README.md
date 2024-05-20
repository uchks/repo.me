<p align="center">
  <img align="center" src="https://i.imgur.com/RcY9qnM.png" alt="Logo" height="300">
</p>

> [!NOTE]  
> I'm actively looking for contributors! I no longer keep up with the jailbreak scene.

## Table of Contents
1. [Background Information](#background-information)  
2. [Setup](#setup)  
    - [Dependencies](#dependencies)  
    - [Download / Fork repo.me](#download--fork-repome)  
    - [Personalization](#personalization)  
        - Branding
        - Page Footers
        - Depictions 
            - [Webview / Cydia Depictions](#webview--cydia-depictions)  
            - [Native / Sileo Depictions](#native--sileo-depictions)  
            - [Linking the Depiction](#linking-the-depiction)  
3. [Sileo "Extras"](#sileo-extras)

### Background Information
repo.me was created to help new tweak developers. The goal was to make it easy to maintain a personal repository and show their work to the community. Unfortunately, it didn't gain much traction, for contributing that is. Only two people contributed, and that was a long time ago. Since then, it has been inactive while the jailbreaking community moved on. Now, it's just a side project for me, still meant to help new developers and keep community standards.

This template shows how you can easily make depiction pages without copying your HTML pages.
The Cydia pages use [Bootstrap](https://getbootstrap.com), and the Sileo pages use JSON.
If you use web depictions, Sileo now converts web depictions to native depictions in real-time.

This guide does **NOT** cover creating .deb files but will briefly cover assigning depictions. It is just to help you start making a base APT repository.

Found something that can be improved? Found a mistake? Please make a pull request!

### Setup

#### Dependencies
1. **`apt-ftparchive`**
    - For Windows, it will automatically be downloaded.
    - For macOS, install via Procursus `apt-utils`; otherwise, it will be automatically downloaded.
    - For iOS / iPadOS, install via Procursus `apt-utils` (Elucubratus users, this is not verified).

2. **`wget, zstd, xz, lz4, & gpg`**
    - The script will automatically check for homebrew / Procursus installation and dependencies. If not found, don't worry; everything will be taken care of for you.

#### Download / Fork repo.me
If you are _not_ hosting your repository on [GitHub Pages](https://pages.github.com/), you can download the zip file [here](https://github.com/uchks/repo.me/archive/master.zip) and extract it to a subfolder on your website.

There are two options for those using [GitHub Pages](https://pages.github.com/):

A. If you want to use your root `username.github.io` as your repo, fork this repo and rename it to `username.github.io`. Then, when adding it to your Package Manager of choice, use `https://username.github.io`.

B. If you want to use a subfolder for your existing `username.github.io` as your repo (e.g., `username.github.io/repo`), fork this repo and rename it to `repo`. Then, when adding it to your Package Manager of choice, use `https://username.github.io/repo`.

#### Personalization

**Branding**

I, uchks, do not do frontend. Provided to you is Reposi3's frontend. You don't need to use it if you know what you're doing. Otherwise, check `index.html` for the lines that need to be changed!

Add a "CydiaIcon.png" for your APT Repository Logo.
**_This is not a design tutorial; it should be relatively self-explanatory._**

**Page Footers**

The data below are the links that appear at the bottom of every **Webview / Cydia Depiction**. The data is stored in `repo.xml` at the root folder of your repository.

```xml
<repo>
    <footerlinks>
        <link>
            <name>Follow me on X</name>
            <url>https://x.com/uchkence</url> # Feel free to swap your X in for this!
            <iconclass>fa-brands fa-x-twitter</iconclass>
        </link>
        <link> # You can remove this if you wish, however if I may, please do not do so! It will allow others to find repo.me such as you have!
            <name>I want this depiction template</name>
            <url>https://github.com/uchks/repo.me</url>
            <iconclass>fa-solid fa-thumbs-up</iconclass>
        </link>
    </footerlinks>
</repo>
```

**Depictions**
##### Webview / Cydia Depictions
Go to the depictions folder and duplicate the folder `com.example.sample`.
Rename the duplicate with the same name as your package name.
There are two files inside the folder - `info.xml` and `changelog.xml`.
Update the two files with information regarding your package.
The tags are pretty much self-explanatory.
Contact [hi@air.rip](mailto:hi@air.rip) for questions.

`info.xml`

```xml
<package>
    <id>com.example.sample</id>
    <name>Sample</name>
    <version>1.0.0</version>
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

`changelog.xml`

```xml
<changelog>
    <changes>
        <version>1.0.0</version>
        <change>Initial release</change>
    </changes>
</changelog>
```

##### Native / Sileo Depictions
Go to the `/depictions/native/com.example.sample` folder and copy the file `depiction.json`.
Move it into a folder labeled as your package name.
Edit the labeled parts (i.e., VERSION_NUMBER, TWEAK_NAME, etc.).
Contact [hi@air.rip](mailto:hi@air.rip) for questions.

#### Linking the Depiction
You can add the depictions URL at the end of your package's `control` file before compiling it.
The depiction line should look like this:

```text
Depiction: https://username.github.io/repo/depictions/web/?p=[idhere]
```

Replace `[idhere]` with your actual package name.

```text
Depiction: https://username.github.io/repo/depictions/web/?p=com.example.sample
```

For native depictions, add the `SileoDepiction` key alongside the `Depiction` in your `control` file before compiling it.

```text
SileoDepiction: https://username.github.io/repo/depictions/native/com.example.sample/depiction.json
```

With your updated `control` file, build your tweak and store the resulting debian into the `/debians` folder of your repository.

The `Packages` file is handled by `updaterepo.sh`. macOS users will be asked for their password when running this due to `sudo`; the permissions are transmuted after `apt-ftparchive` is automatically pulled via wget, but not without you entering your password.

Push your changes and, if you haven't done so yet, go ahead and add your repository to your package manager.
You should now be able to install your tweak from your repository.

### Sileo "Extras"
**Featured Packages (`sileo-featured.json`)**

Change the following lines:

```json
 "url": "https://raw.githubusercontent.com/uchks/repo.me/master/assets/Banners/RepoHeader.png", // The Package Banner
 "title": "Sample Package", // Your Package Name
 "package": "com.example.sample" // The Actual Package
```

<p align="center">Special thanks and credits to: <a href="https://github.com/Supermamon/">Supermamon</a> for <a href="https://github.com/supermamon/Reposi3">Reposi3</a> (the base) & <a href="https://github.com/Diatrus/">Diatrus</a> for `apt-ftparchive` on macOS.</p>