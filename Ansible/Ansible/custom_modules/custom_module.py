#!/usr/bin/python

DOCUMENTATION='''
---
module: custom debug
'''

EXAMPLES='''
# Example
custom_debug:
    msg: this is the message...
'''

# to create a custom module we need to create a python file for it to execute its commands

# import json as it will be output of this file
try:
    import json
except ImportError:
    import simplejson as json

# import ansible module library as we need to to create custom modules
from importlib.metadata import requires
from ansible.module_utils.basic import AnsibleModule
import time
import sys


def main():
    module = AnsibleModule(
        argument_spec: dict(
            msg = dict(required=True, type='str')
        )
    )
    
    msg = module.params['msg']
    

try:
    # successful exit
    module.exit_json(changed=True, msg='%s - %s' % (time.strftime("%c"), msg))
except:
    # fail exit
    module.fail_json(msg="Error Message")