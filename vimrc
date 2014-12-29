" ###################################################################
" vimrc 配置
" Edit By Gene
" Update At 2014-03-17
" ###################################################################


" 基本设置
"--------------------------------------------------------------------
set nocompatible        " 关闭 vi 兼容模式 
syntax on               " 自动语法高亮
syntax enable			" 语法高亮
filetype on             " 打开文件类型检测
"set cursorline         " 突出显示当前行 
set ruler               " 打开状态栏标尺 
set shiftwidth=4        " 设定 << 和 >> 命令移动时的宽度为 4 
set softtabstop=4       " 使得按退格键时可以一次删掉 4 个空格 
set tabstop=4           " 设定 tab 长度为 4 
set laststatus=2        " 显示状态栏 (默认值为 1, 无法显示状态栏) 
set nobackup            " 覆盖文件时不备份
set noswapfile			" 不需要 .swp 文件
set incsearch           " 输入搜索内容时就显示搜索结果 
set hlsearch            " 搜索时高亮显示被找到的文本 
set noerrorbells        " 关闭错误信息响铃 
set smartindent         " 开启新行时使用智能自动缩进 
set pastetoggle=<F9>	" 插入模式下，按F9键就切换自动缩进

" VIM主题
" colorscheme darkblue
colorscheme elflord

" 记住上次打开的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" 设置在状态行显示的信息 
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

" 注释颜色
hi Comment ctermfg=3

" 修改声明颜色
" hi Statement ctermfg=3
" 修改常量颜色
" hi Constant ctermfg=3
" 修改字符串颜色
" hi String ctermfg=3
" 修改类型颜色
" hi Type ctermfg=3
" 修改数字颜色
" hi Number ctermfg=3


" 中文乱码  
set fileencodings=gb2312,gb18030,utf-8
set termencoding=utf-8

" 自动补全
filetype plugin indent on
set completeopt=longest,menu


" 阅读代码设置
"====================================================================
" ctags
"--------------------------------------------------------------------
" map <F4> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> 
set tags=tags;
set autochdir


" taglist
"--------------------------------------------------------------------
" map <F3> : Tlist<CR>						" 按下F3就可以呼出了
let Tlist_Auto_Open = 0						" 在启动VIM后，自动打开taglist窗口
" let Tlist_Ctags_Cmd = '/usr/bin/ctags'	" 设定ctags的位置
let Tlist_Use_Right_Window=0				" 1 为让窗口显示在右边，0 为显示在左边 
let Tlist_Show_One_File=1					" 让taglist可以同时展示多个文件的函数列表，设置为1时不同时显示多个文件的tag，只显示当前文件的 
let Tlist_File_Fold_Auto_Close=1			" 同时显示多个文件中的tag时，taglist只显示当前文件tag，其他文件的函数列表折叠隐藏  
let Tlist_Exit_OnlyWindow=1					" 当taglist是最后一个分割窗口时，自动退出vim  
"let Tlist_Use_SingleClick=1				" 缺省情况下，在双击一个tag时，才会跳到该tag定义的位置
"let Tlist_Process_File_Always=0			" 是否一直处理tags.1:处理;0:不处理 
let TList_GainFocus_On_ToggleOpen=0			" 打开时焦点不放在tl窗口中
let Tlist_WinWidth=50						" Tlist_WinHeight和Tlist_WinWidth可以设置taglist窗口的高度和宽度


" cscope
"--------------------------------------------------------------------
" set cscopequickfix=s-,c-,d-,i-,t-,e-
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
	" else search cscope.out elsewhere
	else
		let cscope_file=findfile("cscope.out", ".;")
		let cscope_pre=matchstr(cscope_file, ".*/")
		if !empty(cscope_file) && filereadable(cscope_file) 
			exe "cs add" cscope_file cscope_pre
		endif
    endif
    set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>


