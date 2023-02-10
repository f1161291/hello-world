#!/bin/bash
echo "这是一个甲骨文实例保活脚本"
echo "1.AMD 永久免费服务器"
echo "2.ARM A1实例服务器"
read -p "请选择" choice

if (($choice == 1)); then
mkdir -p ~/save_oracle
cat <<EOF >~/save_oracle/crontab.sh
#!/bin/bash

for (( i = 0; i < 5; i+=1)); do
    wget --limit-rate=10m https://sel-kor-ping.vultr.com/vultr.com.100MB.bin -O /tmp/100mb.test
    sleep 10
    dd if=/dev/zero of=/tmp/test bs=1M count=128
done

exit 0
EOF
chmod +x ~/save_oracle/crontab.sh
crontab -l > conf
echo "* * * * * ~/save_oracle/crontab.sh" >> conf
crontab conf
rm -f conf
crontab -l
echo "添加结束，检查crontab如果多了一条记录则OK"

elif (($choice == 2)); then
mkdir -p ~/save_oracle
cat <<EOF >~/save_oracle/crontab.sh
#!/bin/bash

for (( i = 0; i < 5; i+=1)); do
    wget --limit-rate=10m https://sel-kor-ping.vultr.com/vultr.com.100MB.bin -O /tmp/100mb.test
    sleep 10
    dd if=/dev/zero of=/tmp/test bs=1M count=128
done

exit 0
EOF
dd if=/dev/zero of=/dev/shm/save_oracle bs=1K count=cat /proc/meminfo |grep 'MemTotal' |awk -F : '{print $2}' |sed 's/^[ \t]*//g'|sed 's/ kB//'|sed 's/.$//g'
chmod +x ~/save_oracle/crontab.sh
crontab -l > conf
echo "* * * * * ~/save_oracle/crontab.sh" >> conf
echo "@reboot dd if=/dev/zero of=/dev/shm/save_oracle bs=1K count=cat /proc/meminfo |grep 'MemTotal' |awk -F : '{print $2}' |sed 's/^[ \t]*//g'|sed 's/ kB//'|sed 's/.$//g'" >> conf
crontab conf
rm -f conf
crontab -l
echo "添加结束，检查crontab如果多了一条记录则OK"
fi
