#!/bin/bash
# 你想要的文件保存路径
save_path="/tmp/fish"
webhook_url="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=70fea715-8c27-4d9f-811c-9a79ef7d089a"
image_file="fish.png"
image_url="https://api.vvhan.com/api/moyu"
base64_file="base64f.txt"
# 然后，在下载图片、保存base64编码和发送HTTP POST请求的时候，都使用这个变量作为文件的前缀，例如：
# 下载图片到指定路径
curl -L -o $save_path$image_file -k $image_url

# 对图片进行base64编码，并保存为文本文件到指定路径
base64 $save_path$image_file > $save_path$base64_file

# 计算图片的md5值
md5=$(md5sum $save_path$image_file | cut -d ' ' -f1)

# 读取base64编码文件的内容
base64=$(cat $save_path$base64_file)

# 构造JSON格式的数据，包含msgtype、base64和md5三个字段
# 使用curl命令发送HTTP POST请求，携带JSON数据和webhook地址，给企业微信群组发送图片消息
# 问题描述
# 使用curl时，因为参数过长报错Argument list too long

# 解决办法
# 使用 @- 从标准输入中获取数据。利用echo输出到标准输入，再利用管道重定向输入到curl的-d参数中
# echo '{"userhname":"xxx","pwd":"'$pwd'","nickname":"test"}' | curl -v -X PUT -H 'Content-Type:application/json' -d @- "http://api.com/yourapi"

echo "{\"msgtype\": \"image\", \"image\": {\"base64\": \"$base64\", \"md5\": \"$md5\"}}" | curl -H "Content-Type: application/json" -d @- -k "$webhook_url"

# 如果你想在函数执行完后删除不必要数据，你可以在最后使用rm命令删除本地保存的图片文件和base64编码文件，例如：

# 删除本地保存的图片文件和base64编码文件
rm $save_path$image_file $save_path$base64_file


# 请注意，你需要将 `KEY` 和 `IMG_URL` 变量替换为你自己的企业微信机器人的 key 和图床图片链接。
# 此外，这个脚本需要 `curl`、`base64` 和 `md5sum` 命令，如果你的系统中没有这些命令，你需要先安装它们。