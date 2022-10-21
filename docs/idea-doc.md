# idea-doc 使用文档

## java 类注释模版

```
/**
 * description: ${NAME} <br>
 * date: ${DATE} ${TIME} <br>
 * author: username <br>
 */
```

## Java 方法注释模版：

```
# Live Templates

*
  * description: $description$ <br>
  * date: $date$ $time$ <br>
  * author: zhaosh <br>
  $params$
  * @return $return$
  **/

  # description ： methodName()
  # params ： groovyScript("def result=''; def params=\"${_1}\".replaceAll('[\\\\[|\\\\]|\\\\s]', '').split(',').toList(); for(i = 0; i < params.size(); i++) {result+='* @param ' + params[i] + ((i < params.size() - 1) ? '\\n' : '')}; return result", methodParameters())
  # return ： methodReturnType()
```
