# 2025-09-09T16:24:29.394589
import vitis

client = vitis.create_client()
client.set_workspace(path="soc2024_2")

platform = client.get_component(name="platform_btn_fnd")
status = platform.build()

comp = client.get_component(name="app_btn_fnd")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

platform = client.get_component(name="platform_stopwatch")
status = platform.build()

comp = client.get_component(name="app_stopwatch")
comp.build()

platform = client.get_component(name="platform_txtlcd")
status = platform.build()

comp = client.get_component(name="app_txtlcd")
comp.build()

vitis.dispose()

