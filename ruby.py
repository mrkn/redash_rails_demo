import os
import sys
import subprocess
import tempfile

from redash.query_runner import *


class Ruby(BaseQueryRunner):
    @classmethod
    def configuration_schema(cls):
        return {
            'type': 'object',
            'properties': {
                'workdir': {
                    'type': 'string',
                    'title': 'Work directory'
                }
            },
            'required': ['workdir']
        }

    @classmethod
    def type(cls):
        return "insecure_script"


    def __init__(self, configuration):
        super(Ruby, self).__init__(configuration)
        self.syntax = "ruby"

    def test_connection(self):
        pass

    def run_query(self, query, user):
        try:
            json_data = None
            error = None

            query = query.strip()
            query = query.split('*/ ', 2)[1]
            print('--- begin query ---')
            print(query)
            print('--- end query ---')

            with tempfile.NamedTemporaryFile(delete=False, suffix='rb') as tf:
                tf.write(query)
                script_name = tf.name
            output = subprocess.check_output(['/usr/bin/ruby', script_name], stderr=subprocess.STDOUT)
            os.unlink(script_name)
            print('--- begin output ---')
            print(output)
            print('--- end output ---')
            if output is not None:
                output = output.strip()
                if output != "":
                    return output, None

            error = "Error reading output"
        except subprocess.CalledProcessError as e:
            return None, str(e)
        except KeyboardInterrupt:
            error = "Query cancelled by user."
            json_data = None
        except Exception as e:
            raise sys.exc_info()[1], None, sys.exc_info()[2]

        return json_data, error


register(Ruby)
