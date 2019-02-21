# git tutor
# 2018-12-6
# lst
# 参考来自 https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000
# 安装
sudo apt-get install git
# 通过Git生成SSH Key；id_rsa.pub”文件内容就是公钥
ssh-keygen -t rsa -C "838395676@qq.com"
# github添加公匙
# 测试ssh key是否成功，使用命令
ssh -T git@github.com
# 配置，尽量将git客户端的用户名、邮箱和github账号的用户名、邮箱设置为完全一致；
#git config --global user.name “账号名” #起个名字
#git config --global user.email “邮箱” #自己的邮箱
git config --global user.name "LST512"
git config --global user.email “838395676@qq.com”
git config --list 查看配置结果
#----------------------------------------
#文件添加到仓库，不会有提示,可以同时add多个文件
git add git_learning.txt
#文件提交到仓库,可以提交多个文件
git commit -m "git learning"
#查看状态
git status
#查看上次修改的内容
git diff git_learning.txt
#查看历史记录 ,确定要回退到哪个版本 --pretty=oneline
git log
#版本的回退
HEAD---> 当前版本
HEAD^---> 上个版本
HEAD^^---> 上上个版本
HEAD~100---> 往上100个版本
git reset HEAD #任何事情都不会发生，这是因为我们告诉GIT重置这个分支到HEAD，而这个正是它现在所在的位置。
git reset HEAD~2 #HEAD从顶端的commit往下移动两个更早的commit
#回退到上个版本,慎用
git reset --hard HEAD^
#定回到(未来)的某个版本,需要commit id
git reset --hard 1094a
#记录每一次命令,确定要回到未来的哪个版本
git reflog
#--------------------
'''
工作区有一个隐藏目录.git，这个不算工作区，而是Git的版本库。
git的版本库里存了很多东西，其中最重要的就是称为stage（或者叫index）的暂存区
还有Git为我们自动创建的第一个分支master，以及指向master的一个指针叫HEAD。
第一步是用git add把文件添加进去，实际上就是把文件修改添加到暂存区；
第二步是用git commit提交更改，实际上就是把暂存区的所有内容提交到当前分支。
因为我们创建Git版本库时，Git自动为我们创建了唯一一个master分支，所以，现在，git commit就是往master分支上提交更改。
'''
#第一次修改 -> git add -> 第二次修改 -> git add -> git commit
#丢弃工作区的修改
git checkout git_learning.txt
‘’‘
命令git checkout -- git_learning.txt意思就是，把readme.txt文件在工作区的修改全部撤销，这里有两种情况：
git checkout -- file命令中的--很重要，没有--，就变成了“切换到另一个分支”的命令，我们在后面的分支管理中会再次遇到git checkout命令
一种是自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
一种是已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
总之，就是让这个文件回到最近一次git commit或git add时的状态。
’‘’
#如果在暂存区，想要撤销暂存区的修改撤销掉（unstage）
git reset HEAD git_learning.txt #丢弃暂存区的修改
git checkout git_learning.txt #丢弃工作区的修改
git status
#删除文件
rm file #git checkout -- file 恢复文件
git status
git rm file #从版本库中删除该文件,不能用git checkout -- file 恢复文件；git log获取commit id，git reset --hard commit id huihui恢复文件
'''
命令git rm用于删除一个文件。如果一个文件已经被提交到版本库，那么你永远不用担心误删，但是要小心，你只能恢复文件到最新版本，你会丢失最近一次提交后你修改的内容。
'''
#远程仓库
git remote add origin git@github.com:LST512/Git_command.git
git push -u origin master
'''
要关联一个远程库，使用命令git remote add origin git@server-name:path/repo-name.git;
关联后，使用命令git push -u origin master第一次推送master分支的所有内容；
此后，每次本地提交后，只要有必要，就可以使用命令git push origin master推送最新修改；
程库的名字就是origin，这是Git默认的叫法，也可以改成别的，但是origin这个名字一看就知道是远程库。
本地库的内容推送到远程，用git push命令，实际上是把当前分支master推送到远程。
由于远程库是空的，我们第一次推送master分支时，加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令。
'''
git push origin master
#-----------------------
#从远程库克隆
git clone git@github.com:LST512/Git_command.git
#分支管理
'''
具体图形解释参考此处
https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/001375840038939c291467cc7c747b1810aab2fb8863508000
'''
#创建分支dev，并切换到分支-b
git branch dev #创建分支
git checkout dev #切换到分支
git checkout -b dev #创建并切换
#列出所有分支，当前分支前面会标一个*号。
git branch
#把dev分支的工作成果合并到master分支上：
git merge dev
'''
切换回master分支后，刚才添加的内容不见了！因为那个提交是在dev分支上，而master分支此刻的提交点并没有变：
Fast-forward信息，Git告诉我们，这次合并是“快进模式”，也就是直接把master指向dev的当前提交，所以合并速度非常快。
'''
#删除dev分支了
git branch -d dev
'''
Git鼓励大量使用分支：

查看分支：git branch

创建分支：git branch <name>

切换分支：git checkout <name>

创建+切换分支：git checkout -b <name>

合并某分支到当前分支：git merge <name>

删除分支：git branch -d <name>
'''
#提示：更新被拒绝，因为远程仓库包含您本地尚不存在的提交
git push -u origin +master　#使用+master 强制更新
#or
git pull origin master
git pull origin master master
'''
git pull命令的作用是，取回远程主机某个分支的更新，再与本地的指定分支合并。
'''



