{...}: {
  programs.nixvim = {
    clipboard.register = "unnamedplus";
    globals = {
      mapleader = ",";
      maplocalleader = ",";
    };

    opts = {
      ignorecase = true;
      smartcase = true;
      number = true;
      signcolumn = "yes";
      mouse = "a";
      cursorline = true;
      scrolloff = 10;
      completeopt = "menuone,noselect,popup";
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      breakindent = true;
      backspace = "indent,start,eol";
      confirm = true;
      updatetime = 250;
      undofile = true;
      backup = false;
      writebackup = false;
      splitbelow = true;
      splitright = true;
      termguicolors = true;
      background = "dark";
      foldlevel = 99;
      statusline = "%1* %n %*%5*%{&ff}%*%3*%y%*%4* %<%F%*%2*%m%*%1*%=%5l%*%2*/%L%*%1*%4v %*%2*0x%04B %*";
    };
  };
}
