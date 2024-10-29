local dapy = require('dap-python')
-- If using the above, then `python3 -m debugpy --version`
-- must work in the shell

dapy.setup()
dapy.test_runner = 'pytest'
