# Run local Docker
1. Download dump.sql.tar.gz file from anywhere
2. tar -xzf dump.sql.tar.gz in project's root directory
3. Place your private key to access github in project's root directory and name it "key" without quotes and extension
4. chmod 0600 ./key
5. Make sure you have "dump.sql" and "key" files in project's root directory
6. bin/start
7. ./load-dump
8. Place 127.0.0.1 oro.local in your /etc/hosts
9. Open http://oro.local:1080/ and login as admin/admin

# Use remote Amazon
1. See README.md in corresponding directory
