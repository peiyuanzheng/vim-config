# vim配置

## 功能列表

- 插件管理：[junegunn/vim-plug](https://github.com/junegunn/vim-plug)
- 常用配置：详见`peiyuanzheng/vim-config/autoload/zpybasic.vim`
- 颜色主题：[morhetz/gruvbox](https://github.com/morhetz/gruvbox)
- 文件浏览：[preservim/nerdtree](https://github.com/preservim/nerdtree)
- 文件切换、函数列表：[Yggdroot/LeaderF](https://github.com/Yggdroot/LeaderF)
- 文本查找：ripgrep + [Yggdroot/LeaderF](https://github.com/Yggdroot/LeaderF)
- 符号索引: [GNU global](https://www.gnu.org/software/global) + [Yggdroot/LeaderF](https://github.com/Yggdroot/LeaderF)
- c++ 自动补全和跳转：[neoclide/coc.nvim](https://github.com/neoclide/coc.nvim) + [ccls](https://github.com/MaskRay/ccls)
- 代码检查(TODO)：[ALE](https://github.com/dense-analysis/ale)
- 任务系统(TODO)：[asyncrun](https://github.com/skywind3000/asyncrun.vim)、[aynctasks](https://github.com/skywind3000/asynctasks.vim)


## 安装

### 安装必要的软件

``` shell
#以下示例是在MacOS上

# 安装ripgrep, global
brew install ripgrep global

# 安装node（coc.nvim的前置依赖）
brew install node
npm install -g yarn

# 安装ccls
brew install ccls
```

### 安装插件集

- 下载项目内的`.vimrc`放于`~/`下
- 打开vim（先忽略报错），执行`:PlugInstall`
- 执行`cd ~/.vim && ln -snf plugged/vim-config/coc-settings.json`


## 使用

- 常用的vim自带选项和基础功能映射键见：`peiyuanzheng/vim-config/autoload/zpybasic.vim`。
- 插件必要的配置和映射键见：`peiyuanzheng/vim-config/autoload/zpyadvance.vim`。
- 使用 `LeaderF gtags` 的注意事项：
  - 当前配置是会索引 symlink 目录/文件；如果要跳过一些目录/文件，需`cp /path/to/gtags.conf ~/.globalrc`，然后修改其`skip`的配置。
  - 在项目根目录 `touch .root`，以便自动建立/增量更新符号索引。


## 参考

- [vim搭建c/c++开发环境](https://www.zhihu.com/question/47691414/answer/373700711)
- [ccls project setup](https://github.com/MaskRay/ccls/wiki/Project-Setup)
- [Configure coc.nvim for C/C++ Development](https://ianding.io/2019/07/29/configure-coc-nvim-for-c-c++-development/)
  - 查找system include路径：`g++ -E -x c++ - -v < /dev/null`，在输出结果`#include <...> search starts here`的后面字符串。
