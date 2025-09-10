# 2025-09-10T18:57:02.818791
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_stopwatch_min")
status = platform.build()

comp = client.get_component(name="app_stopwatch_min")
comp.build()

status = platform.build()

comp.build()

vitis.dispose()

