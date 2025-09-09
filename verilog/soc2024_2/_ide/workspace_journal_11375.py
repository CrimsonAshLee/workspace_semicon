# 2025-09-09T09:39:42.265707
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_dht11_iic")
status = platform.build()

comp = client.get_component(name="app_dht11_iic")
comp.build()

status = platform.build()

comp.build()

vitis.dispose()

