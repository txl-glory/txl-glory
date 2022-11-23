# vscode 配置

## settings 配置

```json
{
  "workbench.statusBar.visible": false,
  "editor.formatOnSave": true,

  "vetur.format.defaultFormatter.html": "js-beautify-html",
  "vetur.format.defaultFormatterOptions": {
    "js-beautify-html": {
      "wrap_line_length": 150,
      "wrap_attributes": "auto",
      "end_with_newline": false
    }
  },
  "[vue]": {
    "editor.defaultFormatter": "octref.vetur"
  },
  "[jsonc]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "editor.suggestSelection": "first",
  "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
  "prettier.printWidth": 200
}
```

```json
{
  "eslint.codeAction.showDocumentation": {
    "enable": false
  },
  "path-intellisense.mappings": {
    "@": "${workspaceRoot}/src"
  },
  // 打开新文件不覆盖旧文件
  "workbench.editor.enablePreview": false,
  // #每次保存的时候自动格式化
  "editor.formatOnSave": true,
  // 自动修复
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  // 配置 ESLint 检查的文件类型
  "eslint.validate": ["javascript", "vue", "html"],
  "eslint.options": {
    //指定vscode的eslint所处理的文件的后缀
    "extensions": [".js", ".vue", ".ts", ".tsx"]
  },
  "files.associations": {
    "*.wpy": "vue",
    "*.wxml": "wxml",
    "*.cjson": "jsonc",
    "*.wxss": "css",
    "*.wxs": "javascript",
    "*.html": "html"
  },
  "emmet.includeLanguages": {
    "wxml": "html"
  },
  // vscode默认启用了根据文件类型自动设置tabsize的选项
  "editor.detectIndentation": false,
  // 重新设定tabsize
  "editor.tabSize": 2,
  //  #去掉代码结尾的分号
  "prettier.semi": true,
  //  #使用单引号替代双引号
  "prettier.singleQuote": true,
  //  #让函数(名)和后面的括号之间加个空格
  "javascript.format.insertSpaceBeforeFunctionParenthesis": true,
  "vetur.format.defaultFormatter.js": "vscode-typescript",
  // 设置html格式化按照vetur中的js-beautify-html设置执行
  "vetur.format.defaultFormatter.html": "js-beautify-html",
  "git.enableSmartCommit": true,
  "editor.quickSuggestions": {
    "strings": true
  },
  //一定要在vutur.defaultFormatterOptions参数中设置，单独修改prettier扩展的设置是无法解决这个问题的，因为perttier默认忽略了vue文件（事实上从忽略列表移除vue也不能解决这个问题）
  "vetur.format.defaultFormatterOptions": {
    "prettier": {
      "semi": false, // 格式化不加分号
      "singleQuote": true // 格式化以单引号为主
    },
    "js-beautify-html": {
      // force-aligned | force-expand-multiline
      // "wrap_attributes": "force-aligned"
      "wrap_line_length": 120,
      "wrap_attributes": "auto",
      "end_with_newline": false
    },
    "prettyhtml": {
      "printWidth": 100,
      "singleQuote": false,
      "wrapAttributes": false,
      "sortAttributes": false
    }
  },
  "[vue]": {
    "editor.defaultFormatter": "octref.vetur"
  },
  "[javascript]": {
    "editor.defaultFormatter": "vscode.typescript-language-features"
  },
  "explorer.confirmDragAndDrop": false,
  "files.autoGuessEncoding": true,
  "workbench.tree.indent": 18,
  "eslint.codeActionsOnSave.rules": null,
  "workbench.statusBar.visible": false
}
```
