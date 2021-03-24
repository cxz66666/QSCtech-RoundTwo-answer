# 正则表达式



基础

Q1:

~~~
/^[aA]ndorid (?:1\.[0156]|2\.0|2\.0\.1|2\.1|2\.2|2\.2\.[1-3]|2\.3|2\.3\.[1-7]|3\.[012]|4\.[0-4]|4\.0\.[1-4]|4\.4w|5\.[01]|6\.0|[78]\.[01]|9\.0|[1-9](?:\.0)?|ICupcake|Donut|Éclair|Froyo|Gingerbread|Honeycomb|Ice Cream Sandwich|Jelly Bean|KitKat|Lollipop|Marshmallow|Nougat|Oreo|Pie|Q|P)$/
~~~

![image-20210321153434427](https://pic.raynor.top/images/2021/03/21/image-20210321153434427.png)





Q2:

~~~
^[+\-]?((?:0|[1-9]\d*)(?:\.\d*)?(?:[eE][+\-]?\d+)?|[1-9]\d{0,2}(,\d{3})*(?:\.\d*)?)$
~~~

![image-20210321162514337](https://pic.raynor.top/images/2021/03/21/image-20210321162514337.png)







进阶

Q1

~~~python
import re

while True:
    searchstr = input("input the phone number\n")
    res = re.search('(\d{3})', searchstr).group(0)
    print(res)
~~~



Q2：

~~~python
import re


nowstr = ['tom@hogwarts.com', 'tom.riddle@hogwarts.com',
'tom.riddle+regexone@hogwarts.com', 'tom@hogwarts.eu.com',
'potter@hogwarts.com', 'harry@hogwarts.com',
'hermione+regexone@hogwarts.com']

for searchstr in nowstr:
    res = re.match('([A-Za-z0-9._%-]+)(?:\+[A-Za-z0-9._%-]+)*@([A-Za-z0-9-]+)(?:\.[A-Za-z]{2,63})+', searchstr)
    print(res.group(1),res.group(2))
~~~

![image-20210321171549473](https://pic.raynor.top/images/2021/03/21/image-20210321171549473.png)





Q4

~~~python
import re


# prereg = '^(?!.*(?:documentation\.html|\.bash_profile|workspace\.doc|img0912\.jpg\.tmp|access\.lock))'
nextreg='^(\S+)\.(jpg|png|gif)$'
import re


nowstr = [ 'img0912.jpg', 'img0912.jpg',
'updated_img0912.png', 'favicon.gif', 'documentation.html213', 'documentation.html',
'.bash_profile','workspace.doc','img0912.jpg.tmp','access.lock'
]

for searchstr in nowstr:
    try:
        res = re.match(nextreg, searchstr)
        print(res.group(1),res.group(2))
    except:
        print("Not match")
    
        
~~~



Q5

~~~python
import re


regex='([a-zA-Z0-9@._%+-]+)://([a-zA-Z0-9@._%+-]*)(:\d+)?/'

nowstr = [
    'ftp://file_server.com:21/top_secret/life_changing_plans.pdf',
    'https://regexone.com/lesson/introduction#section',
    'file://localhost:4040/zip_file',
    'https://s3cur3-server.com:9999/',
    'market://search/angry%20birds',
]

for searchstr in nowstr:
    res = re.match(regex, searchstr)
    if (res != None):
        try:
            res = re.match(regex, searchstr)
            if (res.group(3) == None):
                print(res.group(1), res.group(2))
            else:     
                print(res.group(1),res.group(2),res.group(3))
        except:
            print("Irregular")
    else:
        print("Irregular")

~~~

Q6

~~~
import re


# prereg = '^(?!.*(?:W/dalvikvm\( 1553\): threadid=1: uncaught exception|E/\( 1553\): FATAL EXCEPTION: main|E/\( 1553\): java.lang.StringIndexOutOfBoundsException))'
nextreg='\s+at \w+\.\w+\.(\w+)\((\w+\.\w+):(\d+)\)'
import re


nowstr = [ 'E/( 1553):   at widget.List.makeView(ListView.java:1727)', 'E/( 1553):   at widget.List.fillDown(ListView.java:652)',
'E/( 1553):   at widget.List.fillFrom(ListView.java:709)', 'W/dalvikvm( 1553): threadid=1: uncaught exception', 'E/( 1553): FATAL EXCEPTION: main',
'E/( 1553): java.lang.StringIndexOutOfBoundsException'
]

for searchstr in nowstr:
    try:
        res = re.search(nextreg, searchstr)
        print(res.group(1),res.group(2),res.group(3))
    except:
        print("Not legal")
    


~~~

