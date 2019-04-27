#!/usr/bin/env bash

PYTHON_VERSION=$1
DJANGO_VERSION=$2
PROJECT_NAME=$3
DB_NAME=$4
DB_USER=$5
DB_PASSWORD=$6
DB_HOST=$7
DB_PORT=$8

echo "$DB_NAME"
echo "$DB_USER"
echo "$DB_PASSWORD"
echo "$DB_HOST"
echo "$DB_PORT"

# Django Aliases
printf "alias pm='python manage.py'\n" >> ~vagrant/.bash_aliases
printf "alias pmr='python manage.py runserver 0.0.0.0:8000'\n" >> ~vagrant/.bash_aliases


# virtualenvwrapper configuration
export WORKON_HOME=~vagrant/.virtualenvs
export PROJECT_HOME=/vagrant
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python$PYTHON_VERSION
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

# Create django-projects folder
mkdir -p ~vagrant/projects

# Create virtualenv
echo 'Creating virtualenv ...'
mkvirtualenv $PROJECT_NAME
workon $PROJECT_NAME

# Create django project
echo 'Creating django project ...'
mkdir -p ~vagrant/projects/$PROJECT_NAME
cd ~vagrant/projects/$PROJECT_NAME
setvirtualenvproject
pwd
touch  requeriments.txt 
echo "DJANGO VERSION"
echo $DJANGO_VERSION
printf "django==${DJANGO_VERSION}\n" >> requeriments.txt
printf "psycopg2\n" >> requeriments.txt

pip install -r requeriments.txt

django-admin startproject $PROJECT_NAME

# Minor modifications to default django project
mv $PROJECT_NAME/$PROJECT_NAME/ config
mv $PROJECT_NAME/manage.py .

echo "Edit manage.py to use config/settings.py "
sed -i "s/$PROJECT_NAME.settings/config.settings/" manage.py

echo "Edit config/settings.py to use config.urls  and config.wsgi.application"
sed -i "s/$PROJECT_NAME.wsgi.application/config.wsgi.application/" ./config/settings.py
sed -i "s/$PROJECT_NAME.urls/config.urls/" ./config/settings.py

# Modify db settings.
echo "Edit DB settings to use postgrtes"
sed -i s/"django.db.backends.sqlite3/django.db.backends.postgresql_psycopg2/" ./config/settings.py
sed -i s/"'NAME': os.path.*$/'NAME': '$DB_NAME',/" ./config/settings.py
sed -i /"'NAME': '$DB_NAME'.*$/a\        'USER': '$DB_USER'," ./config/settings.py
sed -i /"'USER':.*/a\        'PASSWORD': '$DB_PASSWORD'," ./config/settings.py
sed -i /"'PASSWORD':.*/a\        'HOST': '$DB_HOST'," ./config/settings.py
sed -i /"'HOST':.*/a\        'PORT': '$DB_PORT'," ./config/settings.py

# Start bash with virtualenvironment loaded
printf "workon ${PROJECT_NAME}\n" >> ~vagrant/.bashrc
printf "python manage.py runserver 0.0.0.0:8000\n" >> ~vagrant/.bashrc
