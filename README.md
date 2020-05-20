# s3_coding_challenge

## Installation
On both Ubuntu 18.04 and MacOSX run the following:

### Install the aws cli command via pip
``` 
pip3 install --upgrade --user awscli
```

This will install the aws cli command line tool into *~/.local/bin* on Ubuntu or *~/Library/Python/3.7/bin* on MacOS.

You don't have to worry about the path's as I have added a little logic to the script to determine which Operating System you are running the PIP installed AWS CLI command line tool from. 

To install the script run the following shell command to download the script from GITHUB and make it executable on your Mac or Ubuntu system. 

### Install the buck_ls.sh script 
```
curl -L https://github.com/mcgonagle/s3_coding_challenge/tarball/master| tar zx 
cd mcgonagle*
chmod +x buck_ls.sh
```

### Setup the aws cli command
```
 aws configure   
```
Which will prompt you for the following credntials:
```
AWS Access Key ID [None]: 
AWS Secret Access Key [None]:  
Default region name [None]: 
Default output format [None]:
```
