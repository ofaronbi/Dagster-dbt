from dagster import Definitions, load_assets_from_modules
from .resources.sling_resources import sling_resources
from .assets import asset
from dagster_dbt import DbtCliResource


all_assets = load_assets_from_modules([asset])
dbt_resources = DbtCliResource(project_dir='../formula1_project')

defs = Definitions(
    assets=all_assets,
    resources={"sling": sling_resources(), "dbt":dbt_resources}
)