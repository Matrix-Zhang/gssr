## 目标

在 google cloud platform 上部署一台运行 shadowsocks-rust 服务的虚拟机实例



## 准备

1. 安装 terraform，packer 工具
2. 一个 google cloud platform 的账号
3. 新建一个 project，并记录该  **project id**
4. 在 IAM和管理中新建一个服务账号分配一个角色（比如上述步骤中的 project  所有者），并创建密钥，下载该账号的认证信息的 json 文件，将该文件保存在本地的某个目录中，记为 account_file



## 开始

1. 更改 packer/ubuntu-ssr.json 中的 account_file，project_id (对应准备中的 3 和 4)，以及 image_name，然后运行

   ```bash
   packer build ubuntu-ssr.json
   ```

   

2. 更改 terraform/variables.tf 中的变量，运行 

   ```bash
   terraform init
   terrafrom apply
   ```

   

3. 记录 步骤 2 输出的 IP 地址，在 ssr 客户端中尽情适用吧 ：）

   

## 注意
- ZONE 参数可能需要更改，默认是香港节点

- **默认的虚拟机类型是 f1-micro**