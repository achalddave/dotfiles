# Setup

## Linux

`./setup.sh`

## Windows

For now, run `./setup.sh` from Cygwin

## Other Notes

* `helpers` is (unsurprisingly) a helper folder. I used to symlink all the
  config files, but this causes issues (especially on Windows, since I don't
  know how to create symlinks that Cygwin, Gvim, cmd, etc. will all respect).
  Instead, we copy the helper scripts and source the right files from there.
