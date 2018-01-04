docker build -t unifo_db .
mkdir /test1
mkdir /test2
mkdir /test3
mkdir /test4
docker run -it -d -v /test1:/var/lib/mysql -p 33061:3306 -h unifodb1 db
docker run -it -d -v /test2:/var/lib/mysql -p 33062:3306 -h unifodb2 db
docker run -it -d -v /test3:/var/lib/mysql -p 33063:3306 -h unifodb3 db
docker run -it -d -v /test4:/var/lib/mysql -p 33064:3306 -h unifodb4 db
