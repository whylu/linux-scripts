# For Windows 
## 建立ssh-key 
1. 下載 PuTTYgen from http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html  
2. 執行puttygen, 選SSH-2 RSA, 點Generate, 滑鼠在key方塊中移動直到完成  
3. 不要更改任何資訊, 點Save public key, 儲存成.pub檔案, 例如minglungweng.pub  
4. 點Save private key, 跳出警告按'是', 儲存.ppk檔案, 例如minglungweng.ppk  
5. 編輯.pub檔案, 原始如下  
```
---- BEGIN SSH2 PUBLIC KEY ----
Comment: "rsa-key-20160728"
AAAAB3NzaC1yc2EAAAABJQAAAQEAqhO7UR0moNJd/xX669F0A1UK2besVdDNzbrA
J2vpYKeYs6XifoRCnAFcsrzTjQTF6Z0aI7YeRnIywm/Xu8/nB55HjNuVqRmuLkPI
8vODCGga/zb2p6v76Pz3pa0lIoWJsKJ6HATFPDuqs/aL2Sz1+rwaqqfHHd7t2gcd
F/ruIR2cooY5Fh5F+7JY4kx6VRGMw3+s01lW6kIVCxECjYEymOvejsy15VEtLGie
+jnDnlOI40OZ/qIWsPM8/CBQjTpxr7qWKRL0cCC0hhbLAfElPd5YH634ixYqVDnl
0fnnedtFZY7hMFffYJAqnYmeucjiSc5OlTy1wNoGy6stMWXH0w==
---- END SSH2 PUBLIC KEY ----
```
改成以下格式
```
ssh-rsa 去掉換行的一串密碼 <Comment>
```
例如
```
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAqhO7UR0moNJd/xX669F0A1UK2besVdDNzbrAJ2vpYKeYs6XifoRCnAFcsrzTjQTF6Z0aI7YeRnIywm/Xu8/nB55HjNuVqRmuLkPI8vODCGga/zb2p6v76Pz3pa0lIoWJsKJ6HATFPDuqs/aL2Sz1+rwaqqfHHd7t2gcdF/ruIR2cooY5Fh5F+7JY4kx6VRGMw3+s01lW6kIVCxECjYEymOvejsy15VEtLGie+jnDnlOI40OZ/qIWsPM8/CBQjTpxr7qWKRL0cCC0hhbLAfElPd5YH634ixYqVDnl0fnnedtFZY7hMFffYJAqnYmeucjiSc5OlTy1wNoGy6stMWXH0w== rsa-key-20160728
```

6. 登入gitLab, 點右上USER圖示, 點profile, 點右上鉛筆圖示, 點SSH Keys
7. 在Key貼上剛剛.pub的內容, title任意填, 儲存
8. 完成
9. 在clone時, 載入.ppk檔即可
