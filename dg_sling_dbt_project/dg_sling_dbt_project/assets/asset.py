from typing import Mapping
from dagster_sling import DagsterSlingTranslator, SlingResource, sling_assets
from dagster import Any, AssetIn, AssetExecutionContext, AssetKey, AssetSpec, asset, file_relative_path
from dagster_sling.asset_decorator import get_streams_from_replication
from dagster_dbt import DbtCliResource, dbt_assets
from ..resources.sling_resources import formula1_project
import os

replication_config = file_relative_path(__file__, "../../sling_replication.yaml")


class CustomDagsterSlingTranslator(DagsterSlingTranslator):
    def get_asset_spec(self, stream_definition: Mapping[str, Any]) -> AssetSpec:
        #print("Stream definition keys and values:", stream_definition)

        default_spec = super().get_asset_spec(stream_definition)

        stream_url = stream_definition.get("name", "default_name")
        stream_file_name = os.path.splitext(os.path.basename(stream_url))[0]
        #print(f'name: {stream_file_name}')

        desc = f"Load formula1 data for stream: {stream_file_name}"
        key = AssetKey(["Formula1_Dataset", stream_file_name])
        

        return default_spec.replace_attributes(
            group_name="Load_Data_From_Local_File",
            key = key,
            description = desc
        )



@sling_assets(
        replication_config=replication_config,
        dagster_sling_translator=CustomDagsterSlingTranslator()
        )
def sling_asset(context: AssetExecutionContext, sling: SlingResource):
    yield from sling.replicate(context=context)
    for row in sling.stream_raw_logs():
        context.log.info(row)


@dbt_assets(manifest = formula1_project.manifest_path)
def dbt_formula1_project(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()
