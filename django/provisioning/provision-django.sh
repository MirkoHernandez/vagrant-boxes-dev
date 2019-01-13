#!/usr/bin/env bash

PYTHON_VERSION=$1
DJANGO_VERSION=$2
PROJECT_NAME=$3

# Django Aliases
printf "alias pm='python manage.py'\n" >> ~vagrant/.bash_aliases
printf "alias pmr='python manage.py runserver'\n" >> ~vagrant/.bash_aliases

# virtualenvwrapper configuration
export WORKON_HOME=~vagrant/.virtualenvs
export PROJECT_HOME=/vagrant
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python$PYTHON_VERSION
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

# Create django-projects folder
mkdir -p ~vagrant/django-projects

# Create virtualenv
echo 'Creating virtualenv ...'
mkvirtualenv $PROJECT_NAME
workon $PROJECT_NAME

# Create django project
echo 'Creating django project ...'
mkdir -p ~vagrant/django-projects/$PROJECT_NAME
cd ~vagrant/django-projects/$PROJECT_NAME
setvirtualenvproject
pwd
cp /vagrant/provisioning/requeriments.txt .
echo "VERSION DE DJANGO"
echo $DJANGO_VERSION
printf "django==${DJANGO_VERSION}\n" >> requeriments.txt

pip install -r requeriments.txt

django-admin startproject $PROJECT_NAME

# Minor modifications to default django project
mv $PROJECT_NAME/$PROJECT_NAME/ config
mv $PROJECT_NAME/manage.py .

sed -i "s/$PROJECT_NAME.settings/config.settings/" manage.py
sed -i "s/$PROJECT_NAME.urls/config.urls/" ./config/settings.py
sed -i "s/$PROJECT_NAME.wsgi.application/config.wsgi.application/" ./config/settings.py

# Start bash with virtualenvironment loaded
printf "workon ${PROJECT_NAME}\n" >> ~vagrant/.bashrc
printf "python manage.py runserver 0.0.0.0:8000\n" >> ~vagrant/.bashrc

