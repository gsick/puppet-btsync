#
# Smoke test.
#
class {'btsync': webui_login => 'my_login', webui_pwd => 'my_password', api_key => 'my_api_key'}