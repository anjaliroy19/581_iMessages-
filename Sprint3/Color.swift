//variable declaration
char comments;
char symbol;
char class;
int num;
char calls;
char string;
char types;
char params;
char fnName;

**
*@pre Nothing is written
*@post text will be white
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a comment then it will be regular text colour
*/

if (comments){
  //color is white
 let comments = #CACCD2;
}
  
/**
*@pre Nothing is written
*@post symbol or operations will be white
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a symbol or operation then it will be regular text colour
*/

else if (symbol) {
  //Then color is white
let symbol = #CACCD2;
}
/**
*@pre Nothing is written
*@post function/class name/ variables will be light green
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a  function/class name/ variables then it will be regular *text colour
*/

else if (class) {
  //Then color is light green
  let class = #74FBAF;
}
/**
*@pre Nothing is written
*@post numbers will be red
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a number then it will be regular text colour
*/

else if (num){ 
  //Then color is red
  let num = #E9402F;
}
/**
*@pre Nothing is written
*@post directives/calls/keywords will be green
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a directives/calls/keyword then it will be regular text *colour
*/

else if (calls){
 // Then color is green
  let calls = #74FBAF; 
}
/**
*@pre Nothing is written
*@post character strings will be  light green
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a character string then it will be regular text colour
*/

else if(strings) {
 // Then color is light green
  let strings = #AEFA4E;
}
/**
*@pre Nothing is written
*@post types will be green
*@return inputed text colour changed
*@throw(any errors) if the input isn’t a type then it will be regular text colour
*/
else if (types) {
  //Then color is green
  let types = #74FBAF;
}
else if (params){
  //color is rose
  let params = #EA428F;
}
else if (fnName){
  //color is yellow
  let fnName = #DFFD52;
}
else{
  //Color is white
  return #F6F6F6;
}

