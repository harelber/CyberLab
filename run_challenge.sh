sudo useradd challenge
echo "challenge:bb064b23223dff9b805313cdafc355acc64f1642" | chpasswd
#get ownership of file to specific user
echo "let Us start from the Begining. Find a user that is the owner of the cryptic crypt.txt file, #so you can read it. Capstone project may help you solve this." >> stage1.txt
chmod 444 stage1.txt
echo "Znoy cgy g rozzrk ngxjkx. Lux tuc, vuxz zu znk uazyojk cuxrj.lotj gt uvkt vuxz gtj yktj g vgiqkz znxuamn oz. Eua ynuarj ykgxin lux tkc iraky ut znk Otzkxtkz uxmgtofgzout." >> crypt.txt
chown challenge crypt.txt
chmod 700 crypt.txt
#now we create a dns server, so th dns query will get answer
apt-get install bind9 dnsutils
sudo apt-get install apache2
sudo apt-get install php
sudo apt-get install mysql-server mysql-client mysql-php7.0
cd /etc/bind
mkdir -p zones/master
cd ~
cp ~/db.clues.org /etc/bind/zones/master/
cp ~/db.mainland.com /etc/bind/zones/master/
cd /etc/bind
echo "zone \"clues.org\" {\ntype master;\nfile \"/etc/bind/zones/master/db.clues.org\";\n};" >> /etc/bind/named.conf.local
echo "zone \"mainland.com\" {\ntype master;\nfile \"/etc/bind/zones/master/db.mainland.com\";\n};" >> /etc/bind/named.conf.local
named-checkconf
truncate -s 0 /etc/resolv.conf
chmod 666 /etc/resolv.conf
echo "nameserver 127.0.0.1" >> /etc/resolv.conf
/etc/init.d/bind9 start
rm /var/www/html/index.html
#create the web proxy
cp ~/the_end.sh /var/www/html/
cp ~/a.txt /var/www/html
cp ~/index.html /var/www/html/
cp ~/check.php /var/www/html/
#block iptables
iptables -A OUTPUT -p tcp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -j DROP
#mysql
mysql -u root -proot << EOF
create database if not exists mainland;
use mainland;
create table if not exists files (c1 INT,c2 VARCHAR(20),c3 VARCHAR(5));
insert into files (c1,c2,c3) values(1,"index","html");
insert into files (c1,c2,c3) values(2,"the_end","sh");
insert into files (c1,c2,c3) values(3,"check","php");
EOF
