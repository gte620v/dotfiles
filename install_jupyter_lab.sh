conda install -c conda-forge -y jupyterlab
conda install -c conda-forge -y jupyterlab_code_formatter
conda install -y nodejs black isort
pip install jupyterlab_vim
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ${HOME}/.jupyter/mykey.key -out ${HOME}/.jupyter/mycert.pem




