# 2025-09-04T13:32:42.602881
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_fnd_cntr")
status = platform.build()

comp = client.get_component(name="app_fnd_cntr")
comp.build()

status = platform.build()

comp.build()

