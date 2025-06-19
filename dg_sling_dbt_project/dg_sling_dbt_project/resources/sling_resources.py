# pyright: reportCallIssue=none
from dagster_sling import SlingConnectionResource, SlingResource
from dagster import file_relative_path


class DbtProject:
    def __init__(self):
        self.manifest_path = file_relative_path(__file__, "../../../formula1_project/target/manifest.json")
        

formula1_project = DbtProject()

from dagster import EnvVar

def sling_resources():
    sling_res = SlingResource(
        connections=[
            # Using a connection string from an environment variable
            SlingConnectionResource(
                name="MySQL_conn",
                type="MySQL",
                #connection_string=EnvVar("MYSQL_URL"),
            )
        ]
        )
    return sling_res



