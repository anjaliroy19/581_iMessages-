/**
*@pre Nothing is written
*@post text will be white
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a comment then it will be regular text colour
*/

If comments are written
  Then color is white
/**
*@pre Nothing is written
*@post symbol or operations will be white
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a symbol or operation then it will be regular text colour
*/

Else if symbol and operations are used
  Then color is white
/**
*@pre Nothing is written
*@post function/class name/ variables will be light green
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a  function/class name/ variables then it will be regular *text colour
*/

Else If function/class name/variables
  Then color is light green
/**
*@pre Nothing is written
*@post numbers will be red
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a number then it will be regular text colour
*/

Else if numbers are used
  Then color is red
/**
*@pre Nothing is written
*@post directives/calls/keywords will be green
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a directives/calls/keyword then it will be regular text *colour
*/

Else if directives/calls/keywords are used
  Then color is green
/**
*@pre Nothing is written
*@post character strings will be  light green
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a character string then it will be regular text colour
*/

Else if character strings are used
  Then color is light green
/**
*@pre Nothing is written
*@post types will be green
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a type then it will be regular text colour
*/
Else if types are used
  Then color is green
Else
  Color is white
