# Steps:

### 1\. Configure Keystone
Prior running: `terraform apply`, you have to enable TOTP in Keystone.  
TOTP is not enabled in Keystone by default. To enable it add the totp authentication method to the [auth] section in `keystone.conf` (default path in DevStack is `/etc/keystone/keystone.conf`):

``` bash
[auth]
methods = password,token,totp
```

Restart Keystone service:
```bash
sudo systemctl restart devstack@keystone.service
```

### 2\. Create a test user
Create user with MFA enabled by running `terraform apply`

### 3\. Configure TOTP (as admin)
Generate a secret.  
For a user to have access to TOTP, he must have configured TOTP credentials in Keystone and a TOTP device (i.e. Google Authenticator).  
TOTP uses a base32 encoded string for the secret. The secret must be at least 128 bits (16 bytes).  
Please replace the `12124587850015117` string in the following example by something secure and random:  

``` bash
USER_NAME="027-user-green"
export USER_ID=$(openstack user show $USER_NAME -c id -f value)
export SECRET=$(echo -n 12124587850015117 | base32 | tr -d =)
echo $SECRET
```
Example output:
`GEZDGNBVGY3TQOJQGEZDGNBVGY`


Register the secret in Keystone for that user, use the USER_ID from above:

``` bash
openstack credential create --type totp $USER_ID $SECRET
```

### 4\. Generate QR code from secret for user (as admin)

```
export QR_URI="otpauth://totp/$USER_NAME@openstack.org?secret=$SECRET&issuer=Keystone"
sudo apt install qrencode -y
echo -n "$QR_URI" | qrencode -t ANSIUTF8
```

Register the test user with the TOTP app (i.e. Google Authenticator) by scanning the image.

### 5\. Authenticate with TOTP (as user)

The following scripts and instructions are relevant to the user who aims to authenticate with MFA.

#### 5\.1 TOTP MFA Script

Open file `mfa-auth.sh` in the current directory and modify lines 3-8, to reflect your current environment and configurations. Save it.  
The script will export the retrieved token as `OS_TOKEN`, which the `openstack` client will pick up subsequently.  
You can check the retrieved token via `echo $OS_TOKEN`.  
However, to be able to properly use this token in the `openstack` client, another script is necessary to align the `OS_` variables correctly.  
If the variable with the token is empty, you can comment last line of script to see an error.

Run script `mfa-auth.sh`
```bash
source mfa-auth.sh
```

#### 5\.2 RC File

Run script `027-user-green.openrc`
```bash
source 027-user-green.openrc
```

This script will make sure that all `OS_` variables are aligned in a way that appeases the `openstack` client so that the usage of `OS_TOKEN` as the sole authentication for issuing commands becomes possible after acquiring said `OS_TOKEN` using the MFA process.

**NOTE:** the exact constellation of the `OS_` variables is absolutely important. Having extraneous or missing variables can make the `openstack` client trip up easily with non-obvious error patterns!


#### 5\.3 Usage

After `source`'ing both scripts, the authentication persists in the current shell session (within the `OS_TOKEN` environment variable) for as long as the token is valid (depends on the individual Keystone's token expiration setting).  
After its expiration, the process beginning with `source mfa-auth.sh` has to be repeated.

Check by running the following command:

```bash
openstack image list
```

### 6\. TOTP in Horizon

To activate TOTP support, you must have OpenStack version no earlier than 2023.2 (this feature was introduced in this release). 

Add to the end of the  `local_settings.py` Horizon settings file (for DevStack default installation parameters, the path is `/opt/stack/horizon/openstack_dashboard/local/local_settings.py`).  

```bash
OPENSTACK_KEYSTONE_MFA_TOTP_ENABLED = True
AUTHENTICATION_PLUGINS = [
    'openstack_auth.plugin.totp.TotpPlugin',
    'openstack_auth.plugin.password.PasswordPlugin',
    'openstack_auth.plugin.token.TokenPlugin'
]
```

Restart Apache service:
```bash
sudo service apache2 restart
```

References: 
- TOTP - https://docs.openstack.org/keystone/latest/admin/auth-totp.html#auth-totp
- Multi-Factor Authentication (admin) - https://docs.openstack.org/keystone/latest/admin/multi-factor-authentication.html
- Multi-Factor Authentication (user) - https://docs.openstack.org/keystone/latest/user/multi-factor-authentication.html
- Horizon  - Settings Reference - https://docs.openstack.org/horizon/latest/configuration/settings.html
- New in OpenStack Bobcat: Horizon team introduces time-based one-time password (TOTP) authentication support - https://www.openstack.org/blog/new-in-openstack-bobcat-horizon-team-introduces-time-based-one-time-password-totp-authentication-support