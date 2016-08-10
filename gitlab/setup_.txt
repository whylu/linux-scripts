此文件請勿外流

# setup
```
docker run --detach \
    --name gitlab.snsi \
    --hostname gitlab.snsi \
    -p 9443:443 \
	-p 8880:8880 \
	-p 2222:22 \
    --restart=always \
    --volume /root/gitlab/config:/etc/gitlab \
    --volume /root/gitlab/logs:/var/log/gitlab \
    --volume /root/gitlab/data:/var/opt/gitlab \
	--volume /root/gitlab/logs/reconfigure:/var/log/gitlab/reconfigure \
    gitlab/gitlab-ce:latest
```

等10秒後
```
	
  docker exec -it gitlab.iov.snsi update-permissions
  docker exec -it gitlab.iov.snsi vim /etc/gitlab/gitlab.rb
# 更改以下	
# external_url "http://140.92.61.200:8880"
# gitlab_rails['gitlab_shell_ssh_port'] = 2222
  docker restart gitlab.iov.snsi

```

host要開防火牆
```
#(centos7)
  firewall-cmd --permanent --zone=public --add-port=2222/tcp
  firewall-cmd --permanent --zone=public --add-port=8880/tcp
  firewall-cmd --reload
  
# centos 6 使用iptables
iptables -v -I INPUT -i <network-interface> -p tcp --dport 8880 -j ACCEPT
iptables -v -I INPUT -i <network-interface> -p tcp --dport 2222 -j ACCEPT
```

進入
  http://140.92.61.200:8880  
  username: `root`  
  password: `5iveL!fe`  
  
    
    
    
  
    
  