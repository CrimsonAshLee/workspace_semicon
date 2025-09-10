# 2025-09-10T14:46:00.304733
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_stopwatch_addmin")
status = platform.build()

comp = client.get_component(name="app_stopwatch_addmin")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

