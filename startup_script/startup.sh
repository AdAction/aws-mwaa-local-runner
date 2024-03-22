sudo yum update -y
sudo yum install -y git tar
sudo yum install -y tar gcc zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel tk-devel libffi-devel

echo "Info: Installing PyEnv"
curl https://pyenv.run | bash

echo "Info: Exporting PyEnv Path"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

echo "Info: Initializing PyEnv"
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile

source ~/.bashrc
source ~/.bash_profile

echo "Info: Installing Python Versions for MWAA virtualenv"

pyenv install 3.11

export PYTHON_3_11_PATH=$(find $PYENV_ROOT/versions/ -type f -iname "*python3.11")
sudo cp $PYTHON_3_11_PATH /usr/bin/python3.11

mkdir -p envs
cd envs/
python3.11 -m venv .virtualenv-dbt
source .virtualenv-dbt/bin/activate
cd .virtualenv-dbt/bin/

python3.11 -m pip install dbt-core==1.8.0b1 dbt-redshift==1.8.0b1
dbt --version
deactivate

echo "Deactivate DBT Virtual Environment"
pyenv shell system
pyenv global system
echo "Success: Installed Python Versions for MWAA virtualenv" >&2