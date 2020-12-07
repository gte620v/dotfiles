conda install -c conda-forge -y jupyterlab
conda install -y nodejs black isort
jupyter labextension install @ryantam626/jupyterlab_code_formatter
conda install -c conda-forge -y jupyterlab_code_formatter
jupyter labextension update @ryantam626/jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter
jupyter labextension install @axlair/jupyterlab_vim
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ${HOME}/.jupyter/mykey.key -out ${HOME}/.jupyter/mycert.pem




