var keywords = [&quot;SELECT&quot;,&quot;FROM&quot;,&quot;WHERE&quot;,&quot;LIKE&quot;,&quot;BETWEEN&quot;,&quot;NOT
LIKE&quot;,&quot;FALSE&quot;,&quot;NULL&quot;,&quot;FROM&quot;,&quot;TRUE&quot;,&quot;NOT IN&quot;];
var keywords2 = [&quot;main&quot;];
var keywords3 = [&quot;#include&quot;];
var keywords4 = [&quot;cout&quot;, &quot;sin&quot;, &quot;endl&quot;];
var keywords5 = [&quot;using&quot;,&quot;namespace&quot;, &quot;int&quot;, &quot;double&quot;, &quot;return&quot;];
var keywords6 = [&quot;0&quot;, &quot;1.4&quot;, &quot;2&quot;, &quot;2.3&quot;];
var keywords7 = [&quot;hello&quot;, &quot;there&quot;];
var keywords8 = [&quot;//comments&quot;];

$(&quot;#editor&quot;).on(&quot;keyup&quot;, function(e){

if (e.keyCode == 32){
var newHTML = &quot;&quot;;

$(this).text().replace(/[\s]+/g, &quot; &quot;).trim().split(&quot; &quot;).forEach(function(val){
// If word is statement
if (keywords.indexOf(val.trim().toUpperCase()) &gt; -1)
newHTML += &quot;&lt;span class=&#39;statement&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;
else if (keywords2.indexOf(val.trim().toLowerCase()) &gt; -1)
newHTML += &quot;&lt;span class=&#39;function&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;
else if (keywords3.indexOf(val.trim().toLowerCase()) &gt; -1)
newHTML += &quot;&lt;span class=&#39;directives&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;
else if (keywords4.indexOf(val.trim().toLowerCase()) &gt; -1)
newHTML += &quot;&lt;span class=&#39;lib&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;
else if (keywords5.indexOf(val.trim().toLowerCase()) &gt; -1)
newHTML += &quot;&lt;span class=&#39;ident&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;

else if (keywords6.indexOf(val.trim().toLowerCase()) &gt; -1)
newHTML += &quot;&lt;span class=&#39;numb&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;
else if (keywords7.indexOf(val.trim().toLowerCase()) &gt; -1)
newHTML += &quot;&lt;span class=&#39;strings&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;
else if (keywords8.indexOf(val.trim().toLowerCase()) &gt; -1)
newHTML += &quot;&lt;span class=&#39;comments&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;
else
newHTML += &quot;&lt;span class=&#39;other&#39;&gt;&quot; + val + &quot;&amp;nbsp;&lt;/span&gt;&quot;;
});
$(this).html(newHTML);

var child = $(this).children();
var range = document.createRange();
var sel = window.getSelection();
range.setStart(child[child.length-1], 1);
range.collapse(true);
sel.removeAllRanges();
sel.addRange(range);
this.focus();
}
});
