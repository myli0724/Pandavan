#/bin/ash
#用于企业微信机器人推送通道
#start
echo "==========开始=========="
echo `date '+%Y-%m-%d %H:%M:%S'`
#企业微信机器人webhook
webhook="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=70fea715-8c27-4d9f-811c-9a79ef7d089a"
#获取当前wan_ip
current_wan_ip=`ifconfig -a | grep inet | grep -v inet6 | grep -v 127.0.0.1 | grep -v 192.168.0.1 | grep -v 172.17.0.1 | grep -v 192.168.123.1 |awk '{print $2}' | tr -d "addr:"`
echo "WanIP: $current_wan_ip"
ipv4=$(wget -qO- 4.ipw.cn)
echo "IPv4: $ipv4"
ipv6=$(wget -qO- 6.ipw.cn)
echo "IPv6: $ipv6"
#第一次推送ip
content="路由器IP已更新\n当前WanIP: ""$current_wan_ip""\n当前ipv4：""$ipv4""\n当前ipv6：""$ipv6"
#curl -k "$webhook" -H "Content-Type: application/json" -d "{\"msgtype\":\"news\",\"news\":{\"articles\": [{\"title\":\"router start!\",\"description\":\"$content\"} \"url\" : \"https://api.vvhan.com/api/bing?size=640x480\",\"picurl\" : \"https://api.vvhan.com/api/bing\"}]}}"
curl -k "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=70fea715-8c27-4d9f-811c-9a79ef7d089a" \
   -H "Content-Type: application/json" \
   -d "
{
    \"msgtype\": \"news\",
    \"news\": {
       \"articles\" : [
           {
               \"title\" : \"每日一图\",
               \"description\" : \"$content\",
               \"url\" : \"https://api.vvhan.com/api/bing\",
               \"picurl\" : \"https://api.vvhan.com/api/bing?size=640x480\"
           }
        ]
    }
}"
echo "已推送当前ip"
#end
