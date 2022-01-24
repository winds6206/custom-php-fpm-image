# custom-php-fpm 映像檔

- 安裝 mysqli/pdo/pdo_mysql Extension
- 已啟用 php Redis Extension
- 已調整時區為 Asia/Taipei

## 設定檔路徑

www.conf
```
/usr/local/etc/php-fpm.d/www.conf
```

php.ini
```
/usr/local/etc/php/php.ini
```

php-fpm.conf
```
/usr/local/etc/php-fpm.conf
```

列出已安裝的 module
```
php -m
```

檢視擴展套件是否support
```
php -i
```

## 安裝套件注意事項

在安裝某些擴展套件時，會需要一些相依性套件，例如以下套件

```
RUN apt-get install -y curl && docker-php-ext-install curl
RUN apt-get install -y libxml2-dev && docker-php-ext-install xml
```

## docker-php-ext-enable vs. extension

編譯完 php 擴展套件後，我們可以執行以下指令來去啟用該擴展套件

```
docker-php-ext-enable [擴展套件]

# Example
docker-php-ext-enable redis
```

此時就會在 `/usr/local/etc/php/conf.d/` 該路徑底下新增該套件的相對應檔案，並以該格式命名 `docker-php-ext-擴展套件.ini`

```
$ cd /usr/local/etc/php/conf.d/
$ ls -al

-rw-r--r-- 1 root root   20 Jan 21 14:42 docker-php-ext-mysqli.ini
-rw-r--r-- 1 root root   23 Jan 21 14:42 docker-php-ext-pdo_mysql.ini
-rw-r--r-- 1 root root   16 Jan 21 14:43 docker-php-ext-redis.ini
-rw-r--r-- 1 root root   17 Dec 11  2020 docker-php-ext-sodium.ini
-rw-r--r-- 1 root root   17 Jan 21 14:42 docker-php-ext-zip.ini
```

此時就不必再 php.ini 內加上以下設定

```
extension=redis.so
```
