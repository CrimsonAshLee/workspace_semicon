# 2025-09-09T16:22:45.088952
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_stopwatch")
status = platform.build()

comp = client.get_component(name="app_stopwatch")
comp.build()

vitis.dispose()

