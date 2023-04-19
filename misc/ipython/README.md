# Setup

Run

```
ln -s $(readlink -e ipython_config.py) ~/.ipython/profile_default/ipython_config.py
ln -s $(readlink -e mappings.py) ~/.ipython/profile_default/startup/mappings.py
```

## Vim bindings

To enable vim bindings, run:

```
mkdir -p $(jupyter --data-dir)/nbextensions
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
jupyter nbextension enable vim_binding/vim_binding
```
