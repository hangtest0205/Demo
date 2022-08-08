#!/bin/bash

/bin/unlink /data/websites/elsevierasia/var/shared

/bin/ln -s /data/efs-data/elsevierasia/media /data/websites/elsevierasia/pub/

/bin/unlink /data/websites/elsevierasia/pub/static/_cache

/bin/php /data/websites/elsevierasia/bin/magento cache:clean

/bin/php /data/websites/elsevierasia/bin/magento cache:flush

/usr/bin/rm -rf /data/websites/elsevierasia/generated

/usr/bin/rm -rf /data/websites/elsevierasia/pub/static/frontend

/usr/bin/rm -rf /data/websites/elsevierasia/pub/static/adminhtml

/usr/bin/rm -rf /data/websites/elsevierasia/pub/static/deployed_version.txt

/bin/php /data/websites/elsevierasia/bin/magento setup:upgrade 

/bin/php /data/websites/elsevierasia/bin/magento setup:di:compile

/bin/php /data/websites/elsevierasia/bin/magento setup:static-content:deploy -f

/bin/php /data/websites/elsevierasia/bin/magento setup:static-content:deploy -f en_GB -a frontend -t Elsevier/newaustralia

/bin/php /data/websites/elsevierasia/bin/magento setup:static-content:deploy -f --theme Elsevier/newjapan ja_JP

/bin/php /data/websites/elsevierasia/bin/magento setup:static-content:deploy -f --theme Elsevier/newkorea ko_KR

/bin/php /data/websites/elsevierasia/bin/magento setup:static-content:deploy -f --theme Elsevier/newtaiwan zh_Hant_TW

/bin/unlink /data/websites/elsevierasia/pub/media

yes | /usr/bin/cp -rp /data/websites/elsevierasia/pub/static/_cache/* /data/efs-data/elsevierasia/static/_cache/

/usr/bin/rm -rf /data/websites/elsevierasia/pub/static/_cache

/bin/find /data/websites/elsevierasia -type d -exec chmod 755 {} \; 

/bin/find /data/websites/elsevierasia -type f -exec chmod 644 {} \;

/bin/find /data/websites/elsevierasia -name pub  -prune -o -print0 | xargs -0 /bin/chown nginx:nginx

/bin/find /data/websites/elsevierasia/pub -name media  -prune -o -print0 | xargs -0 /bin/chown nginx:nginx

/bin/ln -s /data/efs-data/elsevierasia/media /data/websites/elsevierasia/pub/

/bin/ln -s /data/efs-data/elsevierasia/static/_cache /data/websites/elsevierasia/pub/static/

/bin/ln -s /data/efs-data/elsevierasia/shared  /data/websites/elsevierasia/var/

/usr/sbin/service nginx restart