# Define base variables
$BoxSDK = "C:\Users\jfrank\Documents\Projects\BoxSDKV2\"
$BoxConfigPath = "C:\Users\jfrank\Documents\WindowsPowerShell\Scripts\Box\"
$JsonConfigFile = "config.json"
 
# Load Assemblies
[Reflection.Assembly]::LoadFile($BoxSDK + "System.IdentityModel.Tokens.Jwt.5.1.4\lib\net45\System.IdentityModel.Tokens.Jwt.dll") | Out-Null
[Reflection.Assembly]::LoadFile($BoxSDK + "BouncyCastle.1.8.1\lib\BouncyCastle.Crypto.dll") | Out-Null
[Reflection.Assembly]::LoadFile($BoxSDK + "Box.V2.3.3.0\lib\net45\Box.V2.dll") | Out-Null
[Reflection.Assembly]::LoadFile($BoxSDK + "Microsoft.IdentityModel.Logging.1.1.4\lib\net45\Microsoft.IdentityModel.Logging.dll") | Out-Null
[Reflection.Assembly]::LoadFile($BoxSDK + "Microsoft.IdentityModel.Tokens.5.1.4\lib\net45\Microsoft.IdentityModel.Tokens.dll") | Out-Null
[Reflection.Assembly]::LoadFile($BoxSDK + "Newtonsoft.Json.9.0.1\lib\net45\Newtonsoft.Json.dll") | Out-Null
[Reflection.Assembly]::LoadFile($BoxSDK + "Newtonsoft.Json.10.0.3\lib\net45\Newtonsoft.Json.dll") | Out-Null
 
 
# Load Configuration
$JsonConfig = Get-content $BoxConfigPath$JsonConfigFile | ConvertFrom-Json
$BoxConfig = New-Object -TypeName Box.V2.config.BoxConfig -ArgumentList $JsonConfig.boxAppSettings.clientID, $JsonConfig.boxAppSettings.clientSecret, $JsonConfig.enterpriseID, $JsonConfig.boxAppSettings.appAuth.privateKey, $JsonConfig.boxAppSettings.appAuth.passphrase, $JsonConfig.boxAppSettings.appAuth.publicKeyID
$BoxJWT = New-Object -TypeName Box.V2.JWTAuth.BoxJWTAuth -ArgumentList $BoxConfig
 
# Authenticate Service Account
$AdminToken = $BoxJWT.AdminToken()
$AdminClient = $BoxJWT.AdminClient($AdminToken)
 
# Get Root folder files
$AdminClient.FoldersManager.GetItemsAsync("0","100").Result.ItemCollection.Entries | Format-List
# Get Users
$AdminClient.UsersManager.GetEnterpriseUsersAsync().Result.Entries | Format-List
