### Unofficial Thunderbird Nightly flatpak

## Install

1. Install [flatpak](https://flatpak.org/setup/) (>=0.11.1), [xdg-desktop-portal](https://github.com/flatpak/xdg-desktop-portal) and its [backends](https://github.com/flatpak/xdg-desktop-portal#using-portals). Latest versions are preferred.

2. Add the [Flathub](https://flathub.org/setup) repository if absent

3. Install this package

```bash
# System
flatpak install https://gitlab.com/projects261/thunderbird-nightly-flatpak/-/raw/main/thunderbird-nightly.flatpakref

# User
flatpak install --user https://gitlab.com/projects261/thunderbird-nightly-flatpak/-/raw/main/thunderbird-nightly.flatpakref
```

## Uninstall

```bash
# Only remove
flatpak remove org.mozilla.ThunderbirdNightly

# Delete data and remove
flatpak remove --delete-data org.mozilla.ThunderbirdNightly

# Clear dependencies
flatpak uninstall --unused

# Delete the remote
flatpak remote-delete thunderbirdnightly-origin
```

## Bugs

Check if it is already a known issue first https://bugzilla.mozilla.org/show_bug.cgi?id=1290670

Check if it is reproducible in the official tarball (preferably in a new profile or safe mode). If it is, open a bug with Mozilla, optionally use [mozregression](https://mozilla.github.io/mozregression/quickstart.html) to bisect it.

Otherwise feel free to open an issue here.

## Credits

Mozilla for mainlining the stable flatpak recipes.

Original Nightly flatpak project https://gitlab.com/proletarius101/firefox-nightly-flatpak and CI templates https://gitlab.com/accessable-net/gitlab-ci-templates

Logo: [Source](https://www.creativetail.com/40-free-flat-animal-icons/), [License](https://www.creativetail.com/licensing/)

## Set up personal repo

See https://docs.flatpak.org/en/latest/hosting-a-repository.html#hosting-a-repository-on-gitlab-github-pages

## Build locally

1. Clone this repository

```bash
git clone https://gitlab.com/projects261/thunderbird-nightly-flatpak.git && cd thunderbird-nightly-flatpak
```

2. Install flatpak, [flatpak-builder](https://docs.flatpak.org/en/latest/flatpak-builder.html) and set up the Flathub repository
on `user` location.

3. Run this command to build and install

```bash
flatpak-builder build --force-clean --user --install-deps-from=flathub --install org.mozilla.ThunderbirdNightly.yaml
```

4. To update, change this [URL](https://gitlab.com/projects261/thunderbird-nightly-flatpak/-/blob/7816a3f02cf236c9678943b7f82dbedbf5087899/org.mozilla.ThunderbirdNightly.yaml#L110) to point to the latest release and update the [sha256](https://gitlab.com/projects261/thunderbird-nightly-flatpak/-/blob/7816a3f02cf236c9678943b7f82dbedbf5087899/org.mozilla.ThunderbirdNightly.yaml#L111) below. Then redo step #3.
## Signature

GPG key used to sign repo: F8A5F798CA257770

You can verify the key used, using

```bash
gpg --no-default-keyring --keyring=</var/lib | ~/.local/share>/flatpak/repo/thunderbirdnightly-origin.trustedkeys.gpg --lock-never --list-keys
```

and even create the keyring yourself using:

```bash
gpg --no-default-keyring --keyring ./thunderbirdnightly-origin.trustedkeys.gpg --keyserver keyserver.ubuntu.com --recv-keys F8A5F798CA257770

mv thunderbirdnightly-origin.trustedkeys.gpg </var/lib | ~/.local/share>/flatpak/repo
```

### Expired

If `flatpak` says that the key is expired, try removing the repo using

```bash
flatpak remote-delete --force thunderbirdnightly-origin
```

then add it back again.
