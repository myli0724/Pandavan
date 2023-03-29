
    # 获取接入设备名称
    touch /tmp/var/newhostname.txt
    echo "接入设备名称" > /tmp/var/newhostname.txt
    #cat /tmp/syslog.log | grep 'Found new hostname' | awk '{print $7" "$8}' >> /tmp/var/newhostname.txt
    cat /tmp/static_ip.inf | grep -v "^$" | awk -F "," '{ if ( $6 == 0 ) print "【内网IP："$1"，ＭＡＣ："$2"，名称："$3"】  "}' >> /tmp/var/newhostname.txt
    # 读取以往接入设备名称
    touch /etc/storage/hostname.txt
    [ ! -s /etc/storage/hostname.txt ] && echo "接入设备名称" > /etc/storage/hostname.txt
    # 获取新接入设备名称
    awk 'NR==FNR{a[$0]++} NR>FNR&&a[$0]' /etc/storage/hostname.txt /tmp/var/newhostname.txt > /tmp/var/newhostname相同行.txt
    awk 'NR==FNR{a[$0]++} NR>FNR&&!a[$0]' /tmp/var/newhostname相同行.txt /tmp/var/newhostname.txt > /tmp/var/newhostname不重复.txt
    if [ -s "/tmp/var/newhostname不重复.txt" ] ; then
        content=`cat /tmp/var/newhostname不重复.txt | grep -v "^$"`
        curl -s "http://sc.ftqq.com/$serverchan_sckey.send?text=【PDCN_"`nvram get computer_name`"】新设备加入" -d "&desp=${content}" &
        logger -t "【微信推送】" "PDCN新设备加入:${content}"
        cat /tmp/var/newhostname不重复.txt | grep -v "^$" >> /etc/storage/hostname.txt
    fi
fi

    # 设备上、下线提醒
    # 获取接入设备名称
    touch /tmp/var/newhostname.txt
    echo "接入设备名称" > /tmp/var/newhostname.txt
    #cat /tmp/syslog.log | grep 'Found new hostname' | awk '{print $7" "$8}' >> /tmp/var/newhostname.txt
    cat /tmp/static_ip.inf | grep -v "^$" | awk -F "," '{ if ( $6 == 0 ) print "【内网IP："$1"，ＭＡＣ："$2"，名称："$3"】  "}' >> /tmp/var/newhostname.txt
    # 读取以往上线设备名称
    touch /etc/storage/hostname_上线.txt
    [ ! -s /etc/storage/hostname_上线.txt ] && echo "接入设备名称" > /etc/storage/hostname_上线.txt
    # 上线
    awk 'NR==FNR{a[$0]++} NR>FNR&&a[$0]' /etc/storage/hostname_上线.txt /tmp/var/newhostname.txt > /tmp/var/newhostname相同行_上线.txt
    awk 'NR==FNR{a[$0]++} NR>FNR&&!a[$0]' /tmp/var/newhostname相同行_上线.txt /tmp/var/newhostname.txt > /tmp/var/newhostname不重复_上线.txt
    if [ -s "/tmp/var/newhostname不重复_上线.txt" ] ; then
        content=`cat /tmp/var/newhostname不重复_上线.txt | grep -v "^$"`
        curl -s "http://sc.ftqq.com/$serverchan_sckey.send?text=【PDCN_"`nvram get computer_name`"】设备【上线】Online" -d "&desp=${content}" &
        logger -t "【微信推送】" "PDCN设备【上线】:${content}"
        cat /tmp/var/newhostname不重复_上线.txt | grep -v "^$" >> /etc/storage/hostname_上线.txt
    fi
    # 下线
    awk 'NR==FNR{a[$0]++} NR>FNR&&!a[$0]' /tmp/var/newhostname.txt /etc/storage/hostname_上线.txt > /tmp/var/newhostname不重复_下线.txt
    if [ -s "/tmp/var/newhostname不重复_下线.txt" ] ; then
        content=`cat /tmp/var/newhostname不重复_下线.txt | grep -v "^$"`
        curl -s "http://sc.ftqq.com/$serverchan_sckey.send?text=【PDCN_"`nvram get computer_name`"】设备【下线】offline" -d "&desp=${content}" &
        logger -t "【微信推送】" "PDCN设备【下线】:${content}"
        cat /tmp/var/newhostname.txt | grep -v "^$" > /etc/storage/hostname_上线.txt
    fi
fi