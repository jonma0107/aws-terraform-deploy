
#!/bin/bash
sudo su
yum update -y
yum install -y httpd
mkdir klinik-dir
cd klinik-dir
wget https://www.free-css.com/assets/files/free-css-templates/download/page296/klinik.zip
unzip klinik.zip
cd clinic-website-template
mv * /var/www/html/
cd /var/www/html/
systemctl enable httpd
systemctl start httpd