sudo unlink /etc/nginx/sites-enabled/default
sudo ln -s /home/box/web/etc/nginx.conf /etc/nginx/sites-enabled/test.conf
sudo /etc/init.d/nginx restart
sudo ln -s /home/box/web/etc/gunicorn.conf /etc/gunicorn.d/test
sudo /etc/init.d/gunicorn restart
sudo /etc/init.d/mysql start

mysql -uroot -e "create database qa; create user 'django'@'localhost' identified by 'django';"
mysql -uroot -e "grant all on qa.* to 'django'@'localhost'; flush privileges;"

gunicorn -b '0.0.0.0:8080' hello:wsgi_app &
gunicorn -b '0.0.0.0:8000' --chdir "./ask" ask.wsgi:application &