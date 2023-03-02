mkdir -p ~/.local
cd ~/.local
delta_version=0.15.0
delta_file=delta-${delta_version}-x86_64-unknown-linux-musl.tar.gz
wget "https://github.com/dandavison/delta/releases/download/${delta_version}/${delta_file}"
tar xzvf ${delta_file}
rm ${delta_file}
ln -s ~/.local/${delta_file%.tar.gz}/delta ~/.local/bin/delta
